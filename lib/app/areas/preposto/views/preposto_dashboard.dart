import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/areas/preposto/views/preposto_left_nav.dart';
import 'package:flutter_application_1/app/repository/VendaProvider.dart';
import 'package:flutter_application_1/app/repository/UsuarioState.dart';

class CollectorDashboard extends StatelessWidget {
  final VendaProvider salesDb = VendaProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CollectorLeftNav(),
      appBar: AppBar(title: Text('Preposto')),
      body: Container(
          padding: const EdgeInsets.all(20.0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(children: [
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                      width: 100,
                      height: 30,
                      child: Text('Vendas feitas',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  SizedBox(width: 30),
                  FutureBuilder<int>(
                      future: getSalesCount(),
                      builder: (context, sales) {
                        if (sales.connectionState == ConnectionState.done) {
                          return Text(sales.data.toString(),
                            style: TextStyle(
                            decoration: TextDecoration.underline,
                          ));
                        }
                        return CircularProgressIndicator();
                      }),
                  
                ]),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                      width: 100,
                      height: 30,
                      child: Text('Clientes Ativos',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  SizedBox(width: 30),
                  Text('2',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      )),
                ]),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                      width: 100,
                      height: 30,
                      child: Text('Atrasos',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  SizedBox(width: 30),
                  Text('0',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      )),
                ]),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                      width: 100,
                      height: 30,
                      child: Text('Seguradoras',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  SizedBox(width: 30),
                  Text('1',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      )),
                ]),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                      width: 100,
                      height: 30,
                      child: Text('Relatórios',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  SizedBox(width: 30),
                  Text('1',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      )),
                ]),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(width: 54),
              SizedBox(
                  width: 180,
                  height: 30,
                  child: Text('Informações sobre corretor',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline))),
              Text(''),
            ])
          ])),
    );
  }

  Future<int> getSalesCount() async {
    UsuarioState userState = UsuarioState();
    userState = await userState.getUsuarioState();
    return await salesDb.getCountVendasByPrepostoId(userState.id);
  }
}
