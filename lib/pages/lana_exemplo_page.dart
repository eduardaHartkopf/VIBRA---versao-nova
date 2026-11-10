import 'package:flutter/material.dart'; // Componentes da tela de exemplo.
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class LanaExemploPage extends StatefulWidget {
  // Cria a segunda página com o exemplo do contador.
  const LanaExemploPage({super.key}); // Permite abrir a tela sem parâmetros.

  @override // Define o estado da página.
  State<LanaExemploPage> createState() =>
      _LanaExemploPageState(); // Cria o estado que guarda o contador.
} // Fecha a definição da página.

class _LanaExemploPageState extends State<LanaExemploPage> {
  @override // Define a aparência da segunda página.
  Widget build(BuildContext context) {
    // Constrói o exemplo padrão de contador.
    return Scaffold(
      // Cria a estrutura da segunda tela.
      appBar: AppBar(
        // Cria o cabeçalho com a seta automática de voltar.
        title: const Text(
            'Lana Del Rey - Palco Mundo'), // Identifica a página aberta pelo card.
        backgroundColor: Colors.black, // Mantém o fundo preto do aplicativo.
        foregroundColor: Colors.white, // Mantém o título e a seta brancos.
      ), // Fecha o cabeçalho da segunda tela.
      body: Center(
          // Centraliza o conteúdo na página.
          child: Card(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Row(children: [
            Image.asset(
              'assets/images/evento_lana_del_rey.png',
              width: 300,
              height: 200,
              fit: BoxFit.contain,
            ),
            const Expanded(
                child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.location_on_outlined,
                          size: 20, color: Color(0xFFB794F6)),
                      SizedBox(width: 5),
                      Text('Parque das Araucarias - Caçador/SC'),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.calendar_month_outlined,
                          size: 20, color: Color(0xFFB794F6)),
                      SizedBox(width: 5),
                      Text('07.09.2027'),
                      SizedBox(width: 5),
                      Icon(Icons.access_time_outlined,
                          size: 20, color: Color(0xFFB794F6)),
                      SizedBox(width: 5),
                      Text('16:00')
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                      'Prepare-se para uma noite inesquecível ao som de Lana Del Rey!'),
                  SizedBox(height: 10),
                  Text(
                      'Venha viver uma experiência musical única, repleta de emoção, romantismo e grandes sucessos. Uma apresentação especial que promete transportar o público para a atmosfera nostálgica e envolvente de suas músicas. Não perca essa oportunidade!')
                ],
              ),
            ))
          ]),
          const SizedBox(height: 10),
          const Divider(
            color: Color(0xFFB794F6),
            thickness: 1,
            height: 20,
            indent: 0,
            endIndent: 0,
          ),
          const SizedBox(height: 16),
          const Text('Localização do Evento'),
          const SizedBox(height: 16,),
          SizedBox(
              height: 250,
              width: double.infinity,
              child: FlutterMap(
                options: const MapOptions(
                  initialCenter:
                      LatLng(-26.77909100084578, -51.050264281978805),
                  initialZoom: 15,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.vibra',
                  ),
                  const MarkerLayer(
                    markers: [
                      Marker(
                          point:
                              LatLng(-26.77909100084578, -51.050264281978805),
                          width: 50,
                          height: 50,
                          child: Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 40,
                          ))
                    ],
                  )
                ],
              ))
        ]),
      )), // Fecha o conteúdo centralizado.
    ); // Retorna a segunda tela montada.
  } // Fecha a construção visual da página.
} // Fecha o estado da segunda tela.
