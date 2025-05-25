import 'package:flutter/material.dart';
import 'package:flutter_imc_app/model/enum/atividade.dart';
import 'package:flutter_imc_app/model/registro_calculo_tmb.dart';
import 'package:flutter_imc_app/viewmodel/tmb_viewmodel.dart';

import '../model/enum/sexo.dart';

class CaloriaView extends StatefulWidget {
  const CaloriaView({super.key});

  @override
  State<CaloriaView> createState() => _CaloriaViewState();
}

class _CaloriaViewState extends State<CaloriaView> {
  final _pesoController = TextEditingController();
  final _alturaController = TextEditingController();
  final _idadeController = TextEditingController();
  final tmbVM = TMBViewModel();
  Sexo _sexo = Sexo.masculino;
  Atividade _atividade = Atividade.sedentario;

  String _resultado = '';

  void handleCalcularCalorias() {
    final peso = double.tryParse(_pesoController.text) ?? 0;
    final altura = double.tryParse(_alturaController.text) ?? 0;
    final idade = int.tryParse(_idadeController.text) ?? 0;

    if(peso <= 0 || altura <= 0 || idade <=0) {
      setState(() {
        _resultado = "Insira valores válidos!";
      });
      return;
    }

    RegistroCalculoTMB registro = tmbVM.calcularTMB(peso, altura, idade, _sexo, _atividade);

    setState(() {
      _resultado = 'Você precisa de aproximadamente ${registro.totalCalorias.toStringAsFixed(0)} kcal/dia';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calorias por Dia', style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.orange.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(Icons.local_fire_department, size: 70, color: Colors.orange),
            SizedBox(height: 20),
            buildTextField(_pesoController, 'Peso (kg)', Icons.fitness_center),
            SizedBox(height: 15),
            buildTextField(_alturaController, 'Altura (cm)', Icons.height),
            SizedBox(height: 15),
            buildTextField(_idadeController, 'Idade (anos)', Icons.cake),
            SizedBox(height: 15),
            Row(
              children: [
                Text('Sexo:', style: TextStyle(color: Colors.black54),),
                SizedBox(width: 10),
                DropdownButton<Sexo>(
                  value: _sexo,
                  onChanged: (value) => setState(() => _sexo = value ?? Sexo.masculino),
                  items: Sexo.values
                      .map((s) => DropdownMenuItem(value: s, child: Text(s.descricao)))
                      .toList(),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Text('Atividade:',style: TextStyle(color: Colors.black54),),
                SizedBox(width: 10),
                DropdownButton<Atividade>(
                  value: _atividade,
                  onChanged: (value) => setState(() => _atividade = value ?? Atividade.sedentario),
                  items: Atividade.values.map(
                          (a) => DropdownMenuItem(
                            value: a,
                            child: Text(a.descricao)
                          )).toList(),
                ),
              ],
            ),
            SizedBox(height: 25),
            ElevatedButton.icon(
              onPressed: handleCalcularCalorias,
              icon: Icon(Icons.calculate),
              label: Text('Calcular Calorias'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange.shade700,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(height: 30),
            if (_resultado.isNotEmpty)
              Text(
                _resultado,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange.shade800),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String label, IconData icon) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
