import 'package:flutter_imc_app/model/registro_calculo_imc.dart';

class IMCViewModel {
  RegistroCalculoImc calcularIMC(double peso, double alturaCm) {
    double alturaMetros = alturaCm / 100; // Converte para metros
    double imc = peso / (alturaMetros * alturaMetros);

    String statusIMC = classificarIMC(imc);

    return RegistroCalculoImc(
        peso: peso,
        altura: alturaCm,
        imc: imc,
        dataCalculo: DateTime.now(),
        statusIMC: statusIMC
    );
  }

  String classificarIMC(double imc) {
    if (imc < 18.5) return "Abaixo do peso";
    if (imc < 24.9) return "Peso normal";
    if (imc < 29.9) return "Sobrepeso";
    if (imc < 34.9) return "Obesidade Grau I";
    if (imc < 39.9) return "Obesidade Grau II";
    return "Obesidade Grau III";
  }
}