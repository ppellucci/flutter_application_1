
import 'package:flutter_application_1/app/models/usuario.dart';
import 'DbProvider.dart';

class UsuarioProvider extends DbProvider {
  
  Future<List<Usuario>> getAll() async {
    if (db == null) {
      await open();
    }

    List<Map> maps = await db
        .query(usuarioTable, columns: ['id', 'nome', 'email', 'senha', 'susep']);

    List<Usuario> records = maps.map((e) => Usuario.fromMap(e)).toList();
    return records;
  }

  Future<Usuario> getByEmailAndSenha(String email, String senha) async {
    if (db == null) {
      await open();
    }
    var user = await db.query(usuarioTable,
        columns: ['id', 'nome', 'email', 'senha', 'susep'],
        where: 'email = ? AND senha = ?',
        whereArgs: [email, senha]);
    if (user.length > 0) {
      return Usuario.fromMap(user.first);
    }
    return null;
  }

  Future<List<Usuario>> getBySusep(bool hasSusep) async {
    if (db == null) {
      await open();
    }
    List<Usuario> users = new List<Usuario>();
    var query = await db.query(usuarioTable,
        columns: ['id', 'nome', 'email'],
        where: hasSusep ? "susep != ''" : "susep = ''");
    if (query.length > 0) {
      for (var i = 0; i < query.length; i++) {
        users.add(new Usuario.fromMap(query[i]));
      }
    }
    return users;
  }

  Future<Usuario> insert(Usuario user) async {
    if (db == null) {
      await open();
    }

    user.id = await db.insert(usuarioTable, user.toMap());
    return user;
  }
}