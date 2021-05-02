class ParametrizacaoBonus {
  int id;
  int corretorId;
  int seguradoraId;
  int metricaId;
  num percentualComissao;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'corretorId': corretorId,
      'seguradoraId': seguradoraId,
      'metricaId': metricaId,
      'percentualComissao': percentualComissao
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  ParametrizacaoBonus();

  ParametrizacaoBonus.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'];
    corretorId = map['corretorId'];
    seguradoraId = map['seguradoraId'];
    metricaId = map['metricaId'];
    percentualComissao = map['percentualComissao'];
  }
}