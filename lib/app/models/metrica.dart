import 'package:flutter_application_1/app/models/metricaAngariacao.dart';
import 'package:flutter_application_1/app/models/metricaBonus.dart';
import 'package:flutter_application_1/app/models/metricaComissao.dart';

class Metrica {
  int seguradoraId;
  int corretorId;
  MetricaAngariacao angariacao;
  List<MetricaComissao> comissoes;
  MetricaBonus bonus;
}