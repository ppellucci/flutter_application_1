class Metrica {
  int id;
  int corretorId;
  int seguradoraId;
  num valorPlano;
  int quantidadeVendido;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'corretorId': corretorId,
      'seguradoraId': seguradoraId,
      'valorPlano': valorPlano,
      'quantidadeVendido': quantidadeVendido
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  Metrica();

  Metrica.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'];
    corretorId = map['corretorId'];
    seguradoraId = map['seguradoraId'];
    valorPlano = map['valorPlano'];
    quantidadeVendido = map['quantidadeVendido'];
  }
}