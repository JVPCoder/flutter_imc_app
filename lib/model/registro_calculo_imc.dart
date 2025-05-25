class RegistroCalculoImc {
  final double peso;
  final double altura;
  final double imc;
  final DateTime dataCalculo;
  final String statusIMC;

  RegistroCalculoImc({
    required this.peso,
    required this.altura,
    required this.imc,
    required this.dataCalculo,
    required this.statusIMC
  });

}