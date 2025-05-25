import 'package:flutter/material.dart';

class Alimento {
  final String nome;
  final double caloriasPorUnidade;
  final int quantidade;

  Alimento({required this.nome, required this.caloriasPorUnidade, required this.quantidade});

  double get totalCalorias => caloriasPorUnidade * quantidade;
}

class FoodView extends StatefulWidget {
  @override
  State<FoodView> createState() => _FoodViewState();
}

class _FoodViewState extends State<FoodView> {
  final nomeController = TextEditingController();
  final calController = TextEditingController();
  final qtdController = TextEditingController();
  final List<Alimento> alimentos = [];

  void adicionar() {
    final nome = nomeController.text;
    final cal = double.tryParse(calController.text) ?? 0;
    final qtd = int.tryParse(qtdController.text) ?? 1;

    if (nome.isEmpty || cal <= 0 || qtd <= 0) return;

    setState(() {
      alimentos.add(Alimento(nome: nome, caloriasPorUnidade: cal, quantidade: qtd));
      nomeController.clear();
      calController.clear();
      qtdController.clear();
    });
  }

  double calcularTotal() {
    return alimentos.fold(0, (soma, a) => soma + a.totalCalorias);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico de Alimentos', style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.brown.shade400,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Centralizar o ícone
            Center(
              child: Icon(Icons.fastfood, size: 70, color: Colors.brown.shade400),
            ),
            SizedBox(height: 30), // Espaçamento entre ícone e inputs

            // Input Nome do Alimento
            buildTextField(nomeController, 'Nome do alimento', Icons.fastfood, false),
            SizedBox(height: 15),

            // Input Calorias por unidade
            buildTextField(calController, 'Calorias por unidade', Icons.local_fire_department, true),
            SizedBox(height: 15),

            // Input Quantidade
            buildTextField(qtdController, 'Quantidade', Icons.numbers, true),
            SizedBox(height: 15),

            // Botão para adicionar alimento
            ElevatedButton.icon(
              onPressed: adicionar,
              icon: Icon(Icons.add),
              label: Text('Adicionar alimento'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown.shade400,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(height: 7),

            // Lista de alimentos
            Expanded(
              child: alimentos.isEmpty
                  ? Center(child: Text('Nenhum alimento adicionado.', style: TextStyle(color: Colors.black),))
                  : ListView.builder(
                      itemCount: alimentos.length,
                      itemBuilder: (_, i) {
                        final a = alimentos[i];
                        return Card(
                          elevation: 2,
                          child: ListTile(
                            title: Text('${a.nome} (${a.quantidade}x)'),
                            subtitle: Text('${a.totalCalorias.toStringAsFixed(2)} kcal'),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => setState(() => alimentos.removeAt(i)),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            SizedBox(height: 1),

            // Total de calorias consumidas
            Text(
              'Total consumido: ${calcularTotal().toStringAsFixed(2)} kcal',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green.shade900),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String label, IconData icon, bool number) {
    return TextField(
      controller: controller,
      keyboardType: number ? TextInputType.numberWithOptions(decimal: true) : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
