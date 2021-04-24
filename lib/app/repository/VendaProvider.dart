
import 'package:flutter_application_1/app/models/venda.dart';
import 'package:sqflite/sqflite.dart';
import 'DbProvider.dart';

class VendaProvider extends DbProvider {
  
  Future<List<Venda>> getAll() async {
    if (db == null) {
      await open();
    }

    List<Map> maps = await db
        .query(vendaTable, columns: ['id', 'nome', 'prepostoId', 'corretorId', 'seguradoraId', 'preco', 'dataDaVenda']);

    List<Venda> records = maps.map((e) => Venda.fromMap(e)).toList();
    return records;
  }

  Future<int> getCountVendasByPrepostoId(int prepostoId) async {
    if (db == null) {
      await open();
    }

    var count = Sqflite.firstIntValue(await db.rawQuery("SELECT COUNT(*) FROM $vendaTable WHERE PrepostoId = ?", [prepostoId]));
    print(count);
    return count;
  }

  Future<Venda> insert(Venda sale) async {
    if (db == null) {
      await open();
    }
    sale.id = await db.insert(vendaTable, sale.toMap());
    return sale;
  }
}