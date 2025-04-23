import 'package:flutter/material.dart';

class CalorieView extends StatefulWidget {
  @override
  State<CalorieView> createState() => _CalorieViewState();
}

class _CalorieViewState extends State<CalorieView> {
  final pesoController = TextEditingController();
  final alturaController = TextEditingController();
  final idadeController = TextEditingController();

  String sexo = 'Masculino';
  double atividade = 1.2;
  String resultado = '';

  void calcularCalorias() {
    final peso = double.tryParse(pesoController.text) ?? 0;
    final altura = double.tryParse(alturaController.text) ?? 0;
    final idade = int.tryParse(idadeController.text) ?? 0;

    double tmb;

    if (sexo == 'Masculino') {
      tmb = 66 + (13.7 * peso) + (5 * altura) - (6.8 * idade);
    } else {
      tmb = 655 + (9.6 * peso) + (1.8 * altura) - (4.7 * idade);
    }

    final calorias = tmb * atividade;

    setState(() {
      resultado = 'Você precisa de aproximadamente ${calorias.toStringAsFixed(0)} kcal/dia';
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
            buildTextField(pesoController, 'Peso (kg)', Icons.fitness_center),
            SizedBox(height: 15),
            buildTextField(alturaController, 'Altura (cm)', Icons.height),
            SizedBox(height: 15),
            buildTextField(idadeController, 'Idade (anos)', Icons.cake),
            SizedBox(height: 15),
            Row(
              children: [
                Text('Sexo:', style: TextStyle(color: Colors.black54),),
                SizedBox(width: 10),
                DropdownButton<String>(
                  value: sexo,
                  onChanged: (value) => setState(() => sexo = value!),
                  items: ['Masculino', 'Feminino']
                      .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Text('Atividade:',style: TextStyle(color: Colors.black54),),
                SizedBox(width: 10),
                DropdownButton<double>(
                  value: atividade,
                  onChanged: (value) => setState(() => atividade = value!),
                  items: [
                    {'label': 'Sedentário', 'value': 1.2},
                    {'label': 'Leve', 'value': 1.375},
                    {'label': 'Moderado', 'value': 1.55},
                    {'label': 'Intenso', 'value': 1.725},
                    {'label': 'Muito Intenso', 'value': 1.9},
                  ]
                      .map((map) => DropdownMenuItem(
                            value: map['value'] as double,
                            child: Text(map['label'] as String),
                          ))
                      .toList(),
                ),
              ],
            ),
            SizedBox(height: 25),
            ElevatedButton.icon(
              onPressed: calcularCalorias,
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
            if (resultado.isNotEmpty)
              Text(
                resultado,
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
