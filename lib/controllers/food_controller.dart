import '../models/food_model.dart';

class FoodController {
  List<FoodModel> alimentos = [];

  void adicionarAlimento(FoodModel alimento) {
    alimentos.add(alimento);
  }

  void removerAlimento(int index) {
    alimentos.removeAt(index);
  }

  double calcularTotalCalorias() {
    return alimentos.fold(0, (soma, item) => soma + item.totalCalorias);
  }
}
