import 'package:sqflite/sqflite.dart';

class DbProvider {
  String dbName = 'sistema.db';
  String vendaTable = 'Sales';
  String usuarioTable = 'Usuario';
  String seguradoraCorretorTable = 'SeguradoraCorretor';
  String metricaAngariacaoTable = 'MetricaAngariacao';
  String metricaComissaoTable = 'MetricaComissao';
  String metricaBonusTable = 'MetricaBonus';
  String parametrizacaoAngariacaoTable = 'ParametrizacaoAngariacao';
  String parametrizacaoComissaoTable = 'ParametrizacaoComissao';
  String parametrizacaoBonusTable = 'ParametrizacaoBonus';
  Database db;

  Future<void> close() async {
    await db?.close();
  }

  Future<void> open() async {
    db = await openDatabase(dbName, version: 1,
        onCreate: (Database db, int version) async {

/* Usuario */

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

/* SeguradoraCorretor */
await db.execute('''CREATE TABLE $seguradoraCorretorTable (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  corretorId INT,
  seguradoraId INT
)''');

/* Metrica */
await db.execute('''CREATE TABLE $metricaAngariacaoTable (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  corretorId INT,
  seguradoraId INT,
  porcentagem REAL
)''');

await db.execute('''CREATE TABLE $metricaComissaoTable (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  corretorId INT,
  seguradoraId INT,
  ordem INT,
  baseComissao REAL,
  qtdMeses INT
)''');

await db.execute('''CREATE TABLE $metricaBonusTable (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  corretorId INT,
  seguradoraId INT,
  porcentagem REAL,
  qtdMeses INT
)''');

/* Parametrizacao */
await db.execute('''CREATE TABLE $parametrizacaoAngariacaoTable (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  corretorId INT,
  seguradoraId INT,
  metricaId INT,
  quantidade INT
)''');

await db.execute('''CREATE TABLE $parametrizacaoComissaoTable (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  corretorId INT,
  seguradoraId INT,
  metricaId INT,
  porcentagemComissaoBase REAL,
  valorMin REAL,
  valorMax REAL
)''');

await db.execute('''CREATE TABLE $parametrizacaoBonusTable (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  corretorId INT,
  seguradoraId INT,
  metricaId INT,
  porcentagemComissao REAL,
  valorMin REAL,
  valorMax REAL
)''');

    });
  }
}
