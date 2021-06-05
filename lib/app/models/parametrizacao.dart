import 'package:flutter_application_1/app/models/parametrizacaoAngariacao.dart';
import 'package:flutter_application_1/app/models/parametrizacaoBonus.dart';
import 'package:flutter_application_1/app/models/parametrizacaoComissao.dart';

class Parametrizacao {
  int seguradoraId;
  int corretorId;
  ParametrizacaoAngariacao angariacao;
  List<ParametrizacaoComissao> comissoes;
  List<ParametrizacaoBonus> bonus;
}
