import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as ffi;
import 'package:vibra_eventos/database/database_helper.dart';
import 'package:vibra_eventos/models/convidado.dart';

void main() {
  setUpAll(() {
    ffi.sqfliteFfiInit();
    sqflite.databaseFactory = ffi.databaseFactoryFfi;
  });

  test('CRUD, total confirmado, persistência e tabela única', () async {
    final diretorio = await Directory.systemTemp.createTemp('vibra-crud-');
    final caminho = '${diretorio.path}${Platform.pathSeparator}vibra.db';
    var helper = DatabaseHelper(databasePath: caminho);

    expect(await helper.listarConvidados(), isEmpty);
    final id = await helper.inserirConvidado(const Convidado(
      nome: 'Ana Silva',
      acompanhantes: 2,
      confirmado: true,
    ));
    var convidados = await helper.listarConvidados();
    expect(convidados.single.nome, 'Ana Silva');
    expect(await helper.totalPessoasConfirmadas(), 3);

    await helper.atualizarConvidado(Convidado(
      id: id,
      nome: 'Ana Souza',
      acompanhantes: 1,
      confirmado: false,
    ));
    convidados = await helper.listarConvidados();
    expect(convidados.single.nome, 'Ana Souza');
    expect(await helper.totalPessoasConfirmadas(), 0);

    await helper.atualizarConvidado(Convidado(
      id: id,
      nome: 'Ana Souza',
      acompanhantes: 1,
      confirmado: true,
    ));
    expect(await helper.totalPessoasConfirmadas(), 2);
    await helper.close();

    helper = DatabaseHelper(databasePath: caminho);
    expect((await helper.listarConvidados()).single.nome, 'Ana Souza');
    await helper.excluirConvidado(id);
    expect(await helper.listarConvidados(), isEmpty);
    final tabelas = await (await helper.database).rawQuery(
      "SELECT name FROM sqlite_master WHERE type = 'table' AND name NOT LIKE 'sqlite_%'",
    );
    expect(tabelas.map((linha) => linha['name']), ['convidados']);

    await helper.close();
    await diretorio.delete(recursive: true);
  });

  test('migra o banco legado, mantém convidados reconhecíveis e remove eventos',
      () async {
    final diretorio = await Directory.systemTemp.createTemp('vibra-migracao-');
    final caminho = '${diretorio.path}${Platform.pathSeparator}vibra.db';
    final legado = await sqflite.databaseFactory.openDatabase(
      caminho,
      options: sqflite.OpenDatabaseOptions(
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
            CREATE TABLE eventos (
              id INTEGER PRIMARY KEY,
              nome TEXT NOT NULL,
              acompanhantes INTEGER NOT NULL,
              confirmado INTEGER NOT NULL
            )
          ''');
          await db.insert('eventos', {
            'id': 8,
            'nome': 'Bruno Costa',
            'acompanhantes': 1,
            'confirmado': 1,
          });
        },
      ),
    );
    await legado.close();

    final helper = DatabaseHelper(databasePath: caminho);
    final convidados = await helper.listarConvidados();
    expect(convidados.single.nome, 'Bruno Costa');
    expect(await helper.totalPessoasConfirmadas(), 2);
    final tabelas = await (await helper.database).rawQuery(
      "SELECT name FROM sqlite_master WHERE type = 'table' AND name NOT LIKE 'sqlite_%'",
    );
    expect(tabelas.map((linha) => linha['name']), ['convidados']);

    await helper.close();
    await diretorio.delete(recursive: true);
  });
}
