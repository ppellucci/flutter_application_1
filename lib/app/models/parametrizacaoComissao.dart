class ParametrizacaoComissao {
  int id;
  int corretorId;
  int seguradoraId;
  int metricaId;
  num porcentagemComissaoBase;
  num valorMin;
  num valorMax;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'corretorId': corretorId,
      'seguradoraId': seguradoraId,
      'metricaId': metricaId,
      'porcentagemComissaoBase': porcentagemComissaoBase,
      'valorMin': valorMin,
      'valorMax': valorMax
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  ParametrizacaoComissao();

  ParametrizacaoComissao.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'];
    corretorId = map['corretorId'];
    seguradoraId = map['seguradoraId'];
    metricaId = map['metricaId'];
    porcentagemComissaoBase = map['porcentagemComissaoBase'];
    valorMin = map['valorMin'];
    valorMax = map['valorMax'];
  }
}