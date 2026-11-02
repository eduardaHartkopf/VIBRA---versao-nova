import 'package:flutter/material.dart'; // Componentes e navegação do Flutter.
import '../pages/lana_exemplo_page.dart'; // Tela aberta pelo card da Lana Del Rey.
import 'card_evento.dart'; // Modelo visual reutilizável de cada evento.

class ListaEventos extends StatelessWidget {
  // Monta a seção com os eventos de exemplo.
  const ListaEventos(
      {super.key}); // Permite reutilizar a lista na página inicial.

  static const _eventos = [
    // Guarda os dados provisórios usados no front-end.
    (
      nome: 'Lana Del Rey | Festival',
      imagem: 'assets/images/evento_lana_del_rey.png'
    ), // Primeiro evento e sua imagem.
    (
      nome: 'Zara Larsson | Pop Tropical de Verão',
      imagem: 'assets/images/evento_pop_tropical.png'
    ), // Segundo evento e sua imagem.
    (
      nome: 'Dua Lipa | Future Nostalgia',
      imagem: 'assets/images/evento_future_nostalgia.png'
    ), // Terceiro evento e sua imagem.
  ]; // Fecha a lista de eventos demonstrativos.

  @override // Define como a seção aparece na tela.
  Widget build(BuildContext context) {
    // Constrói os cards dos eventos.
    return Column(
      // Organiza o título e a lista na vertical.
      crossAxisAlignment:
          CrossAxisAlignment.stretch, // Usa a largura disponível.
      children: [
        // Inicia os elementos da seção.
        const Text(
          // Exibe o título da seção.
          'Eventos em destaque', // Identifica a lista de eventos.
          style: TextStyle(
              color: Color(0xFFB794F6),
              fontSize: 22,
              fontWeight:
                  FontWeight.bold), // Usa roxo e negrito como na referência.
        ), // Fecha o título da seção.
        const SizedBox(height: 16), // Separa o título do primeiro card.
        ListView.builder(
          // Cria um card para cada evento.
          shrinkWrap: true, // Ajusta a altura à quantidade de eventos.
          physics:
              const NeverScrollableScrollPhysics(), // Mantém a rolagem na página principal.
          itemCount: _eventos.length, // Define a quantidade de cards.
          itemBuilder: (context, index) {
            // Constrói cada card pela sua posição.
            final evento = _eventos[index]; // Obtém os dados do evento atual.
            return CardEvento(
              nome: evento.nome,
              imagem: evento.imagem, // Passa a foto para o card.
              onTap: index == 0
                  ? () {
                      // Ativa a navegação apenas no card da Lana Del Rey.
                      Navigator.push(
                        // Abre outra tela, mantendo a página inicial para voltar.
                        context, // Usa o navegador da página atual.
                        MaterialPageRoute<void>(
                          // Cria a rota com a transição padrão do Material.
                          builder: (context) =>
                              const LanaExemploPage(), // Define qual tela será aberta.
                        ), // Fecha a configuração da rota.
                      ); // Executa a navegação.
                    }
                  : null, // Deixa os outros cards sem ação por enquanto.
            ); // Fecha o card do evento.
          }, // Fecha a construção dos cards.
        ), // Fecha a lista de eventos.
      ], // Fecha os elementos da seção.
    ); // Retorna a seção montada.
  } // Fecha a construção visual da seção.
} // Fecha o componente da lista.
