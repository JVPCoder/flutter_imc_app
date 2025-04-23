import 'package:flutter/material.dart';
import 'views/imc_view.dart';
import 'views/calorie_view.dart';
import 'views/food_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JF HealthCalc',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.green.shade50,
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
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
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Colors.green,
          foregroundColor: Colors.white,
          minimumSize: Size(double.infinity, 60),
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
    return Scaffold(
      appBar: AppBar(
        title: Text('JF HealthCalc', style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
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
            SizedBox(height: 30),
            _buildMenuButton(
              icon: Icons.monitor_weight,
              title: 'Calculadora de IMC',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => IMCView()),
              ),
              color: Colors.green.shade700,
            ),
            _buildMenuButton(
              icon: Icons.local_fire_department,
              title: 'Taxa Metabólica Basal',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CalorieView()),
              ),
              color: Colors.orange.shade700,
            ),
            _buildMenuButton(
              icon: Icons.fastfood,
              title: 'Histórico de Alimentos',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => FoodView()),
              ),
              color: Colors.brown.shade400,
            ),
          ],
        ),
      ),
    );
  }
}
