class FoodModel {
  String nome;
  double caloriasPorUnidade;
  int quantidade;

  FoodModel({
    required this.nome,
    required this.caloriasPorUnidade,
    required this.quantidade,
  });

  double get totalCalorias => caloriasPorUnidade * quantidade;
}
