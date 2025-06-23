class AlimentoCodigoBarrasFirestore {
  final String id;
  final String nome;
  final double calorias;
  final double gorduras;
  final double acucares;
  final double proteinas;
  final DateTime dataInsercao;

  AlimentoCodigoBarrasFirestore({
    required this.id,
    required this.nome,
    required this.calorias,
    required this.gorduras,
    required this.acucares,
    required this.proteinas,
    required this.dataInsercao,
  });

  factory AlimentoCodigoBarrasFirestore.fromMap(String id, Map<String, dynamic> data) {
    return AlimentoCodigoBarrasFirestore(
      id: id,
      nome: data['nome'] ?? 'Produto desconhecido',
      calorias: (data['calorias'] as num?)?.toDouble() ?? 0.0,
      gorduras: (data['gorduras'] as num?)?.toDouble() ?? 0.0,
      acucares: (data['acucares'] as num?)?.toDouble() ?? 0.0,
      proteinas: (data['proteinas'] as num?)?.toDouble() ?? 0.0,
      dataInsercao: DateTime.tryParse(data['dataInsercao'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'calorias': calorias,
      'gorduras': gorduras,
      'acucares': acucares,
      'proteinas': proteinas,
      'dataInsercao': dataInsercao.toIso8601String(),
    };
  }
}
