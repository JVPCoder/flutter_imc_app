class CalorieModel {
  final int idade;
  final String sexo;
  final double peso;
  final double altura;
  final String atividade;

  CalorieModel({
    required this.idade,
    required this.sexo,
    required this.peso,
    required this.altura,
    required this.atividade,
  });

  double calcularTMB() {
    // Fórmula de Mifflin-St Jeor
    if (sexo == 'Masculino') {
      return 10 * peso + 6.25 * altura - 5 * idade + 5;
    } else {
      return 10 * peso + 6.25 * altura - 5 * idade - 161;
    }
  }

  double fatorAtividade() {
    switch (atividade) {
      case 'Sedentário':
        return 1.2;
      case 'Levemente ativo':
        return 1.375;
      case 'Moderadamente ativo':
        return 1.55;
      case 'Muito ativo':
        return 1.725;
      case 'Extremamente ativo':
        return 1.9;
      default:
        return 1.2;
    }
  }

  double calcularCalorias() {
    return calcularTMB() * fatorAtividade();
  }
}
