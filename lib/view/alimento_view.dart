import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/alimento.dart';
import '../service/auth_service.dart';
import '../repository/alimento_repository.dart';

class AlimentoView extends StatefulWidget {
  const AlimentoView({super.key});

  @override
  State<AlimentoView> createState() => _AlimentoViewState();
}

class _AlimentoViewState extends State<AlimentoView> {
  final nomeController = TextEditingController();
  final calController = TextEditingController();
  final qtdController = TextEditingController();

  late AlimentoRepository _repo;

  @override
  void initState() {
    super.initState();
    final authService = Provider.of<AuthService>(context, listen: false);
    _repo = AlimentoRepository(authService);
  }

  void adicionar() async {
    final nome = nomeController.text;
    final cal = double.tryParse(calController.text) ?? 0;
    final qtd = int.tryParse(qtdController.text) ?? 1;

    if (nome.isEmpty || cal <= 0 || qtd <= 0) return;

    final alimento = Alimento(
      nome: nome,
      caloriasPorUnidade: cal,
      quantidade: qtd,
      dataInsercao: DateTime.now(),
    );

    await _repo.adicionar(alimento);

    nomeController.clear();
    calController.clear();
    qtdController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Alimentos', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.brown.shade400,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: Icon(Icons.fastfood, size: 70, color: Colors.brown.shade400),
            ),
            const SizedBox(height: 30),

            buildTextField(nomeController, 'Nome do alimento', Icons.fastfood, false),
            const SizedBox(height: 15),

            buildTextField(calController, 'Calorias por unidade', Icons.local_fire_department, true),
            const SizedBox(height: 15),

            buildTextField(qtdController, 'Quantidade', Icons.numbers, true),
            const SizedBox(height: 15),

            ElevatedButton.icon(
              onPressed: adicionar,
              icon: const Icon(Icons.add),
              label: const Text('Adicionar alimento'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown.shade400,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 25),

            StreamBuilder<List<AlimentoFirestore>>(
              stream: _repo.getAlimentosStream(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final alimentos = snapshot.data!;

                if (alimentos.isEmpty) {
                  return const Center(child: Text('Nenhum alimento adicionado.'));
                }

                final total = alimentos.fold<double>(
                  0,
                      (sum, a) => sum + a.alimento.totalCalorias,
                );

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: alimentos.length,
                      itemBuilder: (context, i) {
                        final a = alimentos[i];
                        return Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.brown.shade300,
                              child: const Icon(Icons.fastfood, color: Colors.white),
                            ),
                            title: Text(
                              '${a.alimento.nome} x${a.alimento.quantidade}',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(
                                '${a.alimento.totalCalorias.toStringAsFixed(2)} kcal',
                                style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                await _repo.remover(a.id);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Total consumido: ${total.toStringAsFixed(2)} kcal',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green.shade900),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String label, IconData icon, bool number) {
    return TextField(
      controller: controller,
      keyboardType: number ? const TextInputType.numberWithOptions(decimal: true) : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
