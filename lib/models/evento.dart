class Evento {
  final int? id;
  final String nome;
  final String imagem;
  final String descricao;
  final String data;
  final String horario;
  final String local;

  const Evento({
    this.id,
    required this.nome,
    required this.imagem,
    required this.descricao,
    required this.data,
    required this.horario,
    required this.local,
  });
}
