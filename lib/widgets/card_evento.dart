import 'dart:math' as math;

import '../models/evento.dart';
import 'dados_evento.dart';

import 'package:flutter/material.dart'; // Componentes usados para montar os cards.

class CardEvento extends StatelessWidget {
  const CardEvento({super.key, required this.evento, this.onTap});

  final Evento evento;
  final VoidCallback? onTap; // Guarda a ação do clique, quando existir.

  static const _titulo = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    height: 1.25,
  );
  static const _detalhe = TextStyle(color: Colors.white70, fontSize: 14);

  static double _tamanhoImagem(double largura) =>
      (largura * 0.24).clamp(44.0, 128.0).toDouble();

  static double alturaPara(
    BuildContext context,
    Evento evento,
    double largura,
  ) {
    final imagem = _tamanhoImagem(largura);
    final estiloPadrao = DefaultTextStyle.of(context);
    double alturaTexto(String texto, TextStyle estilo, double espaco) {
      final medidor = TextPainter(
        text: TextSpan(text: texto, style: estiloPadrao.style.merge(estilo)),
        textDirection: Directionality.of(context),
        textScaler: MediaQuery.textScalerOf(context),
        textHeightBehavior: estiloPadrao.textHeightBehavior,
        textWidthBasis: estiloPadrao.textWidthBasis,
        locale: Localizations.maybeLocaleOf(context),
      )..layout(maxWidth: math.max(0.0, espaco));
      final altura = medidor.height;
      medidor.dispose();
      return altura;
    }

    final larguraTexto = largura - 28 - imagem - 14;
    var altura = alturaTexto(evento.nome, _titulo, larguraTexto) + 10;
    for (final (_, texto) in dadosEvento(evento)) {
      altura +=
          math.max(18.0, alturaTexto(texto, _detalhe, larguraTexto - 24)) + 6;
    }
    return math.max(imagem, altura).ceilToDouble() + 42;
  }

  @override // Define a aparência do card.
  Widget build(BuildContext context) {
    // Monta a foto e as informações.
    return LayoutBuilder(
      builder: (context, limites) {
        final tamanhoImagem = _tamanhoImagem(limites.maxWidth);
        return Card(
          // Cria a caixa do evento.
          margin: const EdgeInsets.only(
            bottom: 14,
          ), // Separa este card do próximo.
          color: const Color(0xFF141416), // Define um fundo cinza bem escuro.
          surfaceTintColor: Colors.transparent, // Preserva a cor do fundo.
          elevation: 0, // Remove a sombra da caixa.
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ), // Arredonda os cantos do card.
          child: InkWell(
            // Permite clicar em toda a área do card.
            onTap: onTap, // Executa a ação recebida da lista de eventos.
            borderRadius: BorderRadius.circular(
              18,
            ), // Arredonda o efeito visual do toque.
            child: Padding(
              // Afasta o conteúdo das bordas da caixa.
              padding: const EdgeInsets.all(
                14,
              ), // Define o espaço interno do card.
              child: Row(
                // Coloca a imagem e os textos lado a lado.
                crossAxisAlignment: CrossAxisAlignment
                    .start, // Alinha a imagem e os textos pelo topo.
                children: [
                  // Inicia os elementos da linha.
                  ClipRRect(
                    // Arredonda os cantos da foto.
                    borderRadius: BorderRadius.circular(
                      12,
                    ), // Define o arredondamento da foto.
                    child: Image.asset(
                      // Carrega a imagem incluída no aplicativo.
                      evento.imagem, // Usa o caminho recebido pelo card.
                      width: tamanhoImagem, // Define a largura da miniatura.
                      height: tamanhoImagem, // Mantém a miniatura quadrada.
                      fit:
                          BoxFit.contain, // Exibe a arte inteira sem distorcer.
                      excludeFromSemantics: true, // Evita repetir o nome anunciado no texto ao lado.
                    ), // Fecha a foto do evento.
                  ), // Fecha os cantos arredondados da foto.
                  const SizedBox(width: 14), // Separa a imagem das informações.
                  Expanded(
                    // Reserva o restante da largura para os textos.
                    child: Column(
                      // Coloca o título, local e data na vertical.
                      crossAxisAlignment: CrossAxisAlignment
                          .start, // Alinha os textos à esquerda.
                      children: [
                        // Inicia as informações do evento.
                        Text(
                          evento.nome,
                          style: _titulo,
                        ), // Exibe o nome e permite quebrar linhas.
                        const SizedBox(
                          height: 10,
                        ), // Separa o título das informações secundárias.
                        for (final (icone, texto) in dadosEvento(evento))
                          Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(icone, color: corDadosEvento, size: 18),
                                const SizedBox(width: 6),
                                Expanded(child: Text(texto, style: _detalhe)),
                              ],
                            ),
                          ),
                      ], // Fecha as informações do evento.
                    ), // Fecha a coluna de textos.
                  ), // Fecha a largura flexível dos textos.
                ], // Fecha os elementos da linha principal.
              ), // Fecha a linha principal do card.
            ), // Fecha o espaço interno do card.
          ), // Fecha a área clicável do card.
        );
      },
    );
  }
}
