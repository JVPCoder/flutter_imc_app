import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? usuario;
  bool isLoading = true;

  AuthService(){
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  _getUser() {
    usuario = _auth.currentUser;
    notifyListeners();
  }

  registrar(String email, String senha) async {
    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if(e.code == "weak-password") {
        throw Exception("A senha é muito fraca!");
      }

      if(e.code == "email-already-in-use") {
        throw Exception("Este email já está cadastrado");
      }

      throw Exception("Erro desconhecido. Tente novamente mais tarde");
    }
  }

  login(String email, String senha) async {
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if(e.code == "user-not-found") {
        throw Exception("Email não encontrado. Cadastre-se");
      }

      if(e.code == "wrong-password" || e.code == "invalid-credential") {
        throw Exception("Senha incorreta. Tente novamente.");
      }

      if(e.code == "wrong-password") {
        throw Exception("Senha incorreta. Tente novamente.");
      }

      throw Exception("Erro desconhecido. Tente novamente mais tarde");
    }
  }

  logout() async {
    await _auth.signOut();
    _getUser();
  }
}