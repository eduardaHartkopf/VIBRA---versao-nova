import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../pages/lana_exemplo_page.dart';
import '../database/database_helper.dart';
import '../models/evento.dart';
import 'card_evento.dart';

class ListaEventos extends StatefulWidget {
  const ListaEventos({
    super.key,
    required this.termoPesquisa,
    required this.onInscricao,
  });

  final String termoPesquisa;
  final ValueChanged<Map<String, dynamic>> onInscricao;

  @override
  State<ListaEventos> createState() => _ListaEventosState();
}

class _ListaEventosState extends State<ListaEventos> {
  late Future<List<Evento>> _eventos;

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  @override
  void didUpdateWidget(covariant ListaEventos oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.termoPesquisa != widget.termoPesquisa) {
      _carregar();
    }
  }

  void _carregar() {
    _eventos = DatabaseHelper.instance.listarEventos(widget.termoPesquisa);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Eventos em destaque',
          style: TextStyle(
            color: Color(0xFFB794F6),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 16),

        FutureBuilder<List<Evento>>(
          future: _eventos,

          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 32),
                child: Column(
                  children: [
                    CircularProgressIndicator(
                      semanticsLabel: 'Carregando eventos',
                      color: Color(0xFFB794F6),
                    ),
                    SizedBox(height: 12),
                    Text('Carregando eventos…'),
                  ],
                ),
              );
            }

            if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Column(
                  children: [
                    const Icon(Icons.error_outline),
                    const SizedBox(height: 8),
                    const Text('Não foi possível carregar os eventos.'),
                    const SizedBox(height: 12),
                    OutlinedButton.icon(
                      onPressed: () => setState(_carregar),
                      icon: const Icon(Icons.refresh),
                      label: const Text('Tentar novamente'),
                    ),
                  ],
                ),
              );
            }

            final eventos = snapshot.data ?? [];

            if (eventos.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: Text('Nenhum evento encontrado.')),
              );
            }

            return LayoutBuilder(
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
                  children: [
                    for (final evento in eventos)
                      SizedBox(
                        width: largura,
                        height: altura,
                        child: CardEvento(
                          evento: evento,
                          onTap: () => Navigator.of(context).push<void>(
                            MaterialPageRoute<void>(
                              builder: (_) => EventoDetalhesPage(
                                evento: evento,
                                onInscricao: widget.onInscricao,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }
}
