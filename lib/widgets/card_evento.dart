import 'package:flutter/material.dart'; // Componentes usados para montar os cards.

class CardEvento extends StatelessWidget {
  // Define a aparência reutilizável de uma caixinha.
  const CardEvento(
      {super.key,
      required this.nome,
      required this.imagem,
      this.onTap}); // Recebe os dados e uma ação opcional ao tocar.
  final String nome; // Guarda o título do evento.
  final String imagem; // Guarda o caminho da imagem nos assets.
  final VoidCallback? onTap; // Guarda a ação do clique, quando existir.

  @override // Define a aparência do card.
  Widget build(BuildContext context) {
    // Monta a foto e as informações.
    return Card(
      // Cria a caixa do evento.
      margin: const EdgeInsets.only(bottom: 14), // Separa este card do próximo.
      color: const Color(0xFF141416), // Define um fundo cinza bem escuro.
      surfaceTintColor: Colors.transparent, // Preserva a cor do fundo.
      elevation: 0, // Remove a sombra da caixa.
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(18)), // Arredonda os cantos do card.
      child: InkWell(
        // Permite clicar em toda a área do card.
        onTap: onTap, // Executa a ação recebida da lista de eventos.
        borderRadius:
            BorderRadius.circular(18), // Arredonda o efeito visual do toque.
        child: Padding(
          // Afasta o conteúdo das bordas da caixa.
          padding: const EdgeInsets.all(14), // Define o espaço interno do card.
          child: Row(
            // Coloca a imagem e os textos lado a lado.
            crossAxisAlignment: CrossAxisAlignment
                .start, // Alinha a imagem e os textos pelo topo.
            children: [
              // Inicia os elementos da linha.
              ClipRRect(
                // Arredonda os cantos da foto.
                borderRadius: BorderRadius.circular(
                    12), // Define o arredondamento da foto.
                child: Image.asset(
                  // Carrega a imagem incluída no aplicativo.
                  imagem, // Usa o caminho recebido pelo card.
                  width: 90, // Define a largura da miniatura.
                  height: 90, // Mantém a miniatura quadrada.
                  fit: BoxFit.contain, // Exibe a arte inteira sem distorcer.
                  excludeFromSemantics:
                      true, // Evita repetir o nome anunciado no texto ao lado.
                ), // Fecha a foto do evento.
              ), // Fecha os cantos arredondados da foto.
              const SizedBox(width: 14), // Separa a imagem das informações.
              Expanded(
                // Reserva o restante da largura para os textos.
                child: Column(
                  // Coloca o título, local e data na vertical.
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Alinha os textos à esquerda.
                  children: [
                    // Inicia as informações do evento.
                    Text(nome,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            height:
                                1.25)), // Exibe o nome e permite quebrar linhas.
                    const SizedBox(
                        height:
                            10), // Separa o título das informações secundárias.
                    const Row(
                      // Coloca o ícone e o local lado a lado.
                      crossAxisAlignment: CrossAxisAlignment
                          .start, // Alinha os elementos pelo topo.
                      children: [
                        // Inicia os elementos do local.
                        Icon(Icons.location_on_outlined,
                            color: Color(0xFFB794F6),
                            size: 20), // Exibe o ícone roxo de localização.
                        SizedBox(width: 6), // Separa o ícone do texto.
                        Expanded(
                            child: Text('Local a definir',
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontSize:
                                        14))), // Evita inventar um endereço para o evento de exemplo.
                      ], // Fecha os elementos do local.
                    ), // Fecha a linha do local.
                    const SizedBox(height: 6), // Separa o local da data.
                    const Row(
                      // Coloca o ícone e a data lado a lado.
                      crossAxisAlignment: CrossAxisAlignment
                          .start, // Alinha os elementos pelo topo.
                      children: [
                        // Inicia os elementos da data.
                        Icon(Icons.calendar_month_outlined,
                            color: Color(0xFFB794F6),
                            size: 20), // Exibe o ícone roxo de calendário.
                        SizedBox(width: 6), // Separa o ícone do texto.
                        Expanded(
                            child: Text('Data e horário a definir',
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontSize:
                                        14))), // Reserva o espaço para os dados que serão informados depois.
                      ], // Fecha os elementos da data.
                    ), // Fecha a linha da data.
                  ], // Fecha as informações do evento.
                ), // Fecha a coluna de textos.
              ), // Fecha a largura flexível dos textos.
            ], // Fecha os elementos da linha principal.
          ), // Fecha a linha principal do card.
        ), // Fecha o espaço interno do card.
      ), // Fecha a área clicável do card.
    ); // Retorna o card montado.
  } // Fecha a construção visual do card.
} // Fecha o componente do card.
