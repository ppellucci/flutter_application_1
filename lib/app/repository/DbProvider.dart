import 'package:sqflite/sqflite.dart';

class DbProvider {
  String dbName = 'sistema.db';
  String vendaTable = 'Sales';
  String usuarioTable = 'Usuario';
  String seguradoraCorretorTable = 'SeguradoraCorretor';
  String metricaTable = 'Metrica';
  Database db;

  Future<void> close() async {
    await db?.close();
  }

  Future<void> open() async {
    db = await openDatabase(dbName, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''CREATE TABLE $usuarioTable (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  nome TEXT,
  email TEXT,
  senha TEXT,
  susep TEXT
)''');
      await db.execute('''CREATE TABLE $vendaTable (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  nome TEXT,
  prepostoId INT,
  corretorId INT,
  seguradoraId INT,
  preco REAL,
  dataDaVenda TEXT
)''');

await db.execute('''CREATE TABLE $seguradoraCorretorTable (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  corretorId INT,
  seguradoraId INT
)''');

await db.execute('''CREATE TABLE $metricaTable (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  corretorId INT,
  seguradoraId INT,
  valorPlano REAL,
  quantidadeVendido INT
)''');

    });
  }
}
