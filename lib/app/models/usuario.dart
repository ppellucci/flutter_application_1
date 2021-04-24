class Usuario {
  int id;
  String nome;
  String email;
  String senha;
  String susep;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'nome': nome,
      'email': email,
      'senha': senha,
      'susep': susep,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  Usuario();

  Usuario.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
    email = map['email'];
    senha = map['senha'];
    susep = map['susep'];
  }
}