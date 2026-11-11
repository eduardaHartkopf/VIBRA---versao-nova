import 'package:flutter/material.dart'; // Componentes da tela inicial.

import '../widgets/banners_carrossel.dart'; // Banners com troca automática.
import '../widgets/lista_eventos.dart'; // Lista com os três cards de eventos.

import '../widgets/menu_vibra.dart';
import '../theme/vibra_theme.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({super.key, required this.convidados});

  final List<Map<String, dynamic>> convidados;

  @override
  State<InicioPage> createState() => _InicioPage();
}

class _InicioPage extends State<InicioPage> {
  final TextEditingController _pesquisaController = TextEditingController();

  String _termoPesquisa = '';
  @override
  void dispose() {
    _pesquisaController.dispose();
    super.dispose();
  }

  @override // Define o conteúdo da página.
  Widget build(BuildContext context) {
    // Monta o cabeçalho e os eventos.
    return Scaffold(
      // Cria a estrutura visual da tela.
      appBar: BarraVibra(
        inicio: true,
        titulo: Semantics(
          // Acrescenta uma descrição para leitores de tela.
          label: 'VIBRA — Eventos e festas', // Nome da marca anunciado pelos leitores de tela.
          child: Image.asset(
            // Carrega a logo incluída nos arquivos do aplicativo.
            'assets/images/logo_vibra.png', // Caminho da imagem registrado no pubspec.yaml.
            width: (MediaQuery.sizeOf(context).width * 0.32)
                .clamp(64.0, 140.0)
                .toDouble(), // Define a largura disponível para a logo.
            height: 48, // Mantém a logo dentro da altura da barra superior.
            fit: BoxFit.contain, // Mostra a imagem inteira sem distorcer as proporções.
            excludeFromSemantics:
                true, // Usa a descrição acessível do Semantics acima.
          ), // Fecha a imagem da logo.
        ), // Fecha a descrição acessível do símbolo.
      ),
      endDrawer: const MenuVibra(),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, limites) => Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 960),
              child: ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: (limites.maxWidth * 0.04)
                      .clamp(8.0, 32.0)
                      .toDouble(),
                  vertical: 16,
                ),
                children: [
                  // Inicia os elementos da página.
                  const BannersCarrossel(), // Mostra os três banners abaixo do cabeçalho.
                  const SizedBox(
                    height: 20,
                  ), // Separa os banners dos próximos elementos.
                  Semantics(
                    // Identifica o título para leitores de tela.
                    header: true, // Marca o texto como um cabeçalho.
                    child: const Text(
                      // Exibe o título principal abaixo do carrossel.
                      'Aqui você encontra os maiores eventos e festas de SC.', // Texto do título.
                      textAlign:
                          TextAlign.center, // Centraliza as linhas do título.
                      style: TextStyle(
                        // Configura a aparência do título.
                        color: VibraCores.texto, // Define a fonte branca.
                        fontSize: 28, // Destaca o título principal.
                        fontWeight:
                            FontWeight.bold, // Deixa o título em negrito.
                        height:
                            1.2, // Define o espaço entre as linhas do título.
                      ), // Fecha o estilo do título.
                    ), // Fecha o texto do título.
                  ), // Fecha a identificação acessível do título.
                  const SizedBox(height: 12), // Separa o título do subtítulo.
                  const Text(
                    // Exibe a descrição abaixo do título.
                    'O calendário das festas e eventos organizados por datas.', // Texto do subtítulo.
                    textAlign:
                        TextAlign.center, // Centraliza as linhas do subtítulo.
                    style: TextStyle(
                      // Configura a aparência do subtítulo.
                      color: VibraCores.texto, // Define a fonte branca.
                      fontSize: 16, // Usa um tamanho menor que o título.
                      height: 1.5, // Facilita a leitura em mais de uma linha.
                    ), // Fecha o estilo do subtítulo.
                  ), // Fecha o texto do subtítulo.
                  const SizedBox(
                    height: 24,
                  ), // Separa a apresentação da lista de eventos.
                  FilledButton.icon(
                    onPressed: () =>
                        Navigator.of(context)
                            .pushNamed<void>(MenuVibra.rotaConvidados),
                    icon: const Icon(Icons.people_outline),
                    label: const Text('Gerenciar convidados'),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _pesquisaController,
                    decoration: const InputDecoration(
                      hintText: 'Buscar Evento',
                      prefixIcon: Icon(Icons.search),
                      filled: true,
                    ),

                    onChanged: (value) {
                      setState(() {
                        _termoPesquisa = value.trim().toLowerCase();
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  ListaEventos(
                    termoPesquisa: _termoPesquisa,
                    onInscricao: (dados) => widget.convidados.add(dados),
                  ), // Exibe os três cards abaixo da apresentação.
                  const SizedBox(
                    height: 24,
                  ), // Deixa espaço depois do último evento.
                ], // Fecha os elementos da página.
              ),
            ),
          ),
        ),
      ),
    ); // Retorna a página montada.
  } // Fecha a construção visual.
} // Fecha a página inicial.
