import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/areas/corretor/views/add_parametrizacao.dart';
import 'package:flutter_application_1/app/components/alerta_dialog.dart';
import 'package:flutter_application_1/app/repository/UsuarioState.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class ParametrizacaoAngariacao extends StatefulWidget {
  final int seguradoraId;

  const ParametrizacaoAngariacao({Key key, this.seguradoraId})
      : super(key: key);

  @override
  _ParametrizacaoAngariacaoState createState() =>
      _ParametrizacaoAngariacaoState(this.seguradoraId);
}

class _ParametrizacaoAngariacaoState extends State<ParametrizacaoAngariacao> {
  int numPagamentos;
  num percentual = 0.00;
  final int seguradoraId;
  UsuarioState usuarioState = UsuarioState();
  
  MoneyMaskedTextController porcentoController = MoneyMaskedTextController(
      decimalSeparator: ',', thousandSeparator: '.', rightSymbol: '%', );

  _ParametrizacaoAngariacaoState(this.seguradoraId);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ExpansionTile(
      title: Text(
        "Angariação",
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.yellow[50],
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                TextField(
                      controller: porcentoController,
                      onChanged: (text) {
                        print(porcentoController.numberValue);
                        percentual = double.tryParse(
                            porcentoController.numberValue.toString());
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Porcentagem',
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      onChanged: (text) {
                        numPagamentos = int.parse(text);
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: 'Número de pagamentos',
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(height: 10),
                    RaisedButton(
                      onPressed: () {
                        if (percentual != 0) {
                          if (numPagamentos != 0) {
                              addParametrizacao(seguradoraId, percentual, numPagamentos);
                              // getMinhasMetricas().then((value) {
                              //   setState(() {
                              //     minhasMetricas = value;
                              //   });
                              // });
                              showDialogWithAlert(context,
                                  'Métrica cadastrada com sucesso.', 'OK', () {
                                Navigator.of(context).pop();
                              });
                              } else {
                              showDialogWithAlert(context,
                                  'Favor adicionar o número de pagamentos.', 'OK', () {
                                Navigator.of(context).pop();
                              });
                            }
                        } else {
                          showDialogWithAlert(context,
                                  'Favor adicionar o percentual do pagamento.', 'OK', () {
                                Navigator.of(context).pop();
                              });
                        }
                      })
            ]),
          ),
        ),
      ],
    ));
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

  void addParametrizacao(int seguradoraId, num percentual, int qtdPagamentos) async {
    // usuarioState = await usuarioState.getUsuarioState();
    // await dbMetrica.insert(Metrica.fromMap({
    //   'corretorId': usuarioState.id,
    //   'seguradoraId': seguradoraId,
    //   'valorPlano': preco,
    //   'quantidadeVendido': qtdVendido
    // }));
  }
}
