class MetricaBonus {
  int id;
  int corretorId;
  int seguradoraId;
  num percentual;
  int qtdMeses;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'corretorId': corretorId,
      'seguradoraId': seguradoraId,
      'percentual': percentual,
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
    percentual = map['percentual'];
    qtdMeses = map['qtdMeses'];
  }
}