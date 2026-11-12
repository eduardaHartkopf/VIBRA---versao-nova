import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../models/evento.dart';
import '../pages/lana_exemplo_page.dart';
import '../theme/vibra_theme.dart';
import 'card_evento.dart';

class ListaEventos extends StatelessWidget {
  const ListaEventos({super.key, required this.termoPesquisa});

  final String termoPesquisa;

  static const _eventos = [
    Evento(
      id: 1,
      nome: 'Lana Del Rey | Festival',
      imagem: 'assets/images/evento_lana_del_rey.png',
      descricao: 'Uma noite de música pop e muita energia.',
      data: '15.11.2027',
      horario: '20:00',
      local: 'Caçador/SC',
    ),
    Evento(
      id: 2,
      nome: 'Zara Larsson | Pop Tropical de Verão',
      imagem: 'assets/images/evento_pop_tropical.png',
      descricao: 'Uma apresentação de Zara Larsson com seus sucessos pop.',
      data: '07.09.2027',
      horario: '16:00',
      local: 'Parque das Araucarias - Caçador/SC',
    ),
    Evento(
      id: 3,
      nome: 'Dua Lipa | Future Nostalgia',
      imagem: 'assets/images/evento_future_nostalgia.png',
      descricao: 'Uma experiência musical com grandes sucessos.',
      data: '20.12.2027',
      horario: '19:00',
      local: 'Caçador/SC',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final eventos = _eventos
        .where((evento) => evento.nome.toLowerCase().contains(termoPesquisa))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Eventos em destaque',
          style: TextStyle(
            color: VibraCores.destaque,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        if (eventos.isEmpty)
          const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: Text('Nenhum evento encontrado.')),
          )
        else
          LayoutBuilder(
            builder: (context, limites) {
              const espaco = 16.0;
              const larguraMinima = 280.0;
              final colunas =
                  ((limites.maxWidth + espaco) / (larguraMinima + espaco))
                      .floor()
                      .clamp(1, 3);
              final largura =
                  (limites.maxWidth - espaco * (colunas - 1)) / colunas;
              final altura = eventos.fold<double>(
                0,
                (maior, evento) => math.max(
                  maior,
                  CardEvento.alturaPara(context, evento, largura),
                ),
              );

              return Wrap(
                spacing: espaco,
                runSpacing: 0,
                children: [
                  for (final evento in eventos)
                    SizedBox(
                      width: largura,
                      height: altura,
                      child: CardEvento(
                        evento: evento,
                        onTap: () => Navigator.of(context).push<void>(
                          MaterialPageRoute<void>(
                            builder: (_) => EventoDetalhesPage(evento: evento),
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
      ],
    );
  }
}
