class Venda {
  int id;
  String nomeCliente;
  int prepostoId;
  int corretorId;
  int seguradoraId;
  num preco;
  String dataDaVenda;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'nomeCliente': nomeCliente,
      'prepostoId': prepostoId,
      'corretorId': corretorId,
      'seguradoraId': seguradoraId,
      'preco': preco,
      'dataDaVenda': dataDaVenda
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  Venda();

  Venda.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'];
    nomeCliente = map['nomeCliente'];
    prepostoId = map['prepostoId'];
    corretorId = map['corretorId'];
    seguradoraId = map['seguradoraId'];
    preco = map['preco'];
    dataDaVenda = map['dataDaVenda'];
  }
}