import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/app/areas/preposto/views/preposto_left_nav.dart';
import 'package:flutter_application_1/app/components/alerta_dialog.dart';
import 'package:flutter_application_1/app/models/seguradora.dart';
import 'package:flutter_application_1/app/models/venda.dart';
import 'package:flutter_application_1/app/models/usuario.dart';
import 'package:flutter_application_1/app/repository/VendaProvider.dart';
import 'package:flutter_application_1/app/repository/UsuarioProvider.dart';
import 'package:flutter_application_1/app/repository/UsuarioState.dart';
import 'package:intl/intl.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class CreateVenda extends StatefulWidget {
  @override
  _CreateVendaState createState() => _CreateVendaState();
}

class _CreateVendaState extends State<CreateVenda> {
  UsuarioProvider userDb = UsuarioProvider();
  VendaProvider salesDb = VendaProvider();
  String nome = '';
  int corretorId;
  int seguradoraId;
  num preco = 0.00;
  String dataDaVenda = '';
  List<Usuario> listaCorretores = [];
  UsuarioState userState = UsuarioState();
  TextEditingController createdDateController = TextEditingController();
  MoneyMaskedTextController priceController = MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.', leftSymbol: 'R\$');

  @override
  void initState() {
    super.initState();
    getBrokers().then((value) {
      listaCorretores = value;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        drawer: PrepostoLeftNav(),
        appBar: AppBar(title: Text('Adicionar uma nova venda')),
        body: Container(
            child: ListView(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(height: 10),
                  TextField(
                    onChanged: (text) {
                      nome = text;
                    },
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        labelText: 'Nome completo do cliente',
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 15),
                  // FutureBuilder<List<User>>(
                  //     future: getBrokers(),
                  //     builder: (context, users) {
                  //       if (users.connectionState == ConnectionState.done) {
                  //         return DropdownButton<int>(
                  //             hint: Text("Selecione o Corretor"),
                  //             items: users.data.map((User user) {
                  //               return DropdownMenuItem<int>(
                  //                   value: user.id,
                  //                   child: Text(
                  //                       user.name + ' (' + user.email + ')'));
                  //             }).toList(),
                  //             value: brokerId,
                  //             onChanged: (id) {
                  //               setState(() {
                  //                 brokerId = id;
                  //               });
                  //             });
                  //       }
                  //       return CircularProgressIndicator();
                  //     }),
                  DropdownButton<int>(
                      hint: Text("Selecione o Corretor"),
                      items: listaCorretores
                          .map((corretor) {
                        return DropdownMenuItem<int>(
                            value: corretor.id, child: Text("${corretor.nome} (${corretor.email})"));
                      }).toList(),
                      value: corretorId,
                      onChanged: (id) {
                        setState(() {
                          corretorId = id;
                        });
                      }),
                  DropdownButton<int>(
                      hint: Text("Selecione a Seguradora"),
                      items: Seguradora.getListaSeguradoras()
                          .map((seguradora) {
                        return DropdownMenuItem<int>(
                            value: seguradora.id, child: Text(seguradora.nome));
                      }).toList(),
                      value: seguradoraId,
                      onChanged: (id) {
                        setState(() {
                          seguradoraId = id;
                        });
                      }),
                  TextFormField(
                    controller: createdDateController,
                    readOnly: true,
                    decoration: InputDecoration(
                        labelText: 'Data da venda',
                        border: OutlineInputBorder()),
                    onTap: () async {
                      DateTime date = DateTime.now();
                      FocusScope.of(context).requestFocus(new FocusNode());
                      var myFormat = DateFormat('dd/MM/yyyy');
                      date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2100));
                      if (date != null) { 
                        dataDaVenda = myFormat.format(date);
                        createdDateController.text = myFormat.format(date);  
                      }
                    },
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: priceController,
                    onChanged: (text) {
                      print(priceController.numberValue);
                      preco = double.tryParse(priceController.numberValue.toString());
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Valor da venda',
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 15),
                  RaisedButton(
                    onPressed: () {
                      if (nome != '') {
                        if (corretorId != 0) {
                          if (seguradoraId != 0) {
                            if (preco != null && preco > 0.00) {
                              saveCadastro(nome, seguradoraId, corretorId,
                                  dataDaVenda, preco);
                              showDialogWithAlert(context,
                                  'Venda cadastrada com sucesso.', 'OK', () {
                                Navigator.of(context).pushReplacementNamed('/venda/add');
                              });
                            } else {
                              showDialogWithAlert(
                                  context, 'Favor preencher o valor.', 'OK',
                                  () {
                                Navigator.of(context).pop();
                              });
                            }
                          } else {
                            showDialogWithAlert(
                                context, 'Favor selecionar a seguradora.', 'OK',
                                () {
                              Navigator.of(context).pop();
                            });
                          }
                        } else {
                          showDialogWithAlert(
                              context, 'Favor selecionar o corretor.', 'OK',
                              () {
                            Navigator.of(context).pop();
                          });
                        }
                      } else {
                        showDialogWithAlert(context,
                            'Favor preencher o campo Nome Completo.', 'OK', () {
                          Navigator.of(context).pop();
                        });
                      }
                    },
                    child: Text('Cadastrar venda'),
                  )
                ],
              ),
            ),
          )
        ])));
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

  void saveCadastro(String nome, int corretorId, int seguradoraId,
      String dataDaVenda, num preco) async {
    userState = await userState.getUsuarioState();
    await salesDb.insert(Venda.fromMap({
      'nome': nome,
      'prepostoId': userState.id,
      'corretorId': corretorId,
      'seguradoraId': seguradoraId,
      'preco': preco,
      'dataDaVenda': dataDaVenda
    }));
  }

  Future<List<Usuario>> getBrokers() async {
    return await userDb.getBySusep(true);
  }
}
