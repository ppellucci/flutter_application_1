class MetricaAngariacao {
  int id;
  int corretorId;
  int seguradoraId;
  num porcentagem;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'corretorId': corretorId,
      'seguradoraId': seguradoraId,
      'porcentagem': porcentagem
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  MetricaAngariacao();

  MetricaAngariacao.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'];
    corretorId = map['corretorId'];
    seguradoraId = map['seguradoraId'];
    porcentagem = map['porcentagem'];
  }
}