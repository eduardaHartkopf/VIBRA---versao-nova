import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/convidado.dart';

class DatabaseHelper {
  DatabaseHelper({String? databasePath}) : _databasePath = databasePath;

  static final DatabaseHelper instance = DatabaseHelper();
  static const _nomeBanco = 'vibra.db';
  static const _versaoBanco = 2;
  final String? _databasePath;
  Future<Database>? _databaseFuture;

  Future<Database> get database => _databaseFuture ??= _abrirBanco();

  Future<Database> _abrirBanco() async {
    final caminho = _databasePath ??
        join((await getApplicationDocumentsDirectory()).path, _nomeBanco);
    return databaseFactory.openDatabase(
      caminho,
      options: OpenDatabaseOptions(
        version: _versaoBanco,
        onCreate: (db, version) => _criarTabelaConvidados(db),
        onUpgrade: (db, oldVersion, newVersion) async {
          await _migrarParaConvidados(db);
        },
      ),
    );
  }

  Future<void> _criarTabelaConvidados(DatabaseExecutor db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS convidados (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        acompanhantes INTEGER NOT NULL DEFAULT 0,
        confirmado INTEGER NOT NULL DEFAULT 0,
        evento_id INTEGER,
        evento_nome TEXT
      )
    ''');
  }

  Future<void> _migrarParaConvidados(Database db) async {
    final tabelas = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type = 'table' AND name NOT LIKE 'sqlite_%'",
    );
    final nomesTabelas = tabelas.map((row) => row['name'] as String).toSet();

    await _criarTabelaConvidados(db);

    // Migra somente linhas que tenham os campos de convidado. A tabela eventos
    // da versão anterior não os possuía, portanto seus eventos não viram pessoas.
    if (nomesTabelas.contains('eventos')) {
      final colunas = await db.rawQuery('PRAGMA table_info(eventos)');
      final nomesColunas = colunas.map((row) => row['name'] as String).toSet();
      if ({'nome', 'acompanhantes', 'confirmado'}
          .every(nomesColunas.contains)) {
        final temEventoId = nomesColunas.contains('evento_id');
        final temEventoNome = nomesColunas.contains('evento_nome');
        await db.execute('''
          INSERT INTO convidados (nome, acompanhantes, confirmado, evento_id, evento_nome)
          SELECT nome, acompanhantes, confirmado,
            ${temEventoId ? 'evento_id' : 'NULL'},
            ${temEventoNome ? 'evento_nome' : 'NULL'}
          FROM eventos
        ''');
      }
      await db.execute('DROP TABLE eventos');
    }

    // A versão entregue mantém uma única tabela de aplicação.
    for (final nome in nomesTabelas.where((nome) => nome != 'convidados')) {
      await db.execute('DROP TABLE IF EXISTS ${_identificadorSeguro(nome)}');
    }
  }

  String _identificadorSeguro(String nome) => '"${nome.replaceAll('"', '""')}"';

  Future<List<Convidado>> listarConvidados() async {
    final db = await database;
    final linhas = await db.query('convidados', orderBy: 'nome COLLATE NOCASE');
    return linhas.map(Convidado.fromMap).toList();
  }

  Future<int> inserirConvidado(Convidado convidado) async {
    final db = await database;
    return db.insert('convidados', convidado.toMap());
  }

  Future<int> atualizarConvidado(Convidado convidado) async {
    final id = convidado.id;
    if (id == null) throw ArgumentError('Convidado sem identificador.');
    final db = await database;
    return db.update(
      'convidados',
      convidado.toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> excluirConvidado(int id) async {
    final db = await database;
    return db.delete('convidados', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> totalPessoasConfirmadas() async {
    final db = await database;
    final resultado = await db.rawQuery('''
      SELECT COALESCE(SUM(1 + acompanhantes), 0) AS total
      FROM convidados
      WHERE confirmado = 1
    ''');
    return Sqflite.firstIntValue(resultado) ?? 0;
  }

  Future<void> close() async {
    final database = await _databaseFuture;
    await database?.close();
    _databaseFuture = null;
  }
}
