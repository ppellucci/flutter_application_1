import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/components/alerta_dialog.dart';
import 'package:flutter_application_1/app/models/user.dart';
import 'package:flutter_application_1/app/repository/UserProvider.dart';

class CreateUser extends StatefulWidget {
  @override
  _CreateUsuarioState createState() => _CreateUsuarioState();
}

class _CreateUsuarioState extends State<CreateUsuarioState> {
  UsuarioProvider data = UsuarioProvider();
  bool isBroker = false;
  String email = '';
  String name = '';
  String password = '';
  String susep = '';

  @override
  Widget build(BuildContext context) {
    return Material(
        child: ListView(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Text(
                  'Preencha o formulário abaixo para se cadastrar no sistema.'),
              SizedBox(height: 10),
              TextField(
                onChanged: (text) {
                  name = text;
                },
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    labelText: 'Nome Completo', border: OutlineInputBorder()),
              ),
              SizedBox(height: 15),
              TextField(
                onChanged: (text) {
                  email = text;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: 'E-mail', border: OutlineInputBorder()),
              ),
              SizedBox(height: 15),
              TextField(
                onChanged: (text) {
                  password = text;
                },
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                    labelText: 'Senha', border: OutlineInputBorder()),
              ),
              SizedBox(height: 15),
              CheckboxListTile(
                title: Text("Sou um corretor"),
                controlAffinity: ListTileControlAffinity.leading,
                value: isBroker,
                onChanged: (bool newValue) {
                  setState(() {
                    isBroker = newValue;
                  });
                },
              ),
              Visibility(
                visible: isBroker,
                child: TextField(
                  onChanged: (text) {
                    susep = text;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: 'SUSEP', border: OutlineInputBorder()),
                ),
              ),
              SizedBox(height: 15),
              RaisedButton(
                onPressed: () {
                  if (name != '') {
                    if (!isBroker || (isBroker && susep != '')) {
                      if (email != '') {
                        if (password != '') {
                          saveCadastro(name, email, password, susep);
                          showDialogWithAlert(
                              context, 'Cadastro efetuado com sucesso.', 'OK',
                              () {
                            Navigator.of(context).pushReplacementNamed('/');
                          });
                        } else {
                          showDialogWithAlert(
                              context, 'Favor preencher o campo Senha.', 'OK',
                              () {
                            Navigator.of(context).pop();
                          });
                        }
                      } else {
                        showDialogWithAlert(
                            context, 'Favor preencher o campo E-mail.', 'OK',
                            () {
                          Navigator.of(context).pop();
                        });
                      }
                    } else {
                      showDialogWithAlert(
                          context, 'Favor preencher o campo SUSEP.', 'OK', () {
                        Navigator.of(context).pop();
                      });
                    }
                  } else {
                    showDialogWithAlert(
                        context, 'Favor preencher o campo Nome Completo.', 'OK',
                        () {
                      Navigator.of(context).pop();
                    });
                  }
                },
                child: Text('Cadastrar'),
              )
            ],
          ),
        ),
      )
    ]));
  }

  Future showDialogWithAlert(BuildContext context, String text,
      String buttonText, Function onPressed) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertaDialog(
              text: text, buttonText: buttonText, onPressed: onPressed);
        });
  }

  void saveCadastro(
      String name, String email, String password, String susep) async {
    await data.insert(Usuario.fromMap(
        {'name': name, 'email': email, 'password': password, 'susep': susep}));
  }
}
