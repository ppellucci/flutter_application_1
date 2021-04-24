import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/app/areas/collector/views/collector_left_nav.dart';
import 'package:flutter_application_1/app/components/alerta_dialog.dart';
import 'package:flutter_application_1/app/models/insuranceCompany.dart';
import 'package:flutter_application_1/app/models/sale.dart';
import 'package:flutter_application_1/app/models/user.dart';
import 'package:flutter_application_1/app/repository/SalesProvider.dart';
import 'package:flutter_application_1/app/repository/UserProvider.dart';
import 'package:flutter_application_1/app/repository/UserState.dart';
import 'package:intl/intl.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class CreateSales extends StatefulWidget {
  @override
  _CreateSalesState createState() => _CreateSalesState();
}

class _CreateSalesState extends State<CreateSales> {
  UserProvider userDb = UserProvider();
  SalesProvider salesDb = SalesProvider();
  String name = '';
  int brokerId;
  int insuranceId;
  num price = 0.00;
  String createdDate = '';
  List<User> brokerList = [];
  UserState userState = UserState();
  TextEditingController createdDateController = TextEditingController();
  MoneyMaskedTextController priceController = MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.', leftSymbol: 'R\$');

  @override
  void initState() {
    super.initState();
    getBrokers().then((value) {
      brokerList = value;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        drawer: CollectorLeftNav(),
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
                      name = text;
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
                      items: brokerList
                          .map((broker) {
                        return DropdownMenuItem<int>(
                            value: broker.id, child: Text("${broker.name} (${broker.email})"));
                      }).toList(),
                      value: brokerId,
                      onChanged: (id) {
                        setState(() {
                          brokerId = id;
                        });
                      }),
                  DropdownButton<int>(
                      hint: Text("Selecione a Seguradora"),
                      items: InsuranceCompany.getInsuranceCompanies()
                          .map((insurance) {
                        return DropdownMenuItem<int>(
                            value: insurance.id, child: Text(insurance.name));
                      }).toList(),
                      value: insuranceId,
                      onChanged: (id) {
                        setState(() {
                          insuranceId = id;
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
                        createdDate = myFormat.format(date);
                        createdDateController.text = myFormat.format(date);  
                      }
                    },
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: priceController,
                    onChanged: (text) {
                      print(priceController.numberValue);
                      price = double.tryParse(priceController.numberValue.toString());
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Valor da venda',
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 15),
                  RaisedButton(
                    onPressed: () {
                      if (name != '') {
                        if (brokerId != 0) {
                          if (insuranceId != 0) {
                            if (price != null && price > 0.00) {
                              saveCadastro(name, brokerId, insuranceId,
                                  createdDate, price);
                              showDialogWithAlert(context,
                                  'Venda cadastrada com sucesso.', 'OK', () {
                                Navigator.of(context).pushReplacementNamed('/sales/add');
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

  void saveCadastro(String name, int brokerId, int insuranceId,
      String createdDate, num price) async {
    userState = await userState.getUserState();
    await salesDb.insert(Sale.fromMap({
      'name': name,
      'collectorId': userState.userId,
      'brokerId': brokerId,
      'insuranceId': insuranceId,
      'price': price,
      'createdDate': createdDate
    }));
  }

  Future<List<User>> getBrokers() async {
    return await userDb.getBySusep(true);
  }
}
