import 'package:flutter_imc_app/model/enum/sexo.dart';

class TMBViewModel {
  double calcularTMB(double peso, double altura, int idade, Sexo sexo) {
    if(sexo == Sexo.masculino) {
      return 88.36 + (13.34 * peso) + (4.8 * altura * 100) - (5.7 * idade);
    }

    // Feminino
    return 447.6 + (9.2 * peso) + (3.1 * altura * 100) - (4.3 * idade);
  }
}