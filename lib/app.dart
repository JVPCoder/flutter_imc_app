import 'package:flutter/material.dart';
import 'package:flutter_imc_app/view/screen/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

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