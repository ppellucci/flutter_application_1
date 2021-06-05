class ParametrizacaoAngariacao {
  int id;
  int corretorId;
  int seguradoraId;
  int metricaId;
  int quantidade;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'corretorId': corretorId,
      'seguradoraId': seguradoraId,
      'metricaId': metricaId,
      'quantidade': quantidade
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  ParametrizacaoAngariacao();

  ParametrizacaoAngariacao.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'];
    corretorId = map['corretorId'];
    seguradoraId = map['seguradoraId'];
    metricaId = map['metricaId'];
    quantidade = map['quantidade'];
  }
}