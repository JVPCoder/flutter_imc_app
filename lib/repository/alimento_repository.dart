import 'package:cloud_firestore/cloud_firestore.dart';
import '../database/db_firestore.dart';
import '../model/alimento.dart';
import '../service/auth_service.dart';

class AlimentoRepository {
  final FirebaseFirestore _firestore = DBFirestore.get();
  final AuthService _authService;

  AlimentoRepository(this._authService);

  CollectionReference<Map<String, dynamic>> _alimentoRef() {
    final user = _authService.usuario;
    if (user == null) {
      throw Exception('Usuário não autenticado');
    }
    return _firestore.collection('usuarios').doc(user.uid).collection('alimentos');
  }

  Future<void> adicionar(Alimento alimento) async {
    await _alimentoRef().add({
      'nome': alimento.nome,
      'caloriasPorUnidade': alimento.caloriasPorUnidade,
      'quantidade': alimento.quantidade,
      'dataInsercao': alimento.dataInsercao.toIso8601String(),
    });
  }

  Future<void> remover(String alimentoId) async {
    await _alimentoRef().doc(alimentoId).delete();
  }

  Stream<List<AlimentoFirestore>> getAlimentosStream() {
    return _alimentoRef().orderBy('dataInsercao', descending: true).snapshots().map(
          (snapshot) => snapshot.docs.map((doc) {
        final data = doc.data();
        return AlimentoFirestore(
          id: doc.id,
          alimento: Alimento(
            nome: data['nome'],
            caloriasPorUnidade: (data['caloriasPorUnidade'] as num).toDouble(),
            quantidade: (data['quantidade'] as num).toInt(),
            dataInsercao: DateTime.parse(data['dataInsercao']),
          ),
        );
      }).toList(),
    );
  }
}

class AlimentoFirestore {
  final String id;
  final Alimento alimento;

  AlimentoFirestore({required this.id, required this.alimento});
}
