class SeguradoraCorretor {
  int id;
  int corretorId;
  int seguradoraId;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'corretorId': corretorId,
      'seguradoraId': seguradoraId
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  SeguradoraCorretor();

  SeguradoraCorretor.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'];
    corretorId = map['corretorId'];
    seguradoraId = map['seguradoraId'];
  }
}