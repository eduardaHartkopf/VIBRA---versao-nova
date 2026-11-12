import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vibra_eventos/main.dart';

void main() {
  testWidgets('mostra eventos Dart e filtra pela busca', (tester) async {
    tester.view.physicalSize = const Size(1200, 2200);
    tester.view.devicePixelRatio = 1;
    await tester.pumpWidget(const VibraApp());
    await tester.pumpAndSettle();

    expect(find.text('Lana Del Rey | Festival'), findsOneWidget);
    expect(find.text('Zara Larsson | Pop Tropical de Verão'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Dua Lipa');
    await tester.pumpAndSettle();

    expect(find.text('Dua Lipa | Future Nostalgia'), findsOneWidget);
    expect(find.text('Lana Del Rey | Festival'), findsNothing);
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });
}
