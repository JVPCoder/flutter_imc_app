class IMCModel {
  final double peso;
  final double alturaCm;

  IMCModel({required this.peso, required this.alturaCm});

  double calcularIMC() {
    double alturaM = alturaCm / 100; // Converte para metros
    return peso / (alturaM * alturaM);
  }

  String classificarIMC() {
    double imc = calcularIMC();
    if (imc < 18.5) return "Abaixo do peso";
    if (imc < 24.9) return "Peso normal";
    if (imc < 29.9) return "Sobrepeso";
    if (imc < 34.9) return "Obesidade Grau I";
    if (imc < 39.9) return "Obesidade Grau II";
    return "Obesidade Grau III";
  }
}
