class ParametrizacaoBonus {
  int id;
  int corretorId;
  int seguradoraId;
  int metricaId;
  num porcentagemComissao;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'corretorId': corretorId,
      'seguradoraId': seguradoraId,
      'metricaId': metricaId,
      'porcentagemComissao': porcentagemComissao
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
    porcentagemComissao = map['porcentagemComissao'];
  }
}