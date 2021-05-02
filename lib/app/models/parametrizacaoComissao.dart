class ParametrizacaoComissao {
  int id;
  int corretorId;
  int seguradoraId;
  num percentualComissao;
  int quantidade;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'corretorId': corretorId,
      'seguradoraId': seguradoraId,
      'percentualComissao': percentualComissao,
      'quantidade': quantidade
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
    percentualComissao = map['percentualComissao'];
    quantidade = map['quantidade'];
  }
}