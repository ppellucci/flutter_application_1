import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/models/usuario.dart';
import 'package:flutter_application_1/app/repository/UsuarioProvider.dart';
import 'package:flutter_application_1/app/repository/UsuarioState.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UsuarioProvider data = UsuarioProvider();
  UsuarioState userState = UsuarioState();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                onChanged: (text) {
                  email = text;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: 'Email', border: OutlineInputBorder()),
              ),
              SizedBox(height: 10),
              TextField(
                onChanged: (text) {
                  password = text;
                },
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'Senha', border: OutlineInputBorder()),
              ),
              SizedBox(height: 15),
              RaisedButton(
                onPressed: () {
                  validateUserLogin(email, password).then((result) {
                    if (result != null) {
                      saveLoginState(result);
                      if (result.susep == '') {
                        Navigator.of(context).pushReplacementNamed('/collector/home');
                      }
                      else {
                        Navigator.of(context).pushReplacementNamed('/broker/home');
                      }
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Text('Email ou Senha incorretos.'),
                              actions: [
                                FlatButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    })
                              ],
                            );
                          });
                    }
                  });
                },
                child: Text('Entrar'),
              ),
              SizedBox(height: 20),
              InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/usuario/create');
                  },
                  child: Text('Quero me cadastrar',
                      style: TextStyle(color: Colors.blue)))
            ],
          )),
    ));
  }

  Future<Usuario> validateUserLogin(String email, String senha) async {
    if (email != '' && senha != '') {
      return await data.getByEmailAndSenha(email, senha);
    }
    return null;
  }

  Future<void> saveLoginState(Usuario user) async {
    await userState.setUsuarioState(nome: user.nome, email: user.email, id: user.id);
  }
}
