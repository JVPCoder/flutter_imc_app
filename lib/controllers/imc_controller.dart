import '../models/imc_model.dart';

class IMCController {
  double calcularIMC(double peso, double alturaCm) {
    final model = IMCModel(peso: peso, alturaCm: alturaCm);
    return model.calcularIMC();
  }

  String classificarIMC(double peso, double alturaCm) {
    final model = IMCModel(peso: peso, alturaCm: alturaCm);
    return model.classificarIMC();
  }
}
