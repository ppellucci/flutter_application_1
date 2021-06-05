
import 'package:flutter_application_1/app/models/parametrizacao.dart';
import 'package:flutter_application_1/app/models/parametrizacaoAngariacao.dart';
import 'package:flutter_application_1/app/models/parametrizacaoBonus.dart';
import 'package:flutter_application_1/app/models/parametrizacaoComissao.dart';

import 'DbProvider.dart';

class ParametrizacaoProvider extends DbProvider {
  // Future<List<ParametrizacaoAngariacao>> getAllAngariacao() async {
  //   if (db == null) {
  //     await open();
  //   }

  //   List<Map> maps = await db.query(parametrizacaoAngariacaoTable,
  //       columns: ['id', 'corretorId', 'seguradoraId', 'porcentagem']);

  //   List<MetricaAngariacao> records =
  //       maps.map((e) => MetricaAngariacao.fromMap(e)).toList();
  //   return records;
  // }

  // Future<List<MetricaComissao>> getAllComissao() async {
  //   if (db == null) {
  //     await open();
  //   }

  //   List<Map> maps = await db.query(metricaComissaoTable,
  //       columns: ['id', 'corretorId', 'order', 'baseComissao', 'qtdMeses']);

  //   List<MetricaComissao> records =
  //       maps.map((e) => MetricaComissao.fromMap(e)).toList();
  //   return records;
  // }

  // Future<List<MetricaBonus>> getAllBonus() async {
  //   if (db == null) {
  //     await open();
  //   }

  //   List<Map> maps = await db.query(metricaBonusTable,
  //       columns: ['id', 'corretorId', 'porcentagem', 'qtdMeses']);

  //   List<MetricaBonus> records =
  //       maps.map((e) => MetricaBonus.fromMap(e)).toList();
  //   return records;
  // }

  Future<ParametrizacaoAngariacao> getAngariacaoByCorretorAndSeguradoraAndMetrica(
      int corretorId, int seguradoraId, int metricaId) async {
    if (db == null) {
      await open();
    }

    ParametrizacaoAngariacao angariacao = new ParametrizacaoAngariacao();
    var query = await db.query(parametrizacaoAngariacaoTable,
        columns: ['id', 'corretorId', 'seguradoraId', 'metricaId', 'quantidade'],
        where: "corretorId = ? and seguradoraId = ? and metricaId = ?",
        whereArgs: [corretorId, seguradoraId, metricaId]);
    if (query.length > 0) {
      angariacao = ParametrizacaoAngariacao.fromMap(query.first);
    }
    return angariacao;
  }

  Future<List<ParametrizacaoComissao>> getComissoesByCorretorAndSeguradoraAndMetrica(
      int corretorId, int seguradoraId, int metricaId) async {
        if (db == null) {
      await open();
    }
    List<ParametrizacaoComissao> comissoes = new List<ParametrizacaoComissao>();
    var query = await db.query(parametrizacaoComissaoTable,
        columns: [
          'id',
          'corretorId',
          'seguradoraId',
          'metricaId',
          'porcentagemComissaoBase',
          'valorMin',
          'valorMax'
        ],
        where: "corretorId = ? and seguradoraId = ? and metricaId = ?",
        whereArgs: [corretorId, seguradoraId, metricaId]);
    if (query.length > 0) {
      for (var i = 0; i < query.length; i++) {
        comissoes.add(new ParametrizacaoComissao.fromMap(query[i]));
      }
    }
    return comissoes;
  }

  Future<List<ParametrizacaoBonus>> getBonusByCorretorAndSeguradoraAndMetrica(
      int corretorId, int seguradoraId, int metricaId) async {
        if (db == null) {
      await open();
    }
    List<ParametrizacaoBonus> bonus = new List<ParametrizacaoBonus>();
    var query = await db.query(metricaBonusTable,
        columns: ['id', 'corretorId', 'seguradoraId', 'metricaId', 'porcentagemComissao', 'valorMin', 'valorMax'],
        where: "corretorId = ? and seguradoraId = ? and metricaId = ?",
        whereArgs: [corretorId, seguradoraId, metricaId]);
    if (query.length > 0) {
      for (var i = 0; i < query.length; i++) {
        bonus.add(new ParametrizacaoBonus.fromMap(query[i]));
      }
    }
    return bonus;
  }

  Future<Parametrizacao> getByCorretorAndSeguradoraAndMetrica(
      int corretorId, int seguradoraId, int metricaId) async {
    Parametrizacao parametrizacao = new Parametrizacao();
    parametrizacao.seguradoraId = seguradoraId;
    parametrizacao.corretorId = corretorId;
    parametrizacao.angariacao =
        await getAngariacaoByCorretorAndSeguradoraAndMetrica(corretorId, seguradoraId, metricaId);
    parametrizacao.comissoes =
        await getComissoesByCorretorAndSeguradoraAndMetrica(corretorId, seguradoraId, metricaId);
    parametrizacao.bonus =
        await getBonusByCorretorAndSeguradoraAndMetrica(corretorId, seguradoraId, metricaId);
    return parametrizacao;
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

  Future<ParametrizacaoAngariacao> insertAngariacao(ParametrizacaoAngariacao angariacao) async {
    if (db == null) {
      await open();
    }

    angariacao.id = await db.insert(parametrizacaoAngariacaoTable, angariacao.toMap());
    return angariacao;
  }

  Future<ParametrizacaoComissao> insertComissao(ParametrizacaoComissao comissao) async {
    if (db == null) {
      await open();
    }

    comissao.id = await db.insert(parametrizacaoComissaoTable, comissao.toMap());
    return comissao;
  }

  Future<ParametrizacaoBonus> insertBonus(ParametrizacaoBonus bonus) async {
    if (db == null) {
      await open();
    }

    bonus.id = await db.insert(parametrizacaoBonusTable, bonus.toMap());
    return bonus;
  }
}