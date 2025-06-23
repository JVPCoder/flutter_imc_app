import 'dart:convert';

import 'package:barcode_scan2/gen/protos/protos.pbenum.dart';
import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_imc_app/model/alimento_codigo_barras_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../service/auth_service.dart';
import '../caloria_view.dart';
import '../alimento_view.dart';
import '../imc_view.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String _calcularNutriScore({
    required double calorias100g,
    required double acucares100g,
    required double gorduras100g,
    required double proteinas100g,
  }) {
    int pontosNegativos = 0;
    int pontosPositivos = 0;

    // 1. Pontos negativos
    // Calorias (kcal)
    if (calorias100g > 335) pontosNegativos += 10;
    else if (calorias100g > 301) pontosNegativos += 9;
    else if (calorias100g > 268) pontosNegativos += 8;
    else if (calorias100g > 234) pontosNegativos += 7;
    else if (calorias100g > 201) pontosNegativos += 6;
    else if (calorias100g > 167) pontosNegativos += 5;
    else if (calorias100g > 134) pontosNegativos += 4;
    else if (calorias100g > 100) pontosNegativos += 3;
    else if (calorias100g > 67) pontosNegativos += 2;
    else if (calorias100g > 33) pontosNegativos += 1;

    // Açúcares
    if (acucares100g > 45) pontosNegativos += 10;
    else if (acucares100g > 40) pontosNegativos += 9;
    else if (acucares100g > 36) pontosNegativos += 8;
    else if (acucares100g > 31) pontosNegativos += 7;
    else if (acucares100g > 27) pontosNegativos += 6;
    else if (acucares100g > 22.5) pontosNegativos += 5;
    else if (acucares100g > 18) pontosNegativos += 4;
    else if (acucares100g > 13.5) pontosNegativos += 3;
    else if (acucares100g > 9) pontosNegativos += 2;
    else if (acucares100g > 4.5) pontosNegativos += 1;

    // Gordura total (substituindo saturadas)
    if (gorduras100g > 10) pontosNegativos += 10;
    else if (gorduras100g > 9) pontosNegativos += 9;
    else if (gorduras100g > 8) pontosNegativos += 8;
    else if (gorduras100g > 7) pontosNegativos += 7;
    else if (gorduras100g > 6) pontosNegativos += 6;
    else if (gorduras100g > 5) pontosNegativos += 5;
    else if (gorduras100g > 4) pontosNegativos += 4;
    else if (gorduras100g > 3) pontosNegativos += 3;
    else if (gorduras100g > 2) pontosNegativos += 2;
    else if (gorduras100g > 1) pontosNegativos += 1;

    // 2. Pontos positivos
    // Proteínas
    if (proteinas100g > 8) pontosPositivos += 5;
    else if (proteinas100g > 6.4) pontosPositivos += 4;
    else if (proteinas100g > 4.8) pontosPositivos += 3;
    else if (proteinas100g > 3.2) pontosPositivos += 2;
    else if (proteinas100g > 1.6) pontosPositivos += 1;

    // Nota final
    final scoreFinal = pontosNegativos - pontosPositivos;

    if (scoreFinal <= 0) return 'A';       // Muito saudável
    else if (scoreFinal <= 2) return 'B';
    else if (scoreFinal <= 10) return 'C';
    else if (scoreFinal <= 18) return 'D';
    else return 'E';                       // Pouco saudável
  }

  Color _corNutriScore(String nota) {
    switch (nota) {
      case 'A': return Colors.green;
      case 'B': return Colors.lightGreen;
      case 'C': return Colors.yellow.shade700;
      case 'D': return Colors.orange;
      case 'E': return Colors.red;
      default: return Colors.grey;
    }
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade800,
                fontWeight: FontWeight.w500,
              )),
          Text(value,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade900,
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    );
  }

  Future<void> _scanAndShowInfo(BuildContext context) async {
    try {
      var result = await BarcodeScanner.scan();

      if (result.type == ResultType.Barcode) {
        String barcode = result.rawContent;

        final response = await http.get(Uri.parse(
          'https://world.openfoodfacts.org/api/v2/product/$barcode.json'
              '?fields=product_name,nutriments',
        ));

        final data = json.decode(response.body);

        if (data['status'] == 1) {
          final produto = data['product'];
          final nutriments = produto['nutriments'] ?? {};

          final nome = produto['product_name'] ?? 'Produto desconhecido';
          final calorias100g = (nutriments['energy-kcal_100g'] ?? 0).toDouble();
          final gorduras100g = (nutriments['fat_100g'] ?? 0).toDouble();
          final acucares100g = (nutriments['carbohydrates_100g'] ?? 0).toDouble();
          final proteinas100g = (nutriments['proteins_100g'] ?? 0).toDouble();

          final score = _calcularNutriScore(
            calorias100g: calorias100g,
            acucares100g: acucares100g,
            gorduras100g: gorduras100g,
            proteinas100g: proteinas100g,
          );

          final cor = _corNutriScore(score);

          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            builder: (_) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 50,
                      height: 5,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Text(
                    nome,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow('Calorias (100g)', '${calorias100g.toStringAsFixed(1)} kcal'),
                  _buildInfoRow('Açúcares (100g)', '${acucares100g.toStringAsFixed(1)} g'),
                  _buildInfoRow('Gorduras (100g)', '${gorduras100g.toStringAsFixed(1)} g'),
                  _buildInfoRow('Proteínas (100g)', '${proteinas100g.toStringAsFixed(1)} g'),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text(
                        'Score de Saúde: ',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'Pontuação: $score',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: cor,
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.check),
                      label: const Text('Fechar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade700,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          _showErrorDialog(context, 'Produto não encontrado.');
        }
      }
    } catch (e) {
      _showErrorDialog(context, 'Erro ao escanear: $e');
    }
  }

  void _showErrorDialog(BuildContext context, String mensagem) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Erro'),
        content: Text(mensagem),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          )
        ],
      ),
    );
  }

  Widget _buildMenuButton({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 26),
        label: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Colors.green,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('JF HealthCalc', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sair',
            onPressed: () async {
              await authService.logout();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (route) => false,
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
        child: Column(
          children: [
            Text(
              'O que você deseja calcular hoje?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.green.shade900,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            _buildMenuButton(
              icon: Icons.monitor_weight,
              title: 'Calculadora de IMC',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const IMCView()),
              ),
              color: Colors.green.shade700,
            ),
            _buildMenuButton(
              icon: Icons.local_fire_department,
              title: 'Calculadora de Calorias',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CaloriaView()),
              ),
              color: Colors.orange.shade700,
            ),
            _buildMenuButton(
              icon: Icons.fastfood,
              title: 'Histórico de Alimentos',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AlimentoView()),
              ),
              color: Colors.brown.shade400,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _scanAndShowInfo(context),
        tooltip: 'Escanear código de barras',
        backgroundColor: Colors.green,
        child: Icon(Icons.qr_code_scanner),
      ),
    );

  }
}
