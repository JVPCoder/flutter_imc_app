import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/alimento_codigo_barras_firestore.dart';
import '../../repository/alimento_codigo_barras_repository.dart';
import '../../service/auth_service.dart';

class HistoricoCodigoBarrasPage extends StatelessWidget {
  const HistoricoCodigoBarrasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final repository = AlimentoCodigoBarrasRepository(authService);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Escaneamentos'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<List<AlimentoCodigoBarrasFirestore>>(
        stream: repository.getStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final alimentos = snapshot.data ?? [];

          if (alimentos.isEmpty) {
            return const Center(
              child: Text('Nenhum alimento escaneado ainda.'),
            );
          }

          return ListView.builder(
            itemCount: alimentos.length,
            itemBuilder: (context, index) {
              final a = alimentos[index];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nome e Data
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              a.nome,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green, // <- aqui está a cor
                              ),
                            ),
                          ),
                          Text(
                            '${a.dataInsercao.day}/${a.dataInsercao.month}/${a.dataInsercao.year}',
                            style: const TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const SizedBox(height: 12),
                      // Tabela Nutricional
                      Wrap(
                        spacing: 20,
                        runSpacing: 8,
                        children: [
                          _buildInfoChip('Calorias', '${a.calorias.toStringAsFixed(1)} kcal'),
                          _buildInfoChip('Açúcares', '${a.acucares.toStringAsFixed(1)} g'),
                          _buildInfoChip('Gorduras', '${a.gorduras.toStringAsFixed(1)} g'),
                          _buildInfoChip('Proteínas', '${a.proteinas.toStringAsFixed(1)} g'),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildInfoChip(String label, String value) {
    return Chip(
      label: Text(
        '$label: $value',
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      backgroundColor: Colors.grey.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
