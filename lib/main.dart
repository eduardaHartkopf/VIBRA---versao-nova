import 'package:flutter/material.dart'; // Componentes e tema do Flutter.
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart'
  show databaseFactoryFfi, sqfliteFfiInit;
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'pages/inicio_page.dart'; // Tela inicial com os banners e eventos.
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if(kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
  } else if(defaultTargetPlatform == TargetPlatform.windows) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(const VibraApp());
}

class VibraApp extends StatelessWidget {
  // Configura o aplicativo inteiro.
  const VibraApp({super.key}); // Permite criar o aplicativo como constante.

  @override // Define a configuração visual do aplicativo.
  Widget build(BuildContext context) {
    // Monta o tema e a primeira página.
    return MaterialApp(
      // Configura o aplicativo com os componentes Material.
      title: 'VIBRA — Eventos e festas', // Define o nome do aplicativo.
      debugShowCheckedModeBanner:
          false, // Esconde a faixa de depuração da interface.
      theme: ThemeData(
        // Reúne as configurações visuais do aplicativo.
        useMaterial3: true, // Usa o estilo Material 3.
        brightness: Brightness.dark, // Usa textos claros sobre o fundo escuro.
        scaffoldBackgroundColor:
            Colors.black, // Define o fundo preto das telas.
        canvasColor: Colors.black, // Define o fundo padrão das superfícies.
        colorScheme: const ColorScheme.dark(
          // Configura as cores principais.
          primary: Colors.white, // Mantém os controles principais claros.
          onPrimary: Colors.black, // Usa texto preto sobre os controles claros.
          surface: Colors.black, // Define superfícies pretas.
          onSurface:
              Colors.white, // Usa textos e ícones brancos nas superfícies.
          outline: Colors.black, // Mantém os contornos pretos.
          outlineVariant:
              Colors.black, // Mantém os contornos secundários pretos.
        ), // Fecha o conjunto de cores.
        dividerColor: Colors.black, // Define a cor padrão das divisórias.
      ), // Fecha o tema do aplicativo.
      home: const InicioPage(), // Abre diretamente a tela de eventos.
    ); // Retorna o aplicativo configurado.
  } // Fecha a construção do aplicativo.
} // Fecha a classe principal.
