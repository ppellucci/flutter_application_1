class Seguradora {
  int id;
  String nome;
  bool ativo;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'nome': nome,
      'ativo': ativo
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  Seguradora(this.id, this.nome, this.ativo);

  Seguradora.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
    ativo = map['ativo'];
  }

  static List<Seguradora> getListaSeguradoras() {
    List<Seguradora> insuranceCompanies = [];
    insuranceCompanies.add(Seguradora(1, 'Prudential Seguros', true));
    insuranceCompanies.add(Seguradora(2, 'Icatu Seguros', true));
    insuranceCompanies.add(Seguradora(3, 'AIG', true));
    // insuranceCompanies.add(Seguradora(4, 'Inativa', false));
    insuranceCompanies.sort((a,b) => a.nome.compareTo(b.nome));
    return insuranceCompanies;
  }

  // static List<Seguradora> getListaSeguradorasAtivas() {
  //   List<Seguradora> insuranceCompanies = [];
  //   insuranceCompanies.add(Seguradora(1, 'Prudential Seguros', true));
  //   insuranceCompanies.add(Seguradora(2, 'Icatu Seguros', true));
  //   insuranceCompanies.add(Seguradora(4, 'Inativa', false));
  //   insuranceCompanies = insuranceCompanies.where((i) => i.ativo).toList();
  //   insuranceCompanies.sort((a,b) => a.nome.compareTo(b.nome));
  //   return insuranceCompanies;
  // }
}