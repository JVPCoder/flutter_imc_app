import 'package:flutter_imc_app/model/enum/atividade.dart';
import 'package:flutter_imc_app/model/enum/sexo.dart';

class RegistroCalculoTMB{
  final double peso;
  final double altura;
  final int idade;
  final Sexo sexo;
  final Atividade atividade;
  final double tmb;
  final double totalCalorias;
  final DateTime dataCalculo;

  RegistroCalculoTMB({
    required this.peso,
    required this.altura,
    required this.idade,
    required this.sexo,
    required this.atividade,
    required this.tmb,
    required this.totalCalorias,
    required this.dataCalculo
  });

}