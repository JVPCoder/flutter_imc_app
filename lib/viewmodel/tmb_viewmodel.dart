import 'package:flutter_imc_app/model/enum/sexo.dart';
import 'package:flutter_imc_app/model/registro_calculo_tmb.dart';

import '../model/enum/atividade.dart';

class TMBViewModel {
  RegistroCalculoTMB calcularTMB(double peso, double altura, int idade, Sexo sexo, Atividade atividade) {
    double tmb = 0;
    if(sexo == Sexo.masculino) {
      tmb = 66 + (13.7 * peso) + (5 * altura) - (6.8 * idade);
    } else {
      // Feminino
      tmb = 655 + (9.6 * peso) + (1.8 * altura) - (4.7 * idade);
    }

    double totalCalorias = tmb * atividade.valor;

    return RegistroCalculoTMB(
        peso: peso,
        altura: altura,
        idade: idade,
        sexo: sexo,
        atividade: atividade,
        tmb: tmb,
        totalCalorias: totalCalorias,
        dataCalculo: DateTime.now()
    );
  }
}