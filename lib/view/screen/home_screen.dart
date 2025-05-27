import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../service/auth_service.dart';
import '../caloria_view.dart';
import '../alimento_view.dart';
import '../imc_view.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
        title: const Text(
          'JF HealthCalc',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
    );
  }
}
