import 'package:flutter/material.dart';

import '../widgets/menu_vibra.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../models/evento.dart';
import '../widgets/dados_evento.dart';
import 'convidado_form_page.dart';

class EventoDetalhesPage extends StatelessWidget {
  const EventoDetalhesPage({
    super.key,
    required this.evento,
    required this.onInscricao,
  });

  final Evento evento;
  final ValueChanged<Map<String, dynamic>> onInscricao;

  Future<void> _inscrever(BuildContext context) async {
    final dados = await Navigator.of(context).push<Map<String, dynamic>>(
      MaterialPageRoute(builder: (_) => ConvidadoFormPage(evento: evento.nome)),
    );
    if (!context.mounted || dados == null) return;
    onInscricao({...dados, 'eventoId': evento.id, 'eventoNome': evento.nome});
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Inscrição confirmada!')));
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    const destaque = Color(0xFFB794F6);
    const ponto = LatLng(-26.77909100084578, -51.050264281978805);
    final localDetalhado = evento.local.toLowerCase().contains(
      'parque das arauc',
    );
    final descricao =
        evento.nome.startsWith('Zara Larsson') &&
            evento.descricao ==
                'Prepare-se para uma noite inesquecível ao som de Lana Del Rey!'
        ? 'Uma apresentação de Zara Larsson com seus sucessos pop.'
        : evento.descricao;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do evento'),
        actions: const [BotaoMenuVibra()],
      ),
      endDrawer: const MenuVibra(),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 880),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(evento.imagem, fit: BoxFit.cover),
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black87],
                            stops: [0.28, 1],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 20,
                        right: 20,
                        bottom: 18,
                        child: Text(
                          evento.nome,
                          style: tema.textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 10,
                runSpacing: 8,
                children: [
                  for (final (icone, texto) in dadosEvento(evento))
                    Chip(
                      avatar: Icon(icone, color: corDadosEvento, size: 18),
                      label: Text(texto),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: destaque,
                  foregroundColor: Colors.black,
                  minimumSize: const Size.fromHeight(52),
                ),
                onPressed: () => _inscrever(context),
                icon: const Icon(Icons.how_to_reg),
                label: const Text('Inscrever-se no evento'),
              ),
              const SizedBox(height: 28),
              Text('Sobre o evento', style: tema.textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(descricao, style: tema.textTheme.bodyLarge),
              const SizedBox(height: 28),
              Text(
                localDetalhado ? 'Local do evento' : 'Mapa de referência',
                style: tema.textTheme.titleLarge,
              ),
              if (!localDetalhado)
                const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    'Mapa da região de Caçador/SC. O endereço exato do evento ainda não foi informado.',
                  ),
                ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  height: 260,
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: ponto,
                      initialZoom: localDetalhado ? 15 : 12,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.vibra',
                      ),
                      if (localDetalhado)
                        const MarkerLayer(
                          markers: [
                            Marker(
                              point: ponto,
                              width: 48,
                              height: 48,
                              child: Icon(
                                Icons.location_on,
                                color: destaque,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                      const SimpleAttributionWidget(
                        source: Text('© OpenStreetMap contributors'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
