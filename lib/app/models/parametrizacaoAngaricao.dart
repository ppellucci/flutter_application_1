class ParametrizacaoAngaricao {
  int id;
  int corretorId;
  int seguradoraId;
  num percentualAngariacao;
  int quantidade;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'corretorId': corretorId,
      'seguradoraId': seguradoraId,
      'percentualAngariacao': percentualAngariacao,
      'quantidade': quantidade
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  ParametrizacaoAngaricao();

  ParametrizacaoAngaricao.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'];
    corretorId = map['corretorId'];
    seguradoraId = map['seguradoraId'];
    percentualAngariacao = map['percentualAngariacao'];
    quantidade = map['quantidade'];
  }
}