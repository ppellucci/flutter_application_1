import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/areas/corretor/views/corretor_left_nav.dart';
import 'package:flutter_application_1/app/components/alerta_dialog.dart';
import 'package:flutter_application_1/app/models/seguradora.dart';
import 'package:flutter_application_1/app/models/seguradoraCorretor.dart';
import 'package:flutter_application_1/app/repository/SeguradoraCorretorProvider.dart';
import 'package:flutter_application_1/app/repository/UsuarioState.dart';

class AddSeguradoraCorretor extends StatefulWidget {
  @override
  _AddSeguradoraCorretorState createState() => _AddSeguradoraCorretorState();
}

class _AddSeguradoraCorretorState extends State<AddSeguradoraCorretor> {
  SeguradoraCorretorProvider db = SeguradoraCorretorProvider();
  UsuarioState usuarioState = UsuarioState();
  int seguradoraId;
  List<Seguradora> minhasSeguradoras = [];

  @override
  void initState() {
    super.initState();

    getMinhasSeguradoras().then((value) {
      setState(() {
        minhasSeguradoras = value;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        drawer: CorretorLeftNav(),
        appBar: AppBar(title: Text('Adicionar minhas seguradoras')),
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
                        items:
                            Seguradora.getListaSeguradoras().map((seguradora) {
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
                    RaisedButton(
                      onPressed: () {
                        if (seguradoraId != 0) {
                          addSeguradora(seguradoraId);
                          var seguradora = Seguradora.getListaSeguradoras()
                              .firstWhere((s) => s.id == seguradoraId);
                          print(seguradora);
                          setState(() {
                            minhasSeguradoras.add(seguradora);
                          });
                          showDialogWithAlert(context,
                              'Seguradora cadastrada com sucesso.', 'OK', () {
                            Navigator.of(context).pop();
                          });
                        } else {
                          showDialogWithAlert(
                              context, 'Favor selecionar uma Seguradora.', 'OK',
                              () {
                            Navigator.of(context).pop();
                          });
                        }
                      },
                      child: Text('Adicionar'),
                    ),
                    SizedBox(height: 15),
                    Text('Minha lista de seguradoras:'),
                    new Expanded(
                        child: ListView.builder(
                            itemCount: minhasSeguradoras.length,
                            itemBuilder: (context, index) {
                              return new Text(minhasSeguradoras[index].nome, style: TextStyle(fontWeight: FontWeight.bold));
                            }))
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

  void addSeguradora(int seguradoraId) async {
    usuarioState = await usuarioState.getUsuarioState();
    await db.insert(SeguradoraCorretor.fromMap({
      'corretorId': usuarioState.id,
      'seguradoraId': seguradoraId,
    }));
  }

  Future<List<Seguradora>> getMinhasSeguradoras() async {
    usuarioState = await usuarioState.getUsuarioState();
    return await db.getByCorretor(usuarioState.id);
  }
}