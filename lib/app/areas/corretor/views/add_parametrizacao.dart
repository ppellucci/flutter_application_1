import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/areas/corretor/views/corretor_left_nav.dart';
import 'package:flutter_application_1/app/areas/corretor/views/parametrizacao_angariacao.dart';
import 'package:flutter_application_1/app/components/alerta_dialog.dart';
import 'package:flutter_application_1/app/models/metrica.dart';
import 'package:flutter_application_1/app/models/seguradora.dart';
import 'package:flutter_application_1/app/repository/MetricaProvider.dart';
import 'package:flutter_application_1/app/repository/SeguradoraCorretorProvider.dart';
import 'package:flutter_application_1/app/repository/UsuarioState.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class AddParametrizacao extends StatefulWidget {
  @override
  _AddParametrizacaoState createState() => _AddParametrizacaoState();
}

class _AddParametrizacaoState extends State<AddParametrizacao> {
  MetricaProvider dbMetrica = MetricaProvider();
  SeguradoraCorretorProvider dbSeguradoraCorretorProvider =
      SeguradoraCorretorProvider();
  UsuarioState usuarioState = UsuarioState();
  int seguradoraId;
  int corretorId;
  num preco = 0.00;
  int qtdVendido;
  List<Seguradora> minhasSeguradoras = [];
  List<Metrica> minhasMetricas = [];
  MoneyMaskedTextController priceController = MoneyMaskedTextController(
      decimalSeparator: ',', thousandSeparator: '.', leftSymbol: 'R\$');

  @override
  void initState() {
    super.initState();

    getMinhasSeguradoras().then((value) {
      setState(() {
        minhasSeguradoras = value;
      });
    });

    getMinhasMetricas().then((value) {
      setState(() {
        minhasMetricas = value;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        drawer: CorretorLeftNav(),
        appBar: AppBar(title: Text('Adicionar minhas parametrizações')),
        body: Container(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
              child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(children: [
                    SizedBox(height: 10),
                    DropdownButton<int>(
                        hint: Text("Selecione a Seguradora"),
                        items: minhasSeguradoras.map((seguradora) {
                          return DropdownMenuItem<int>(
                              value: seguradora.id,
                              child: Text(seguradora.nome));
                        }).toList(),
                        value: seguradoraId,
                        onChanged: (id) {
                          setState(() {
                            seguradoraId = id;
                          });
                        }),
                    SizedBox(height: 15),
                    ParametrizacaoAngariacao(seguradoraId: seguradoraId),
                    // TextField(
                    //   controller: priceController,
                    //   onChanged: (text) {
                    //     print(priceController.numberValue);
                    //     preco = double.tryParse(
                    //         priceController.numberValue.toString());
                    //   },
                    //   keyboardType: TextInputType.number,
                    //   decoration: InputDecoration(
                    //       labelText: 'Valor do plano vendido',
                    //       border: OutlineInputBorder()),
                    // ),
                    // SizedBox(height: 15),
                    // TextField(
                    //   onChanged: (text) {
                    //     qtdVendido = int.parse(text);
                    //   },
                    //   keyboardType: TextInputType.text,
                    //   decoration: InputDecoration(
                    //       labelText: 'Quantidade vendido',
                    //       border: OutlineInputBorder()),
                    // ),
                    // SizedBox(height: 15),
                    // RaisedButton(
                    //   onPressed: () {
                    //     if (seguradoraId != 0) {
                    //       if (preco != 0) {
                    //         if (qtdVendido != 0) {
                    //           addMetrica(seguradoraId, preco, qtdVendido);
                    //           getMinhasMetricas().then((value) {
                    //             setState(() {
                    //               minhasMetricas = value;
                    //             });
                    //           });
                    //           showDialogWithAlert(context,
                    //               'Métrica cadastrada com sucesso.', 'OK', () {
                    //             Navigator.of(context).pop();
                    //           });
                    //         } else {
                    //           showDialogWithAlert(context,
                    //               'Favor adicionar uma Quantidade.', 'OK', () {
                    //             Navigator.of(context).pop();
                    //           });
                    //         }
                    //       } else {
                    //         showDialogWithAlert(
                    //             context, 'Favor adicionar um Valor.', 'OK', () {
                    //           Navigator.of(context).pop();
                    //         });
                    //       }
                    //     } else {
                    //       showDialogWithAlert(
                    //           context, 'Favor selecionar uma Seguradora.', 'OK',
                    //           () {
                    //         Navigator.of(context).pop();
                    //       });
                    //     }
                    //   },
                    //   child: Text('Adicionar'),
                    // ),
                    // SizedBox(height: 15),
                    // Text('Métricas cadastradas:'),
                    // SizedBox(height: 10),
                    // new Expanded(
                    //     child: ListView.builder(
                    //         itemCount: minhasMetricas.length,
                    //         itemBuilder: (context, index) {
                    //           return new Column(children: [
                    //             Text(getNomeSeguradoraById(
                    //                 minhasMetricas[index].seguradoraId)),
                    //             Text(
                    //                 'Qtd vendido: ${minhasMetricas[index].quantidadeVendido.toString()}'),
                    //             Text(
                    //                 'Valor do plano: ${minhasMetricas[index].valorPlano.toString()}'),
                    //             Row(children: [Expanded(child: Divider())])
                    //           ]);
                    //         }))
                  ]))),
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

  void addMetrica(int seguradoraId, num preco, int qtdVendido) async {
    usuarioState = await usuarioState.getUsuarioState();
    await dbMetrica.insert(Metrica.fromMap({
      'corretorId': usuarioState.id,
      'seguradoraId': seguradoraId,
      'valorPlano': preco,
      'quantidadeVendido': qtdVendido
    }));
  }

  Future<List<Seguradora>> getMinhasSeguradoras() async {
    usuarioState = await usuarioState.getUsuarioState();
    return await dbSeguradoraCorretorProvider.getByCorretor(usuarioState.id);
  }

  Future<List<Metrica>> getMinhasMetricas() async {
    usuarioState = await usuarioState.getUsuarioState();
    return await dbMetrica.getByCorretor(usuarioState.id);
  }

  String getNomeSeguradoraById(int id) {
    return minhasSeguradoras.singleWhere((s) => s.id == id).nome;
  }
}
