import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/repository/UsuarioState.dart';

class BrokerDashboard extends StatelessWidget {
  final UsuarioState userState = UsuarioState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: Column(
        children: [
          UserAccountsDrawerHeader(
            // currentAccountPicture: ClipRRect(
            //   child: Image.asset('assets/images/daniel-santos.jpg'),
            //   borderRadius: BorderRadius.circular(40),
            // ),
            accountName: FutureBuilder<UsuarioState>(
              future: userState.getUsuarioState(),
              builder: (BuildContext context, AsyncSnapshot<UsuarioState> userState) {
                return Text(userState.data.nome);
              }
            ),
            accountEmail: FutureBuilder<UsuarioState>(
              future: userState.getUsuarioState(),
              builder: (BuildContext context, AsyncSnapshot<UsuarioState> userState) {
                return Text(userState.data.email);
              }
          ),
          ),
          // ListTile(
          //   title: Text('Início'),
          //   subtitle: Text('Tela de início'),
          //   leading: Icon(Icons.home),
          //   onTap: () {
          //     Navigator.of(context).pushReplacementNamed('/home');
          //   },
          // ),
          // ListTile(
          //   title: Text('Clientes Ativos'),
          //   subtitle: Text('2'),
          //   leading: Icon(Icons.monetization_on),
          //   onTap: () {
          //     Navigator.of(context).pushReplacementNamed('/ativos');
          //   },
          // ),
          // ListTile(
          //   title: Text('Atrasos'),
          //   subtitle: Text('0'),
          //   leading: Icon(Icons.money_off),
          //   onTap: () {
          //     Navigator.of(context).pushReplacementNamed('/atrasos');
          //   },
          // ),
          // ListTile(
          //   title: Text('Seguradoras'),
          //   subtitle: Text('1'),
          //   leading: Icon(Icons.account_balance),
          //   onTap: () {
          //     Navigator.of(context).pushReplacementNamed('/seguradoras');
          //   },
          // ),
          // ListTile(
          //   title: Text('Relatórios'),
          //   subtitle: Text('1'),
          //   leading: Icon(Icons.bar_chart),
          //   onTap: () {
          //     Navigator.of(context).pushReplacementNamed('/relatorios');
          //   },
          // ),
          // ListTile(
          //   title: Text('Informações do corretor'),
          //   leading: Icon(Icons.info),
          //   onTap: () {
          //     Navigator.of(context).pushReplacementNamed('/info-corretor');
          //   },
          // ),
          ListTile(
            title: Text('Sair'),
            subtitle: Text('Finalizar sessão'),
            leading: Icon(Icons.logout),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          )
        ],
      )),
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
