import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_imc_app/service/auth_service.dart';
import 'package:flutter_imc_app/view/screen/home_screen.dart';
import 'package:provider/provider.dart';

import '../view/screen/login_screen.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});


  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {

  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);


    if(auth.isLoading) {
      return loading();
    }

    if (auth.usuario == null){
      return LoginScreen();
    }

    return HomeScreen();
  }

  loading() {
    return Scaffold(
      body: CircularProgressIndicator(),
    );
  }
}