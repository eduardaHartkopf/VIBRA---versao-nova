import 'package:flutter/material.dart';

import '../pages/lana_exemplo_page.dart';
import '../database/database_helper.dart';
import '../models/evento.dart';
import 'card_evento.dart';

class ListaEventos extends StatelessWidget {
  const ListaEventos({
    super.key,
    required this.termoPesquisa,
    required this.onInscricao,
  });

  final String termoPesquisa;
  final ValueChanged<Map<String, dynamic>> onInscricao;

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
          future: DatabaseHelper.instance.listarEventos(termoPesquisa),

          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return const Center(child: Text('Erro ao carregar os eventos.'));
            }

            final eventos = snapshot.data ?? [];

            if (eventos.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: Text('Nenhum evento encontrado.')),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: eventos.length,

              itemBuilder: (context, index) {
                final evento = eventos[index];

                return CardEvento(
                  evento: evento,
                  onTap: () => Navigator.of(context).push<void>(
                    MaterialPageRoute<void>(
                      builder: (_) => EventoDetalhesPage(
                        evento: evento,
                        onInscricao: onInscricao,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
