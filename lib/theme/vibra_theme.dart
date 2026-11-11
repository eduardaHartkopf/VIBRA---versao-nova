import 'package:flutter/material.dart';

abstract final class VibraCores {
  static const fundo = Colors.black;
  static const texto = Colors.white;
  static const textoSecundario = Colors.white70;
  static const destaque = Color(0xFFB794F6);
  static const sobreDestaque = Colors.black;
  static const card = Color(0xFF141416);
  static const avatar = Color(0xFF292035);
  static const painel = Color(0xFF211B2C);
  static const trilhoInativo = Color(0xFF50465D);
  static const contorno = Color(0xFF655B71);
  static const sobreImagem = Colors.white;
  static const fundoSobreImagem = Colors.black54;
  static const sombraImagem = Colors.black87;
}

abstract final class VibraTema {
  static const tituloCard = TextStyle(
    color: VibraCores.texto,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  static const detalheCard = TextStyle(
    color: VibraCores.textoSecundario,
    fontSize: 14,
  );
  static const tituloSecao = TextStyle(
    color: VibraCores.destaque,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static const textoSecundario = TextStyle(color: VibraCores.textoSecundario);
  static const raioCard = 18.0;

  static final ButtonStyle botaoDestaque = FilledButton.styleFrom(
    backgroundColor: VibraCores.destaque,
    foregroundColor: VibraCores.sobreDestaque,
    minimumSize: const Size.fromHeight(52),
  );

  static ButtonStyle botaoDestrutivo(BuildContext context) {
    final cores = Theme.of(context).colorScheme;
    return FilledButton.styleFrom(
      backgroundColor: cores.error,
      foregroundColor: cores.onError,
    );
  }

  static final escuro = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: VibraCores.fundo,
    canvasColor: VibraCores.fundo,
    colorScheme: const ColorScheme.dark(
      primary: VibraCores.texto,
      onPrimary: VibraCores.fundo,
      secondary: VibraCores.destaque,
      onSecondary: VibraCores.sobreDestaque,
      surface: VibraCores.fundo,
      onSurface: VibraCores.texto,
      outline: VibraCores.contorno,
      outlineVariant: VibraCores.contorno,
    ),
    dividerColor: VibraCores.contorno,
    textTheme: const TextTheme(
      headlineSmall: tituloSecao,
      titleMedium: tituloCard,
      bodySmall: detalheCard,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: VibraCores.fundo,
      foregroundColor: VibraCores.texto,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      color: VibraCores.card,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(raioCard),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      errorMaxLines: 2,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return null;
        return states.contains(WidgetState.selected)
            ? VibraCores.sobreDestaque
            : VibraCores.texto;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return null;
        return states.contains(WidgetState.selected)
            ? VibraCores.destaque
            : VibraCores.trilhoInativo;
      }),
    ),
  );
}
