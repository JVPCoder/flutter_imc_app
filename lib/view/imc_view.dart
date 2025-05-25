import 'package:flutter/material.dart';
import 'package:flutter_imc_app/model/registro_calculo_imc.dart';
import 'package:flutter_imc_app/viewmodel/imc_viewmodel.dart';

class IMCView extends StatefulWidget {
  const IMCView({super.key});

  @override
  State<IMCView> createState() => _IMCViewState();
}

class _IMCViewState extends State<IMCView> {
  final _pesoController = TextEditingController();
  final _alturaController = TextEditingController();
  String _resultadoIMC = '';
  String _statusIMC = '';

  final imcVM = IMCViewModel();

  void handleCalcularIMC() {
    final peso = double.tryParse(_pesoController.text) ?? 0;
    final altura = double.tryParse(_alturaController.text) ?? 0;

    if (peso <= 0 || altura <= 0) {
      setState(() {
        _resultadoIMC = 'Insira valores válidos';
      });
      return;
    }

    RegistroCalculoImc registroIMC = imcVM.calcularIMC(peso, altura);

    setState(() {
      _resultadoIMC = 'Seu IMC é: ${registroIMC.imc.toStringAsFixed(2)}';
      _statusIMC = registroIMC.statusIMC;
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
              controller: _pesoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Peso (kg)',
                prefixIcon: Icon(Icons.fitness_center),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _alturaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Altura (cm)',
                prefixIcon: Icon(Icons.height),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: handleCalcularIMC,
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
            if (_resultadoIMC.isNotEmpty)
              Column(
                children: [
                  Text(
                    _resultadoIMC,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    _statusIMC,
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
