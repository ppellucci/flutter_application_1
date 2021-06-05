import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/areas/corretor/views/corretor_left_nav.dart';
import 'package:flutter_application_1/app/components/alerta_dialog.dart';
import 'package:flutter_application_1/app/models/metrica.dart';
import 'package:flutter_application_1/app/models/metricaBonus.dart';
import 'package:flutter_application_1/app/models/metricaComissao.dart';
import 'package:flutter_application_1/app/models/seguradora.dart';
import 'package:flutter_application_1/app/repository/MetricaProvider.dart';
import 'package:flutter_application_1/app/repository/SeguradoraCorretorProvider.dart';
import 'package:flutter_application_1/app/repository/UsuarioState.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_application_1/app/models/metricaAngariacao.dart';

class AddMetrica extends StatefulWidget {
  @override
  _AddMetricaState createState() => _AddMetricaState();
}

class _AddMetricaState extends State<AddMetrica> {
  MetricaProvider dbMetrica = MetricaProvider();
  SeguradoraCorretorProvider dbSeguradoraCorretorProvider =
      SeguradoraCorretorProvider();
  UsuarioState usuarioState = UsuarioState();
  int seguradoraId;
  int corretorId;

  int qtdVendido;
  List<Seguradora> minhasSeguradoras = [];
  Metrica metricaPorSeguradora = Metrica();
  MoneyMaskedTextController pctAngariacaoController = MoneyMaskedTextController(
      decimalSeparator: ',',
      thousandSeparator: '.',
      rightSymbol: '%',
      initialValue: 0.00);
  num pctAngariacao = 0.00;

  MoneyMaskedTextController pctBonusController = MoneyMaskedTextController(
      decimalSeparator: ',',
      thousandSeparator: '.',
      rightSymbol: '%',
      initialValue: 0.00);
  num pctBonus = 0.00;
  int qtdMesesBonus = 0;

  //decimalSeparator: ',', thousandSeparator: '.', leftSymbol: 'R\$');

  var baseComissaoTEC = <MoneyMaskedTextController>[];
  var qtdMesesTEC = <TextEditingController>[];
  var cards = <Card>[];

  Card createCard() {
    MoneyMaskedTextController baseComissaoController =
        MoneyMaskedTextController(
            decimalSeparator: ',',
            thousandSeparator: '.',
            rightSymbol: '%',
            initialValue: 0.00);
    var qtdMesesController = TextEditingController();
    baseComissaoTEC.add(baseComissaoController);
    qtdMesesTEC.add(qtdMesesController);
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Comissão ${cards.length + 1}'),
          TextField(
              controller: baseComissaoController,
              decoration: InputDecoration(labelText: 'Base comissão')),
          TextField(
              controller: qtdMesesController,
              decoration: InputDecoration(labelText: 'Número de meses'),
              keyboardType: TextInputType.number),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    cards.add(createCard());
    getMinhasSeguradoras().then((value) {
      setState(() {
        minhasSeguradoras = value;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CorretorLeftNav(),
      appBar: AppBar(title: Text('Adicionar minhas métricas')),
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
                            getMetricaPorSeguradora();
                          });
                        }),
                    SizedBox(height: 15),
                    Expanded(
                        child: Column(children: [
                      Text("Angariação"),
                      TextField(
                        controller: pctAngariacaoController,
                        onChanged: (text) {
                          print(pctAngariacaoController.numberValue);
                          pctAngariacao = double.tryParse(
                              pctAngariacaoController.numberValue.toString());
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'Porcentagem',
                            border: OutlineInputBorder()),
                      ),
                      SizedBox(height: 15),
                      Text('Comissão'),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: cards.length,
                        itemBuilder: (BuildContext context, int index) {
                          return cards[index];
                        },
                      ),
                      RaisedButton(
                        child: Text('Nova comissão'),
                        onPressed: () =>
                            setState(() => cards.add(createCard())),
                      ),
                      Text("Bônus"),
                      TextField(
                        controller: pctBonusController,
                        onChanged: (text) {
                          print(pctBonusController.numberValue);
                          pctBonus = double.tryParse(
                              pctBonusController.numberValue.toString());
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'Porcentagem',
                            border: OutlineInputBorder()),
                      ),
                      TextField(
                        onChanged: (text) {
                          qtdMesesBonus = int.parse(text);
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'Qtd Meses',
                            border: OutlineInputBorder()),
                      )
                    ])),
                    SizedBox(height: 15),
                    RaisedButton(
                      onPressed: () {
                        if (seguradoraId == 0 || seguradoraId == null) {
                          showDialogWithAlert(
                              context, 'Selecione uma seguradora.', 'OK', () {
                            Navigator.of(context).pop();
                          });
                        } else {
                          addMetricas();
                          showDialogWithAlert(
                              context, 'Métrica cadastrada com sucesso.', 'OK',
                              () {
                            Navigator.of(context).pop();
                          });
                        }
                      },
                      child: Text('Adicionar'),
                    ),
                    SizedBox(height: 15),
                    Text('Métricas cadastradas:'),
                    SizedBox(height: 10),
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
                  ])))),
    );
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

  void addMetricas() async {
    usuarioState = await usuarioState.getUsuarioState();

    if (pctAngariacao > 0) {
      await dbMetrica.insertAngariacao(MetricaAngariacao.fromMap({
        'corretorId': usuarioState.id,
        'seguradoraId': seguradoraId,
        'porcentagem': pctAngariacao
      }));
    }

    if (cards.length > 0) {
      for (var i = 0; i < cards.length; i++) {
        if (baseComissaoTEC[i].text != '' && qtdMesesTEC[i].text != '') {
          await dbMetrica.insertComissao(MetricaComissao.fromMap({
            'corretorId': usuarioState.id,
            'seguradoraId': seguradoraId,
            'ordem': i,
            'baseComissao': baseComissaoTEC[i].numberValue,
            'qtdMeses': int.parse(qtdMesesTEC[i].text)
          }));
        }
      }
    }

    if (pctBonus > 0) {
      await dbMetrica.insertBonus(MetricaBonus.fromMap({
        'corretorId': usuarioState.id,
        'seguradoraId': seguradoraId,
        'porcentagem': pctBonus,
        'qtdMeses': qtdMesesBonus
      }));
    }
  }

  Future<List<Seguradora>> getMinhasSeguradoras() async {
    usuarioState = await usuarioState.getUsuarioState();
    return await dbSeguradoraCorretorProvider.getByCorretor(usuarioState.id);
  }

  void getMetricaPorSeguradora() async {
    usuarioState = await usuarioState.getUsuarioState();
    Metrica metrica = await dbMetrica.getByCorretorAndSeguradora(
        usuarioState.id, seguradoraId);
    if (metrica != null) {
      if (metrica.angariacao != null && metrica.angariacao.porcentagem != 0) {
        // pctAngariacaoController.numberValue = metrica.angariacao.porcentagem;
      }
    }
  }

  String getNomeSeguradoraById(int id) {
    return minhasSeguradoras.singleWhere((s) => s.id == id).nome;
  }
}
