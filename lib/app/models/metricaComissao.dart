class MetricaComissao {
  int id;
  int corretorId;
  int seguradoraId;
  int ordem;
  num baseComissao;
  int qtdMeses;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'corretorId': corretorId,
      'seguradoraId': seguradoraId,
      'ordem': ordem,
      'baseComissao': baseComissao,
      'qtdMeses': qtdMeses
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  MetricaComissao();

  MetricaComissao.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'];
    corretorId = map['corretorId'];
    seguradoraId = map['seguradoraId'];
    ordem = map['ordem'];
    baseComissao = map['baseComissao'];
    qtdMeses = map['qtdMeses'];
  }
}