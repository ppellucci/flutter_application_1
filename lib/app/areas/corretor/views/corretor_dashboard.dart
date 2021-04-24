import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/areas/corretor/views/corretor_left_nav.dart';
import 'package:flutter_application_1/app/repository/UsuarioState.dart';

class CorretorDashboard extends StatelessWidget {
  final UsuarioState userState = UsuarioState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CorretorLeftNav(),
      appBar: AppBar(title: Text('Corretor')),
      body: Container(
          padding: const EdgeInsets.all(20.0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(children: [
            Row(children: [
              Text("Seja bem vindo, corretor!", style: TextStyle(fontWeight: FontWeight.bold))
            ],)
            // Row(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       SizedBox(
            //           width: 100,
            //           height: 30,
            //           child: Text('Clientes Ativos',
            //               style: TextStyle(fontWeight: FontWeight.bold))),
            //       SizedBox(width: 30),
            //       Text('2',
            //           style: TextStyle(
            //             decoration: TextDecoration.underline,
            //           )),
            //     ]),
            // Row(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       SizedBox(
            //           width: 100,
            //           height: 30,
            //           child: Text('Atrasos',
            //               style: TextStyle(fontWeight: FontWeight.bold))),
            //       SizedBox(width: 30),
            //       Text('0',
            //           style: TextStyle(
            //             decoration: TextDecoration.underline,
            //           )),
            //     ]),
            // Row(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       SizedBox(
            //           width: 100,
            //           height: 30,
            //           child: Text('Seguradoras',
            //               style: TextStyle(fontWeight: FontWeight.bold))),
            //       SizedBox(width: 30),
            //       Text('1',
            //           style: TextStyle(
            //             decoration: TextDecoration.underline,
            //           )),
            //     ]),
            // Row(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       SizedBox(
            //           width: 100,
            //           height: 30,
            //           child: Text('Relatórios',
            //               style: TextStyle(fontWeight: FontWeight.bold))),
            //       SizedBox(width: 30),
            //       Text('1',
            //           style: TextStyle(
            //             decoration: TextDecoration.underline,
            //           )),
            //     ]),
            // Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            //   SizedBox(width: 54),
            //   SizedBox(
            //       width: 180,
            //       height: 30,
            //       child: Text('Informações sobre corretor',
            //           style: TextStyle(
            //               fontWeight: FontWeight.bold,
            //               decoration: TextDecoration.underline))),
            //   Text(''),
            // ])
          ])),
    );
  }
}
