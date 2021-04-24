import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/repository/UsuarioState.dart';

class CorretorLeftNav extends StatelessWidget {
  final UsuarioState userState = UsuarioState();

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        UserAccountsDrawerHeader(
          // currentAccountPicture: ClipRRect(
          //   child: Image.asset('assets/images/daniel-santos.jpg'),
          //   borderRadius: BorderRadius.circular(40),
          // ),
          accountName: FutureBuilder<UsuarioState>(
              future: userState.getUsuarioState(),
              builder:
                  (BuildContext context, AsyncSnapshot<UsuarioState> userState) {
                if (userState.connectionState == ConnectionState.done) {
                  return Text(userState.data.nome);
                }
                return Text('');
              }),
          accountEmail: FutureBuilder<UsuarioState>(
              future: userState.getUsuarioState(),
              builder:
                  (BuildContext context, AsyncSnapshot<UsuarioState> userState) {
                if (userState.connectionState == ConnectionState.done) {
                  return Text(userState.data.email);
                }
                return Text('');
              }),
        ),
        ListTile(
          title: Text('Início'),
          subtitle: Text('Tela de início'),
          leading: Icon(Icons.home),
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/corretor/home');
          },
        ),
        // ListTile(
        //   title: Text('Adicionar venda'),
        //   // subtitle: Text('2'),
        //   leading: Icon(Icons.monetization_on),
        //   onTap: () {
        //     Navigator.of(context).pushReplacementNamed('/venda/add');
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
        ListTile(
          title: Text('Minhas Seguradoras'),
          // subtitle: Text('0'),
          leading: Icon(Icons.account_balance),
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/seguradora/addcorretor');
          },
        ),
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
    ));
  }
}
