import 'package:shared_preferences/shared_preferences.dart';

class UsuarioState {
  String nome = '';
  String email = '';
  int id;

  Future<void> setUsuarioState({String nome, String email, int id}) async {
    await SharedPreferences.getInstance().then((prefs) {
      prefs.setString("nome", nome);
      prefs.setString("email", email);
      prefs.setInt("id", id);
    });
  }

  Future<UsuarioState> getUsuarioState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.nome = prefs.getString("nome");
    this.email = prefs.getString("email");
    this.id = prefs.getInt("id");
    return this;
  }
}
