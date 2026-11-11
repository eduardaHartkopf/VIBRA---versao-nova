import '../theme/vibra_theme.dart';

import 'package:flutter/material.dart'; // Componentes visuais do Flutter.
import 'package:carousel_slider/carousel_slider.dart'
    as carousel; // Biblioteca do carrossel.

class BannersCarrossel extends StatefulWidget {
  // Separa o carrossel do formulário e da lista.
  const BannersCarrossel({
    super.key,
  }); // Permite criar o componente sem dados externos.

  @override // Implementa o estado deste componente.
  State<BannersCarrossel> createState() => _BannersCarrosselState(); // Cria o controle dos banners.
} // Fecha o componente do carrossel.

class _BannersCarrosselState extends State<BannersCarrossel> {
  // Guarda qual banner está visível.
  final _controller = carousel.CarouselSliderController(); // Controla a troca pelas setas e indicadores.
  int _bannerAtual = 0; // Começa com o primeiro banner selecionado.
  static const _imagens = [
    // Define a ordem dos arquivos incluídos no aplicativo.
    'assets/images/banner_eletro_music.png', // Primeiro banner: Eletro Music.
    'assets/images/banner_festival_neon.png', // Segundo banner: Summer Electro Music.
    'assets/images/banner_electronic_fest.png', // Terceiro banner: Electronic Music Fest.
  ]; // Fecha a lista de imagens.
  static const _descricoes = [
    // Descreve os banners para leitores de tela.
    'Eletro Music — ingressos premium', // Descrição do primeiro banner.
    'Summer Electro Music Festival', // Descrição do segundo banner.
    'Electronic Music Fest — Night Party', // Descrição do terceiro banner.
  ]; // Fecha a lista de descrições.

  @override // Define o conteúdo visual do componente.
  Widget build(BuildContext context) {
    // Monta o carrossel e os controles.
    return Column(
      // Organiza os banners e os indicadores na vertical.
      children: [
        // Inicia os elementos do carrossel.
        Center(
          child: FractionallySizedBox(
            widthFactor: 0.96,
            child: Stack(
              // Coloca as setas sobre o carrossel.
              alignment: Alignment
                  .center, // Centraliza os controles na altura do banner.
              children: [
                // Inicia as camadas do banner.
                carousel.CarouselSlider.builder(
                  // Cria os banners com a biblioteca carousel_slider.
                  carouselController: _controller, // Conecta as setas e os indicadores ao carrossel.
                  itemCount: _imagens.length, // Define a quantidade de banners.
                  options: carousel.CarouselOptions(
                    // Configura a passagem das fotos.
                    aspectRatio: 2, // Mantém a proporção de duas unidades de largura para uma de altura.
                    viewportFraction: 1, // Exibe um banner inteiro por vez.
                    autoPlay: !MediaQuery.of(context).disableAnimations, // Respeita a preferência do sistema por reduzir animações.
                    autoPlayInterval: const Duration(
                      seconds: 4,
                    ), // Troca o banner a cada quatro segundos.
                    autoPlayAnimationDuration: const Duration(
                      milliseconds: 600,
                    ), // Define a duração da transição.
                    autoPlayCurve:
                        Curves.easeInOut, // Suaviza o início e o fim da troca.
                    enableInfiniteScroll:
                        true, // Volta ao primeiro banner depois do último.
                    pauseAutoPlayOnTouch: true, // Pausa a troca automática enquanto o usuário interage.
                    onPageChanged: (index, reason) {
                      // Detecta a troca automática ou manual.
                      setState(
                        () => _bannerAtual = index,
                      ); // Atualiza o indicador do banner atual.
                    }, // Fecha a atualização do indicador.
                  ), // Fecha as opções do carrossel.
                  itemBuilder: (context, index, realIndex) => ClipRRect(
                    // Arredonda os cantos de cada banner.
                    borderRadius: BorderRadius.circular(
                      12,
                    ), // Define o arredondamento dos cantos.
                    child: Image.asset(
                      // Carrega a imagem local, sem depender da internet.
                      _imagens[index], // Seleciona a imagem pela posição na lista.
                      width: double.infinity, // Usa toda a largura disponível.
                      fit: BoxFit.contain, // Mostra a arte inteira sem cortar ou distorcer.
                      semanticLabel: _descricoes[index], // Descreve a imagem para leitores de tela.
                    ), // Fecha a imagem.
                  ), // Fecha os cantos arredondados.
                ), // Fecha o carrossel de imagens.
                Positioned(
                  // Posiciona a seta anterior.
                  left: 4, // Afasta a seta da borda esquerda.
                  child: IconButton(
                    // Cria o botão de voltar.
                    tooltip: 'Banner anterior', // Descreve a ação do botão.
                    style: IconButton.styleFrom(
                      backgroundColor: VibraCores.fundoSobreImagem,
                    ), // Destaca a seta sobre fotos claras.
                    icon: const Icon(
                      Icons.chevron_left,
                      color: VibraCores.texto,
                    ), // Mostra a seta branca para a esquerda.
                    onPressed: () => _controller
                        .previousPage(), // Volta para o banner anterior.
                  ), // Fecha o botão de voltar.
                ), // Fecha o posicionamento da seta esquerda.
                Positioned(
                  // Posiciona a seta seguinte.
                  right: 4, // Afasta a seta da borda direita.
                  child: IconButton(
                    // Cria o botão de avançar.
                    tooltip: 'Próximo banner', // Descreve a ação do botão.
                    style: IconButton.styleFrom(
                      backgroundColor: VibraCores.fundoSobreImagem,
                    ), // Destaca a seta sobre fotos claras.
                    icon: const Icon(
                      Icons.chevron_right,
                      color: VibraCores.texto,
                    ), // Mostra a seta branca para a direita.
                    onPressed: () =>
                        _controller.nextPage(), // Avança para o próximo banner.
                  ), // Fecha o botão de avançar.
                ), // Fecha o posicionamento da seta direita.
              ], // Fecha as camadas do banner.
            ), // Fecha a sobreposição das setas.
          ), // Fecha o limite de largura.
        ), // Fecha a centralização do carrossel.
        Row(
          // Organiza os indicadores abaixo dos banners.
          mainAxisAlignment:
              MainAxisAlignment.center, // Centraliza os indicadores.
          children: List.generate(_imagens.length, (index) {
            // Cria um indicador clicável para cada banner.
            return IconButton(
              // Permite selecionar um banner pelo indicador.
              tooltip: 'Mostrar banner ${index + 1}', // Identifica o destino do botão.
              onPressed: () => _controller.animateToPage(
                index,
              ), // Vai diretamente para o banner escolhido.
              icon: Icon(
                // Desenha a bolinha do indicador.
                _bannerAtual == index ? Icons.circle : Icons.circle_outlined, // Preenche a bolinha do banner atual.
                size: 10, // Define o tamanho da bolinha.
                color: VibraCores
                    .texto, // Mantém o indicador visível no fundo preto.
              ), // Fecha o ícone do indicador.
            ); // Fecha o botão indicador.
          }), // Fecha a criação dos indicadores.
        ), // Fecha a linha dos indicadores.
      ], // Fecha os elementos do carrossel.
    ); // Retorna o componente montado.
  } // Fecha a construção visual.
} // Fecha o estado do carrossel.
