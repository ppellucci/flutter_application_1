
import 'package:flutter_application_1/app/models/seguradora.dart';
import 'package:flutter_application_1/app/models/seguradoraCorretor.dart';
import 'DbProvider.dart';

class SeguradoraCorretorProvider extends DbProvider {
  
  Future<List<SeguradoraCorretor>> getAll() async {
    if (db == null) {
      await open();
    }

    List<Map> maps = await db
        .query(seguradoraCorretorTable, columns: ['id', 'corretorId', 'seguradoraId']);

    List<SeguradoraCorretor> records = maps.map((e) => SeguradoraCorretor.fromMap(e)).toList();
    return records;
  }

  Future<List<Seguradora>> getByCorretor(int corretorId) async {
    if (db == null) {
      await open();
    }
    List<Seguradora> todasSeguradoras = Seguradora.getListaSeguradoras();
    List<Seguradora> minhasSeguradoras = new List<Seguradora>();
    var query = await db.query(seguradoraCorretorTable,
        columns: ['id', 'corretorId', 'seguradoraId'],
        where: "corretorId = ?",
        whereArgs: [corretorId]);
    if (query.length > 0) {
      for (var i = 0; i < query.length; i++) {
        var seguradora = todasSeguradoras.firstWhere((s) => s.id == query[i]['seguradoraId']);
        if (seguradora != null) {
          minhasSeguradoras.add(seguradora);
        }
      }
    }
    return minhasSeguradoras;
  }

  Future<SeguradoraCorretor> insert(SeguradoraCorretor seguradoraCorretor) async {
    if (db == null) {
      await open();
    }

    seguradoraCorretor.id = await db.insert(seguradoraCorretorTable, seguradoraCorretor.toMap());
    return seguradoraCorretor;
  }
}