import '../theme/vibra_theme.dart';

import 'package:flutter/material.dart';

class CardConvidado extends StatelessWidget {
  const CardConvidado({
    super.key,
    required this.nome,
    required this.acompanhantes,
    required this.confirmado,
    required this.onEditar,
    required this.onExcluir,
  });

  final String nome;
  final int acompanhantes;
  final bool confirmado;
  final VoidCallback onEditar;
  final VoidCallback onExcluir;

  @override
  Widget build(BuildContext context) {
    const destaque = VibraCores.destaque;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: VibraCores.avatar,
                  child: Icon(Icons.person_outline, color: destaque),
                ),
                const SizedBox(width: 12),
                Expanded(child: Text(nome, style: VibraTema.tituloCard)),
                PopupMenuButton<String>(
                  tooltip: 'Ações do convidado',
                  onSelected: (acao) =>
                      acao == 'editar' ? onEditar() : onExcluir(),
                  itemBuilder: (_) => const [
                    PopupMenuItem(value: 'editar', child: Text('Editar')),
                    PopupMenuItem(value: 'excluir', child: Text('Excluir')),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: [
                Text(
                  '$acompanhantes acompanhante(s)',
                  style: const TextStyle(color: VibraCores.textoSecundario),
                ),
                Text(
                  confirmado ? 'Presença confirmada' : 'Aguardando confirmação',
                  style: TextStyle(
                    color: confirmado ? destaque : VibraCores.textoSecundario,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
