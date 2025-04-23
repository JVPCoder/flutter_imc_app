import 'package:flutter/material.dart';
import '../controllers/imc_controller.dart';

class IMCView extends StatefulWidget {
  @override
  State<IMCView> createState() => _IMCViewState();
}

class _IMCViewState extends State<IMCView> {
  final pesoController = TextEditingController();
  final alturaController = TextEditingController();
  final controller = IMCController();

  String resultadoIMC = '';
  String classificacao = '';

  void calcularIMC() {
    final peso = double.tryParse(pesoController.text) ?? 0;
    final altura = double.tryParse(alturaController.text) ?? 0;

    if (peso <= 0 || altura <= 0) {
      setState(() {
        resultadoIMC = 'Insira valores válidos';
        classificacao = '';
      });
      return;
    }

    final imc = controller.calcularIMC(peso, altura);
    final status = controller.classificarIMC(peso, altura);

    setState(() {
      resultadoIMC = 'Seu IMC é: ${imc.toStringAsFixed(2)}';
      classificacao = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC', style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(Icons.monitor_weight, size: 80, color: Colors.green.shade700),
            SizedBox(height: 20),
            TextField(
              controller: pesoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Peso (kg)',
                prefixIcon: Icon(Icons.fitness_center),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: alturaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Altura (cm)',
                prefixIcon: Icon(Icons.height),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: calcularIMC,
              icon: Icon(Icons.calculate),
              label: Text('Calcular IMC'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade700,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: 40),
            if (resultadoIMC.isNotEmpty)
              Column(
                children: [
                  Text(
                    resultadoIMC,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    classificacao,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.orange.shade800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
