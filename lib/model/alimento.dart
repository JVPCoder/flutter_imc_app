class Alimento {
  String nome;
  int quantidade;
  double caloriasPorUnidade;
  DateTime dataInsercao;

  Alimento({
    required this.nome,
    required this.quantidade,
    required this.caloriasPorUnidade,
    required this.dataInsercao
  });

  double get totalCalorias => quantidade * caloriasPorUnidade;
}