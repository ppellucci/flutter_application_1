import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/areas/corretor/views/corretor_left_nav.dart';
import 'package:flutter_application_1/app/components/alerta_dialog.dart';
import 'package:flutter_application_1/app/models/metrica.dart';
import 'package:flutter_application_1/app/models/parametrizacaoAngariacao.dart';
import 'package:flutter_application_1/app/models/parametrizacaoBonus.dart';
import 'package:flutter_application_1/app/models/parametrizacaoComissao.dart';
import 'package:flutter_application_1/app/models/seguradora.dart';
import 'package:flutter_application_1/app/repository/MetricaProvider.dart';
import 'package:flutter_application_1/app/repository/ParametrizacaoProvider.dart';
import 'package:flutter_application_1/app/repository/SeguradoraCorretorProvider.dart';
import 'package:flutter_application_1/app/repository/UsuarioState.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class AddParametrizacao extends StatefulWidget {
  @override
  _AddParametrizacaoState createState() => _AddParametrizacaoState();
}

class _AddParametrizacaoState extends State<AddParametrizacao> {
  MetricaProvider dbMetrica = MetricaProvider();
  ParametrizacaoProvider dbParametrizacao = ParametrizacaoProvider();
  SeguradoraCorretorProvider dbSeguradoraCorretorProvider =
      SeguradoraCorretorProvider();
  UsuarioState usuarioState = UsuarioState();
  int seguradoraId;
  int corretorId;
  Metrica metrica = Metrica();

  int qtdVendido;
  List<Seguradora> minhasSeguradoras = [];
  Metrica metricaPorSeguradora = Metrica();

  int qtdMesesAngariacao = 0;

  //decimalSeparator: ',', thousandSeparator: '.', leftSymbol: 'R\$');

  var porcentagemComissaoBaseTEC = <MoneyMaskedTextController>[];
  var valorMinimoTEC = <MoneyMaskedTextController>[];
  var valorMaximoTEC = <MoneyMaskedTextController>[];

  var porcentagemBonusTEC = <MoneyMaskedTextController>[];
  var valorMinimoBonusTEC = <MoneyMaskedTextController>[];
  var valorMaximoBonusTEC = <MoneyMaskedTextController>[];
  // var cards = <Card>[];
  List<List<Card>> metricaCards;
  var bonusCard = <Card>[];

  void iniciaCards() {
    if (metrica.comissoes != null && metrica.comissoes.length > 0) {
      metricaCards = List.generate(
          metrica.comissoes.length, (i) => List<Card>(),
          growable: true);
      for (var i = 0; i < metrica.comissoes.length; i++) {
        metricaCards[i]
            .add(createParametrizacaoPorComissao(metrica.comissoes[i].id));
      }
    }
    if (metrica.bonus != null) {
      bonusCard.add(createBonus());
    }
  }

