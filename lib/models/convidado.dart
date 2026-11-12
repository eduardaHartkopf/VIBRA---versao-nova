class Convidado {
  const Convidado({
    this.id,
    required this.nome,
    required this.acompanhantes,
    required this.confirmado,
    this.eventoId,
    this.eventoNome,
  });

  final int? id;
  final String nome;
  final int acompanhantes;
  final bool confirmado;
  final int? eventoId;
  final String? eventoNome;

  factory Convidado.fromMap(Map<String, Object?> map) => Convidado(
        id: map['id'] as int?,
        nome: map['nome'] as String,
        acompanhantes: map['acompanhantes'] as int,
        confirmado: map['confirmado'] == 1,
        eventoId: map['evento_id'] as int?,
        eventoNome: map['evento_nome'] as String?,
      );

  Map<String, Object?> toMap() => {
        'nome': nome,
        'acompanhantes': acompanhantes,
        'confirmado': confirmado ? 1 : 0,
        'evento_id': eventoId,
        'evento_nome': eventoNome,
      };
}
