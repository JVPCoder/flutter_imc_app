import 'package:flutter_imc_app/model/alimento.dart';

class AlimentoViewModel {
  final List<Alimento> _alimentoList = [];

  List<Alimento> get alimentoList => _alimentoList;

  void adicionarAlimento(Alimento alimento) {
    _alimentoList.add(alimento);
  }
}