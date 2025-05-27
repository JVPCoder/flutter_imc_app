import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../service/auth_service.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  bool _isLogin = true; // controla se está na tela de login ou cadastro
  bool _isLoading = false;

  void _toggleForm() {
    setState(() {
      _isLogin = !_isLogin;
      // Limpar os campos quando alternar entre login e cadastro
      _emailController.clear();
      _senhaController.clear();
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final authService = Provider.of<AuthService>(context, listen: false);
    setState(() => _isLoading = true);

    try {
      if (_isLogin) {
        await authService.login(
          _emailController.text,
          _senhaController.text,
        );
      } else {
        await authService.registrar(
          _emailController.text,
          _senhaController.text,
        );
      }

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Define cor conforme login ou cadastro
    final color = _isLogin ? Colors.green.shade700 : Colors.orange.shade700;

    return Scaffold(
      appBar: AppBar(
        title: const Text('JF HealthCalc', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                _isLogin ? 'Bem-vindo!' : 'Crie sua conta',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.green.shade900,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o email';
                  }
                  if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Email inválido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _senhaController,
                decoration: const InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'A senha deve ter no mínimo 6 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton.icon(
                onPressed: _submit,
                icon: Icon(_isLogin ? Icons.login : Icons.app_registration),
                label: Text(_isLogin ? 'Login' : 'Cadastrar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 4,
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: _toggleForm,
                child: Text(
                  _isLogin
                      ? 'Não possui uma conta? Cadastre-se!'
                      : 'Já possui uma conta? Faça login!',
                  style: TextStyle(color: color),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
