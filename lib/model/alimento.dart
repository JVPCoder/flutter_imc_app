class Alimento {
  String nome;
  int quantidade;
  double caloriasPorUnidade;

  Alimento({required this.nome, required this.quantidade, required this.caloriasPorUnidade});

  double get totalCalories => quantidade * caloriasPorUnidade;
}