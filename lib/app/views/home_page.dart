import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/areas/corretor/views/add_metrica.dart';
import 'package:flutter_application_1/app/areas/corretor/views/corretor_dashboard.dart';
import 'package:flutter_application_1/app/areas/preposto/views/preposto_dashboard.dart';
import 'package:flutter_application_1/app/areas/seguradora/views/add_corretor_seguradora.dart';
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
        '/corretor/metrica': (context) => AddMetrica(),
        '/venda/add': (context) => CreateVenda(),
        '/seguradora/addcorretor': (context) => AddSeguradoraCorretor()
      },
    );
  }
}