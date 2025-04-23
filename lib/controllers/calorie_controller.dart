import '../models/calorie_model.dart';

class CalorieController {
  int idade = 0;
  String sexo = 'Masculino';
  double peso = 0;
  double altura = 0;
  String atividade = 'Sedentário';

  String calcular() {
    final model = CalorieModel(
      idade: idade,
      sexo: sexo,
      peso: peso,
      altura: altura,
      atividade: atividade,
    );

    final calorias = model.calcularCalorias().toStringAsFixed(0);
    return "Gasto diário estimado: $calorias kcal";
  }
}
