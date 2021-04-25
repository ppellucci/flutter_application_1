import 'package:flutter_application_1/app/models/metrica.dart';
import 'DbProvider.dart';

class MetricaProvider extends DbProvider {
  Future<List<Metrica>> getAll() async {
    if (db == null) {
      await open();
    }

    List<Map> maps = await db.query(metricaTable, columns: [
      'id',
      'corretorId',
      'seguradoraId',
      'valorPlano',
      'quantidadeVendido'
    ]);

    List<Metrica> records = maps.map((e) => Metrica.fromMap(e)).toList();
    return records;
  }

  Future<List<Metrica>> getByCorretorAndSeguradora(
      int corretorId, int seguradoraId) async {
    if (db == null) {
      await open();
    }

    List<Metrica> metricas = new List<Metrica>();
    var query = await db.query(metricaTable,
        columns: [
          'id',
          'corretorId',
          'seguradoraId',
          'valorPlano',
          'quantidadeVendido'
        ],
        where: "corretorId = ? and seguradoraId = ?",
        whereArgs: [corretorId, seguradoraId]);
    if (query.length > 0) {
      for (var i = 0; i < query.length; i++) {
        metricas.add(new Metrica.fromMap(query[i]));
      }
    }
    return metricas;
  }

  Future<List<Metrica>> getByCorretor(int corretorId) async {
    if (db == null) {
      await open();
    }

    List<Metrica> metricas = new List<Metrica>();
    var query = await db.query(metricaTable,
        columns: [
          'id',
          'corretorId',
          'seguradoraId',
          'valorPlano',
          'quantidadeVendido'
        ],
        where: "corretorId = ?",
        whereArgs: [corretorId]);
    if (query.length > 0) {
      for (var i = 0; i < query.length; i++) {
        metricas.add(new Metrica.fromMap(query[i]));
      }
    }
    return metricas;
  }

  Future<Metrica> insert(Metrica metrica) async {
    if (db == null) {
      await open();
    }

    metrica.id = await db.insert(metricaTable, metrica.toMap());
    return metrica;
  }
}