  Column createMetrica(int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
            'Base comissão: ${metrica.comissoes[index].baseComissao}% - Meses: ${metrica.comissoes[index].qtdMeses}'),
        ListView.builder(
            shrinkWrap: true,
            itemCount: metricaCards[index].length,
            itemBuilder: (BuildContext context, int j) {
              return metricaCards[index][j];
            }),
        RaisedButton(
            child: Text('Nova Parametrização da Base ${index + 1}'),
            onPressed: () => {
                  setState(() => metricaCards[index].add(
                      createParametrizacaoPorComissao(
                          metrica.comissoes[index].id)))
                }),
      ],
    );
  }

  Card createParametrizacaoPorComissao(int metricaId) {
    MoneyMaskedTextController porcentagemComissaoBaseController =
        MoneyMaskedTextController(
            decimalSeparator: ',',
            thousandSeparator: '.',
            rightSymbol: '%',
            initialValue: 0.00);
    MoneyMaskedTextController valorMinimoController = MoneyMaskedTextController(
        decimalSeparator: ',',
        thousandSeparator: '.',
        leftSymbol: 'R\$',
        initialValue: 0.00);
    MoneyMaskedTextController valorMaximoController = MoneyMaskedTextController(
        decimalSeparator: ',',
        thousandSeparator: '.',
        leftSymbol: 'R\$',
        initialValue: 0.00);
    porcentagemComissaoBaseTEC.add(porcentagemComissaoBaseController);
    valorMinimoTEC.add(valorMinimoController);
    valorMaximoTEC.add(valorMaximoController);
    return Card(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TextField(
            controller: porcentagemComissaoBaseController,
            decoration:
                InputDecoration(labelText: 'Porcentagem da base de comissão')),
        TextField(
            controller: valorMinimoController,
            decoration: InputDecoration(labelText: 'Valor mínimo'),
            keyboardType: TextInputType.number),
        TextField(
            controller: valorMaximoController,
            decoration: InputDecoration(labelText: 'Valor máximo'),
            keyboardType: TextInputType.number),
      ],
    ));
  }

  Card createBonus() {
    MoneyMaskedTextController porcentagemBonusController =
        MoneyMaskedTextController(
            decimalSeparator: ',',
            thousandSeparator: '.',
            rightSymbol: '%',
            initialValue: 0.00);
    MoneyMaskedTextController valorMinimoController = MoneyMaskedTextController(
        decimalSeparator: ',',
        thousandSeparator: '.',
        leftSymbol: 'R\$',
        initialValue: 0.00);
    MoneyMaskedTextController valorMaximoController = MoneyMaskedTextController(
        decimalSeparator: ',',
        thousandSeparator: '.',
        leftSymbol: 'R\$',
        initialValue: 0.00);
    porcentagemBonusTEC.add(porcentagemBonusController);
    valorMinimoBonusTEC.add(valorMinimoController);
    valorMaximoBonusTEC.add(valorMaximoController);

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Bônus ${bonusCard.length + 1}'),
          TextField(
              controller: porcentagemBonusController,
              decoration: InputDecoration(labelText: 'Comissão extra')),
          TextField(
              controller: valorMinimoController,
              decoration: InputDecoration(labelText: 'Valor mínimo de venda'),
              keyboardType: TextInputType.number),
          TextField(
              controller: valorMaximoController,
              decoration: InputDecoration(labelText: 'Valor máximo de venda'),
              keyboardType: TextInputType.number),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // cards.add(createCard());
    getMinhasSeguradoras().then((value) {
      setState(() {
        minhasSeguradoras = value;
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
                              getMetricaPorSeguradora();
                            });
                          }),
                      SizedBox(height: 10),
                      metrica == null || metrica.angariacao == null
                          ? Text("Sem angariação.")
                          : Column(children: [
                              Text(
                                  'Angariação de ${metrica.angariacao.porcentagem}%. Valor dividido em quantos meses?'),
                              SizedBox(height: 5),
                              SizedBox(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width,
                                  child: TextField(
                                    onChanged: (text) {
                                      qtdMesesAngariacao = int.parse(text);
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        labelText: 'Qtd Meses',
                                        border: OutlineInputBorder()),
                                  ))
                            ]),
                      SizedBox(height: 10),
                      metrica == null ||
                              metrica.comissoes == null ||
                              metrica.comissoes.length == 0
                          ? Text("Sem comissões.")
                          : new Expanded(
                              child: ListView.builder(
                                  itemCount: metrica.comissoes.length,
                                  itemBuilder: (context, index) {
                                    return createMetrica(index);
                                  })),
                      SizedBox(height: 10),
                      metrica == null || metrica.bonus == null
                          ? Text("Sem Bônus.")
                          :
                          // Column(
                          //   mainAxisSize: MainAxisSize.min,
                          //   children: [

                          Text(
                              'Bônus - Base: ${metrica.bonus.porcentagem}%. Aplicado a cada ${metrica.bonus.qtdMeses} meses'),
                      new Expanded(
                          child: ListView.builder(
                        itemCount: bonusCard.length,
                        itemBuilder: (BuildContext context, int index) {
                          return bonusCard[index];
                        },
                      )),
                      RaisedButton(
                        child: Text('Novo bônus'),
                        onPressed: () =>
                            setState(() => bonusCard.add(createBonus())),
                      ), //]),
                      SizedBox(height: 15),
                      RaisedButton(
                        onPressed: () {
                          if (seguradoraId == 0 || seguradoraId == null) {
                            showDialogWithAlert(
                                context, 'Selecione uma seguradora.', 'OK', () {
                              Navigator.of(context).pop();
                            });
                          } else {
                            addParametrizacoes();
                            showDialogWithAlert(
                                context,
                                'Parametrizações cadastradas com sucesso.',
                                'OK', () {
                              Navigator.of(context).pop();
                            });
                          }
                        },
                        child: Text('Adicionar'),
                      ),
                    ])))));

    // Expanded(
    //     child: Column(children: [
    //   Text("Angariação"),
    //   TextField(
    //     controller: pctAngariacaoController,
    //     onChanged: (text) {
    //       print(pctAngariacaoController.numberValue);
    //       pctAngariacao = double.tryParse(
    //           pctAngariacaoController.numberValue.toString());
    //     },
    //     keyboardType: TextInputType.number,
    //     decoration: InputDecoration(
    //         labelText: 'Porcentagem',
    //         border: OutlineInputBorder()),
    //   ),
    //   SizedBox(height: 15),
    //   Text('Comissão'),
    //   Expanded(
    //     child: ListView.builder(
    //       shrinkWrap: true,
    //       itemCount: cards.length,
    //       itemBuilder: (BuildContext context, int index) {
    //         return cards[index];
    //       },
    //     ),
    //   ),
    //   RaisedButton(
    //     child: Text('Nova comissão'),
    //     onPressed: () =>
    //         setState(() => cards.add(createCard())),
    //   ),
    //   Text("Bônus"),
    //   TextField(
    //     controller: pctBonusController,
    //     onChanged: (text) {
    //       print(pctBonusController.numberValue);
    //       pctBonus = double.tryParse(
    //           pctBonusController.numberValue.toString());
    //     },
    //     keyboardType: TextInputType.number,
    //     decoration: InputDecoration(
    //         labelText: 'Porcentagem',
    //         border: OutlineInputBorder()),
    //   ),
    //   TextField(
    //     onChanged: (text) {
    //       qtdMesesBonus = int.parse(text);
    //     },
    //     keyboardType: TextInputType.number,
    //     decoration: InputDecoration(
    //         labelText: 'Qtd Meses',
    //         border: OutlineInputBorder()),
    //   )
    // ])),
    // SizedBox(height: 15),
    // RaisedButton(
    //   onPressed: () {
    //     if (seguradoraId == 0 || seguradoraId == null) {
    //       showDialogWithAlert(
    //           context, 'Selecione uma seguradora.', 'OK', () {
    //         Navigator.of(context).pop();
    //       });
    //     } else {
    //       addMetricas();
    //       showDialogWithAlert(
    //           context, 'Métrica cadastrada com sucesso.', 'OK',
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

  // void addMetricas() async {
  //   usuarioState = await usuarioState.getUsuarioState();

  //   if (pctAngariacao > 0) {
  //     await dbMetrica.insertAngariacao(MetricaAngariacao.fromMap({
  //       'corretorId': usuarioState.id,
  //       'seguradoraId': seguradoraId,
  //       'porcentagem': pctAngariacao
  //     }));
  //   }

  //   if (cards.length > 0) {
  //     for (var i = 0; i < cards.length; i++) {
  //       if (baseComissaoTEC[i].text != '' && qtdMesesTEC[i].text != '') {
  //         await dbMetrica.insertComissao(MetricaComissao.fromMap({
  //           'corretorId': usuarioState.id,
  //           'seguradoraId': seguradoraId,
  //           'ordem': i,
  //           'baseComissao': baseComissaoTEC[i].numberValue,
  //           'qtdMeses': int.parse(qtdMesesTEC[i].text)
  //         }));
  //       }
  //     }
  //   }

  //   if (pctBonus > 0) {
  //     await dbMetrica.insertBonus(MetricaBonus.fromMap({
  //       'corretorId': usuarioState.id,
  //       'seguradoraId': seguradoraId,
  //       'porcentagem': pctBonus,
  //       'qtdMeses': qtdMesesBonus
  //     }));
  //   }
  // }

  Future<List<Seguradora>> getMinhasSeguradoras() async {
    usuarioState = await usuarioState.getUsuarioState();
    return await dbSeguradoraCorretorProvider.getByCorretor(usuarioState.id);
  }

  void getMetricaPorSeguradora() async {
    usuarioState = await usuarioState.getUsuarioState();
    var metr = await dbMetrica.getByCorretorAndSeguradora(
        usuarioState.id, seguradoraId);
    setState(() {
      metrica = metr;
      iniciaCards();
    });
  }

  void addParametrizacoes() async {
    usuarioState = await usuarioState.getUsuarioState();

    if (metrica != null) {
      if (metrica.angariacao != null) {
        dbParametrizacao.insertAngariacao(ParametrizacaoAngariacao.fromMap({
          'corretorId': usuarioState.id,
          'seguradoraId': seguradoraId,
          'metricaId': metrica.angariacao.id,
          'quantidade': qtdMesesAngariacao
        }));
      }
      if (metrica.comissoes != null && metrica.comissoes.length > 0) {
        if (metricaCards.length > 0) {
          int contador = 0;
          for (var i = 0; i < metricaCards.length; i++) {
            for (var j = 0; j < metricaCards[i].length; j++) {
            if (porcentagemComissaoBaseTEC[contador].text != '' &&
                valorMinimoTEC[contador].text != '' &&
                valorMaximoTEC[contador].text != '') {
              dbParametrizacao.insertComissao(ParametrizacaoComissao.fromMap({
                'corretorId': usuarioState.id,
                'seguradoraId': seguradoraId,
                'metricaId': metrica.comissoes[i].id,
                'porcentagemComissaoBase':
                    porcentagemComissaoBaseTEC[contador].numberValue,
                'valorMin': valorMinimoTEC[contador].numberValue,
                'valorMax': valorMaximoTEC[contador].numberValue
              }));
              contador++;
            }
          }
          }
        }
      }
      if (metrica.bonus != null) {
        if (bonusCard.length > 0) {
          for (var i = 0; i < bonusCard.length; i++) {
            if (porcentagemBonusTEC[i].text != '' &&
                valorMinimoBonusTEC[i].text != '' &&
                valorMaximoBonusTEC[i].text != '') {
              dbParametrizacao.insertBonus(ParametrizacaoBonus.fromMap({
                'corretorId': usuarioState.id,
                'seguradoraId': seguradoraId,
                'metricaId': metrica.bonus.id,
                'porcentagemComissao': porcentagemBonusTEC[i].numberValue,
                'valorMin': valorMinimoBonusTEC[i].numberValue,
                'valorMax': valorMaximoBonusTEC[i].numberValue
              }));
            }
          }
        }
      }
    }
  }

  String getNomeSeguradoraById(int id) {
    return minhasSeguradoras.singleWhere((s) => s.id == id).nome;
  }
}
