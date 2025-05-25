enum Atividade {
  sedentario('Sedentário', 1.2),
  leve('Leve', 1.375),
  moderado('Moderado', 1.55),
  intenso('Intenso', 1.725),
  muitoIntenso('Muito Intenso', 1.9);

  final String descricao;
  final double valor;

  const Atividade(this.descricao, this.valor);
}