import 'package:flutter/material.dart'; // Componentes e tema do Flutter.
import 'package:flutter/foundation.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

import 'pages/convidados_page.dart';
import 'theme/vibra_theme.dart';
import 'widgets/menu_vibra.dart';
import 'pages/inicio_page.dart'; // Tela inicial com os banners e eventos.

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
  } else if (defaultTargetPlatform == TargetPlatform.windows) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(const VibraApp());
}

class VibraApp extends StatefulWidget {
  // Configura o aplicativo inteiro.
  const VibraApp({super.key}); // Permite criar o aplicativo como constante.

  @override
  State<VibraApp> createState() => _VibraAppState();
}

class _VibraAppState extends State<VibraApp> {
  final List<Map<String, dynamic>> _convidados = [];

  @override
  Widget build(BuildContext context) {
    // Monta o tema e a primeira página.
    return MaterialApp(
      // Configura o aplicativo com os componentes Material.
      title: 'VIBRA — Eventos e festas', // Define o nome do aplicativo.
      debugShowCheckedModeBanner:
          false, // Esconde a faixa de depuração da interface.
      theme: VibraTema.escuro,
      home: InicioPage(convidados: _convidados),
      routes: {
        MenuVibra.rotaConvidados: (_) =>
            ConvidadosPage(convidados: _convidados),
      },
    ); // Retorna o aplicativo configurado.
  } // Fecha a construção do aplicativo.
} // Fecha a classe principal.
