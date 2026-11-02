import 'package:flutter/material.dart'; // Componentes da tela de exemplo.

class LanaExemploPage extends StatefulWidget {
  // Cria a segunda página com o exemplo do contador.
  const LanaExemploPage({super.key}); // Permite abrir a tela sem parâmetros.

  @override // Define o estado da página.
  State<LanaExemploPage> createState() =>
      _LanaExemploPageState(); // Cria o estado que guarda o contador.
} // Fecha a definição da página.

class _LanaExemploPageState extends State<LanaExemploPage> {
  // Controla o número mostrado na tela.
  int _contador = 0; // Inicia o contador em zero a cada nova abertura.

  @override // Define a aparência da segunda página.
  Widget build(BuildContext context) {
    // Constrói o exemplo padrão de contador.
    return Scaffold(
      // Cria a estrutura da segunda tela.
      appBar: AppBar(
        // Cria o cabeçalho com a seta automática de voltar.
        title: const Text(
            'Lana Del Rey — Exemplo'), // Identifica a página aberta pelo card.
        backgroundColor: Colors.black, // Mantém o fundo preto do aplicativo.
        foregroundColor: Colors.white, // Mantém o título e a seta brancos.
      ), // Fecha o cabeçalho da segunda tela.
      body: Center(
        // Centraliza o conteúdo na página.
        child: Column(
          // Organiza a explicação e o número na vertical.
          mainAxisAlignment: MainAxisAlignment
              .center, // Centraliza os elementos na altura da tela.
          children: [
            // Inicia os elementos do contador.
            const Text('Você apertou o botão esta quantidade de vezes:',
                textAlign: TextAlign.center), // Explica o contador.
            Text('$_contador',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium), // Mostra o valor atualizado.
          ], // Fecha os elementos do contador.
        ), // Fecha a coluna do contador.
      ), // Fecha o conteúdo centralizado.
      floatingActionButton: FloatingActionButton(
        // Cria o botão de mais no canto inferior.
        tooltip: 'Incrementar contador', // Descreve a ação do botão.
        onPressed: () {
          // Executa a ação quando o botão é pressionado.
          setState(() => _contador++); // Soma um e atualiza o número na tela.
        }, // Fecha a ação do botão.
        child: const Icon(Icons.add), // Mostra o símbolo de mais.
      ), // Fecha o botão do contador.
    ); // Retorna a segunda tela montada.
  } // Fecha a construção visual da página.
} // Fecha o estado da segunda tela.
