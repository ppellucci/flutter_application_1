import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/areas/corretor/views/corretor_dashboard.dart';
import 'package:flutter_application_1/app/areas/preposto/views/preposto_dashboard.dart';
import 'package:flutter_application_1/app/areas/venda/views/create_venda.dart';
import 'package:flutter_application_1/app/areas/usuario/views/create_usuario.dart';

import 'login_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/preposto/home': (context) => PrepostoDashboard(),
        '/usuario/create': (context) => CreateUsuario(),
        '/corretor/home': (context) => CorretorDashboard(),
        '/venda/add': (context) => CreateVenda()
      },
    );
  }
}