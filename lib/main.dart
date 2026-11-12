import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as ffi;

import 'pages/convidados_page.dart';
import 'pages/inicio_page.dart';
import 'theme/vibra_theme.dart';
import 'widgets/menu_vibra.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.windows) {
    ffi.sqfliteFfiInit();
    sqflite.databaseFactory = ffi.databaseFactoryFfi;
  }
  runApp(const VibraApp());
}

class VibraApp extends StatelessWidget {
  const VibraApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'VIBRA — Eventos e festas',
        debugShowCheckedModeBanner: false,
        theme: VibraTema.escuro,
        home: const InicioPage(),
        routes: {
          MenuVibra.rotaConvidados: (_) => const ConvidadosPage(),
        },
      );
}
