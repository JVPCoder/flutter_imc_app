import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_imc_app/app.dart';
import 'package:flutter_imc_app/service/auth_service.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => AuthService())
      ],
        child: App(),
      ),
  );
}
