import 'package:flutter_application_1/app/models/metrica.dart';
import 'package:flutter_application_1/app/models/metricaAngariacao.dart';
import 'package:flutter_application_1/app/models/metricaBonus.dart';
import 'package:flutter_application_1/app/models/metricaComissao.dart';

import 'DbProvider.dart';

class MetricaProvider extends DbProvider {
  Future<List<MetricaAngariacao>> getAllAngariacao() async {
    if (db == null) {
      await open();
    }

    List<Map> maps = await db.query(metricaAngariacaoTable,
        columns: ['id', 'corretorId', 'seguradoraId', 'porcentagem']);

    List<MetricaAngariacao> records =
        maps.map((e) => MetricaAngariacao.fromMap(e)).toList();
    return records;
  }

  Future<List<MetricaComissao>> getAllComissao() async {
    if (db == null) {
      await open();
    }

    List<Map> maps = await db.query(metricaComissaoTable,
        columns: ['id', 'corretorId', 'order', 'baseComissao', 'qtdMeses']);

    List<MetricaComissao> records =
        maps.map((e) => MetricaComissao.fromMap(e)).toList();
    return records;
  }

  Future<List<MetricaBonus>> getAllBonus() async {
    if (db == null) {
      await open();
    }

    List<Map> maps = await db.query(metricaComissaoTable,
        columns: ['id', 'corretorId', 'percentual', 'qtdMeses']);

    List<MetricaBonus> records =
        maps.map((e) => MetricaBonus.fromMap(e)).toList();
    return records;
  }

  Future<MetricaAngariacao> getAngariacaoByCorretorAndSeguradora(
      int corretorId, int seguradoraId) async {
    if (db == null) {
      await open();
    }

    MetricaAngariacao angariacao = new MetricaAngariacao();
    var query = await db.query(metricaAngariacaoTable,
        columns: ['id', 'corretorId', 'seguradoraId', 'porcentagem'],
        where: "corretorId = ? and seguradoraId = ?",
        whereArgs: [corretorId, seguradoraId]);
    if (query.length > 0) {
      angariacao = MetricaAngariacao.fromMap(query.first);
    }
    return angariacao;
  }

  Future<List<MetricaComissao>> getComissoesByCorretorAndSeguradora(
      int corretorId, int seguradoraId) async {
        if (db == null) {
      await open();
    }
    List<MetricaComissao> comissoes = new List<MetricaComissao>();
    var query = await db.query(metricaComissaoTable,
        columns: [
          'id',
          'corretorId',
          'seguradoraId',
          'ordem',
          'baseComissao',
          'qtdMeses'
        ],
        where: "corretorId = ? and seguradoraId = ?",
        whereArgs: [corretorId, seguradoraId]);
    if (query.length > 0) {
      for (var i = 0; i < query.length; i++) {
        comissoes.add(new MetricaComissao.fromMap(query[i]));
      }
    }
    return comissoes;
  }

  Future<List<MetricaBonus>> getBonusByCorretorAndSeguradora(
      int corretorId, int seguradoraId) async {
        if (db == null) {
      await open();
    }
    List<MetricaBonus> bonus = new List<MetricaBonus>();
    var query = await db.query(metricaComissaoTable,
        columns: ['id', 'corretorId', 'seguradoraId', 'percentual', 'qtdMeses'],
        where: "corretorId = ? and seguradoraId = ?",
        whereArgs: [corretorId, seguradoraId]);
    if (query.length > 0) {
      for (var i = 0; i < query.length; i++) {
        bonus.add(new MetricaBonus.fromMap(query[i]));
      }
    }
    return bonus;
  }

  Future<Metrica> getByCorretorAndSeguradora(
      int corretorId, int seguradoraId) async {
    Metrica metrica = new Metrica();
    metrica.seguradoraId = seguradoraId;
    metrica.corretorId = corretorId;
    metrica.angariacao =
        await getAngariacaoByCorretorAndSeguradora(corretorId, seguradoraId);
    metrica.comissoes =
        await getComissoesByCorretorAndSeguradora(corretorId, seguradoraId);
    metrica.bonus =
        await getBonusByCorretorAndSeguradora(corretorId, seguradoraId);
    return metrica;
  }

  // Future<Metrica> getByCorretor(int corretorId) async {
  //   if (db == null) {
  //     await open();
  //   }

  //   Metrica metrica = new Metrica();
  //   metrica.corretorId = corretorId;
  //   metrica.angariacao =
  //       await getAngariacaoByCorretorAndSeguradora(corretorId);
  //   metrica.comissoes =
  //       await getComissoesByCorretorAndSeguradora(corretorId);
  //   metrica.bonus =
  //       await getBonusByCorretorAndSeguradora(corretorId);
  //   return metrica;
  // }

  Future<MetricaAngariacao> insertAngariacao(MetricaAngariacao angariacao) async {
    if (db == null) {
      await open();
    }

    angariacao.id = await db.insert(metricaAngariacaoTable, angariacao.toMap());
    return angariacao;
  }

  Future<MetricaComissao> insertComissao(MetricaComissao comissao) async {
    if (db == null) {
      await open();
    }

    comissao.id = await db.insert(metricaComissaoTable, comissao.toMap());
    return comissao;
  }

  Future<MetricaBonus> insertBonus(MetricaBonus bonus) async {
    if (db == null) {
      await open();
    }

    bonus.id = await db.insert(metricaAngariacaoTable, bonus.toMap());
    return bonus;
  }
}