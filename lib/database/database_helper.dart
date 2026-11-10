import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import '../models/evento.dart';


class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if(_database != null) return _database!;

    _database = await _initDatabase();

    return _database!;
  }

    Future<List<Evento>> listarEventos(String termoPesquisa) async {
      final db = await database;

      final resultado = await db.query(
        'eventos',
        where: 'LOWER(nome) LIKE ?',
        whereArgs: ['%${termoPesquisa.toLowerCase()}%'],
        orderBy: 'id ASC',
      );

      return resultado.map((map) => Evento.fromMap(map)).toList();
    }

    Future<int> inserirEvento(Evento evento) async {
      final db = await database;

      return await db.insert('eventos', evento.toMap());
    }

    Future<int> atualizarEvento(Evento evento) async {
      final db = await database;

      return await db.update(
        'eventos', 
        evento.toMap(),
        where: 'id = ?',
        whereArgs: [evento.id],
      );
    }

    Future<int> excluirEvento(int id) async {
      final db = await database;

      return await db.delete(
        'eventos',
        where: 'id = ?',
        whereArgs: [id],
      );
    }
  }

  Future<Database> _initDatabase() async {
    final diretorio = await getApplicationDocumentsDirectory();

    final caminho = join(diretorio.path, 'vibra.db');

    return await databaseFactory.openDatabase(
      caminho,
      options: OpenDatabaseOptions(
        version: 1,

        onCreate: (db, version) async {
          await db.execute('''
          CREATE TABLE eventos (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nome TEXT NOT NULL,
          imagem TEXT NOT NULL,
          descricao TEXT NOT NULL,
          data TEXT NOT NULL,
          horario TEXT NOT NULL,
          local TEXT NOT NULL
          )
        ''');

        await db.insert('eventos', {
          'nome': 'Lana Del Rey | Festival',
          'imagem': 'assets/images/evento_lana_del_rey.png',
          'descricao': 'Uma noite de música pop e muita energia.',
          'data': '15.11.2027',
          'horario': '20:00',
          'local': 'Caçador/SC',
        });

        await db.insert('eventos', {
          'nome': 'Zara Larsson | Pop Tropical de Verão',
          'imagem': 'assets/images/evento_pop_tropical.png',
          'descricao': 'Prepare-se para uma noite inesquecível ao som de Lana Del Rey!',
          'data': '07.09.2027',
          'horario': '16:00',
          'local': 'Parque das Araucarias - Caçador/SC',
        });

        await db.insert('eventos', {
          'nome': 'Dua Lipa | Future Nostalgia',
          'imagem': 'assets/images/evento_future_nostalgia.png',
          'descricao': 'Uma experiência musical com grandes sucessos.',
          'data': '20.12.2027',
          'horario': '19:00',
          'local': 'Caçador/SC',
        });
        }
      )
    );
  }
