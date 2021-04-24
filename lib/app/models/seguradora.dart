class Seguradora {
  int id;
  String nome;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'nome': nome,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  Seguradora(this.id, this.nome);

  Seguradora.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
  }

  static List<Seguradora> getListaSeguradoras() {
    List<Seguradora> insuranceCompanies = [];
    insuranceCompanies.add(Seguradora(1, 'Prudential Seguros'));
    insuranceCompanies.add(Seguradora(2, 'Icatu Seguros'));
    insuranceCompanies.add(Seguradora(3, 'AIG'));
    insuranceCompanies.sort((a,b) => a.nome.compareTo(b.nome));
    return insuranceCompanies;
  }
}