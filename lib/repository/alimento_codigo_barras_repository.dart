import 'package:cloud_firestore/cloud_firestore.dart';
import '../database/db_firestore.dart';
import '../model/alimento_codigo_barras_firestore.dart';
import '../service/auth_service.dart';

class AlimentoCodigoBarrasRepository {
  final FirebaseFirestore _firestore = DBFirestore.get();
  final AuthService _authService;

  AlimentoCodigoBarrasRepository(this._authService);

  CollectionReference<Map<String, dynamic>> _ref() {
    final user = _authService.usuario;
    if (user == null) {
      throw Exception('Usuário não autenticado');
    }
    return _firestore
        .collection('usuarios')
        .doc(user.uid)
        .collection('alimentos_codigo_barras');
  }

  Future<void> adicionar(AlimentoCodigoBarrasFirestore alimentoCB) async {
    await _ref().add(alimentoCB.toMap());
  }

  Future<void> remover(String id) async {
    await _ref().doc(id).delete();
  }

  Stream<List<AlimentoCodigoBarrasFirestore>> getStream() {
    return _ref()
        .orderBy('dataInsercao', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
      final data = doc.data();
      return AlimentoCodigoBarrasFirestore.fromMap(doc.id, data);
    }).toList());
  }
}
