import 'package:flutter/material.dart'; // Componentes da tela inicial.
import '../widgets/banners_carrossel.dart'; // Banners com troca automática.
import '../widgets/lista_eventos.dart'; // Lista com os três cards de eventos.

class InicioPage extends StatelessWidget {
  // Página inicial do aplicativo de eventos.
  const InicioPage({super.key}); // Cria a página sem dados externos.

  @override // Define o conteúdo da página.
  Widget build(BuildContext context) {
    // Monta o cabeçalho e os eventos.
    return Scaffold(
      // Cria a estrutura visual da tela.
      appBar: AppBar(
        // Cria a barra superior da tela.
        automaticallyImplyLeading:
            false, // Desativa o botão automático à esquerda.
        backgroundColor:
            Colors.black, // Define o fundo preto da barra superior.
        foregroundColor:
            Colors.white, // Mantém os textos e ícones da barra visíveis.
        surfaceTintColor:
            Colors.transparent, // Evita uma tonalidade extra sobre o fundo.
        elevation: 0, // Remove a sombra da barra.
        centerTitle: true, // Centraliza o conteúdo colocado no título.
        shape: const Border(
          // Define uma borda no cabeçalho.
          bottom: BorderSide(
              color: Colors.white,
              width: 1), // Desenha uma linha branca fina na parte inferior.
        ), // Fecha a borda do cabeçalho.
        title: Semantics(
          // Acrescenta uma descrição para leitores de tela.
          label:
              'VIBRA — Eventos e festas', // Nome da marca anunciado pelos leitores de tela.
          child: Image.asset(
            // Carrega a logo incluída nos arquivos do aplicativo.
            'assets/images/logo_vibra.png', // Caminho da imagem registrado no pubspec.yaml.
            width: 140, // Define a largura disponível para a logo.
            height: 48, // Mantém a logo dentro da altura da barra superior.
            fit: BoxFit
                .contain, // Mostra a imagem inteira sem distorcer as proporções.
            excludeFromSemantics:
                true, // Usa a descrição acessível do Semantics acima.
          ), // Fecha a imagem da logo.
        ), // Fecha a descrição acessível do símbolo.
        actions: [
          // Define os elementos à direita da barra.
          Builder(
            // Obtém um contexto que consegue acessar este Scaffold.
            builder: (context) => IconButton(
              // Constrói o botão usando esse contexto.
              tooltip:
                  'Abrir menu', // Define a dica e a descrição acessível do botão.
              icon: const Icon(Icons.menu,
                  size: 30), // Mostra o ícone de três linhas.
              onPressed: () => Scaffold.of(context)
                  .openEndDrawer(), // Abre o menu lateral direito ao tocar.
            ), // Fecha o botão de menu.
          ), // Fecha o Builder.
          const SizedBox(width: 8), // Deixa um espaço de 8 à direita do botão.
        ], // Fecha a lista de elementos da barra.
      ), // Fecha a barra superior.
      endDrawer: Drawer(
        // Cria o menu que desliza a partir da direita.
        backgroundColor: Colors.black, // Define o fundo preto do menu lateral.
        surfaceTintColor:
            Colors.transparent, // Evita uma tonalidade extra sobre o preto.
        child: SafeArea(
          // Mantém o conteúdo longe das áreas reservadas do sistema.
          child: Column(
            // Organiza os elementos do menu na vertical.
            crossAxisAlignment: CrossAxisAlignment
                .stretch, // Estende os elementos pela largura disponível.
            children: [
              // Inicia a lista de elementos do menu.
              Padding(
                // Adiciona espaço ao redor do cabeçalho.
                padding: const EdgeInsets.fromLTRB(20, 12, 8,
                    12), // Espaços à esquerda, acima, à direita e abaixo.
                child: Row(
                  // Coloca o título e o botão de fechar lado a lado.
                  children: [
                    // Inicia os elementos dessa linha.
                    const Expanded(
                      // Reserva para o título o espaço restante da linha.
                      child: Text(
                        // Cria o texto do cabeçalho.
                        'Eventos e festas', // Define o título exibido no menu.
                        style: TextStyle(
                          // Configura a aparência do título.
                          fontSize: 20, // Define o tamanho da fonte.
                          fontWeight:
                              FontWeight.bold, // Deixa o título em negrito.
                        ), // Fecha o estilo do texto.
                      ), // Fecha o texto do cabeçalho.
                    ), // Fecha o espaço flexível do título.
                    IconButton(
                      // Cria o botão para fechar o menu.
                      tooltip:
                          'Fechar menu', // Define a dica e a descrição acessível do botão.
                      icon: const Icon(Icons.close), // Mostra o ícone de X.
                      onPressed: () =>
                          Navigator.pop(context), // Fecha o menu aberto.
                    ), // Fecha o botão de fechar.
                  ], // Fecha a lista de elementos da linha.
                ), // Fecha a linha do cabeçalho.
              ), // Fecha o espaçamento do cabeçalho.
              const Divider(
                  height: 1,
                  color: Colors.black), // Define a linha divisória preta.
              ListTile(
                // Cria uma opção clicável do menu.
                leading: const Icon(
                    Icons.home_outlined), // Mostra uma casa à esquerda.
                title: const Text('Início'), // Define o nome da opção.
                onTap: () => Navigator.pop(
                    context), // Fecha o menu, pois já estamos na tela inicial.
              ), // Fecha a opção Início.
            ], // Fecha a lista de elementos do menu.
          ), // Fecha a coluna.
        ), // Fecha a área segura.
      ), // Fecha o menu lateral.
      body: Padding(
        // Acrescenta espaço ao redor do conteúdo.
        padding: const EdgeInsets.all(16), // Define a margem interna da página.
        child: ListView(
          // Permite rolar pelos banners e eventos.
          children: [
            // Inicia os elementos da página.
            const BannersCarrossel(), // Mostra os três banners abaixo do cabeçalho.
            const SizedBox(
                height: 20), // Separa os banners dos próximos elementos.
            Semantics(
              // Identifica o título para leitores de tela.
              header: true, // Marca o texto como um cabeçalho.
              child: const Text(
                // Exibe o título principal abaixo do carrossel.
                'Aqui você encontra os maiores eventos e festas de SC.', // Texto do título.
                textAlign: TextAlign.center, // Centraliza as linhas do título.
                style: TextStyle(
                  // Configura a aparência do título.
                  color: Colors.white, // Define a fonte branca.
                  fontSize: 28, // Destaca o título principal.
                  fontWeight: FontWeight.bold, // Deixa o título em negrito.
                  height: 1.2, // Define o espaço entre as linhas do título.
                ), // Fecha o estilo do título.
              ), // Fecha o texto do título.
            ), // Fecha a identificação acessível do título.
            const SizedBox(height: 12), // Separa o título do subtítulo.
            const Text(
              // Exibe a descrição abaixo do título.
              'O calendário das festas e eventos organizados por datas.', // Texto do subtítulo.
              textAlign: TextAlign.center, // Centraliza as linhas do subtítulo.
              style: TextStyle(
                // Configura a aparência do subtítulo.
                color: Colors.white, // Define a fonte branca.
                fontSize: 16, // Usa um tamanho menor que o título.
                height: 1.5, // Facilita a leitura em mais de uma linha.
              ), // Fecha o estilo do subtítulo.
            ), // Fecha o texto do subtítulo.
            const SizedBox(
                height: 24), // Separa a apresentação da lista de eventos.
            const ListaEventos(), // Exibe os três cards abaixo da apresentação.
            const SizedBox(height: 24), // Deixa espaço depois do último evento.
          ], // Fecha os elementos da página.
        ), // Fecha a lista rolável.
      ), // Fecha o espaço ao redor do conteúdo.
    ); // Retorna a página montada.
  } // Fecha a construção visual.
} // Fecha a página inicial.
