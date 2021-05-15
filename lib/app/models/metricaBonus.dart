class MetricaBonus {
  int id;
  int corretorId;
  int seguradoraId;
  num porcentagem;
  int qtdMeses;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'corretorId': corretorId,
      'seguradoraId': seguradoraId,
      'porcentagem': porcentagem,
      'qtdMeses': qtdMeses
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  MetricaBonus();

  MetricaBonus.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'];
    corretorId = map['corretorId'];
    seguradoraId = map['seguradoraId'];
    porcentagem = map['porcentagem'];
    qtdMeses = map['qtdMeses'];
  }
}