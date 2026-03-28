import 'package:flutter_test/flutter_test.dart';
import 'package:orthophonie_emie/app.dart';
import 'package:orthophonie_emie/injection_container.dart' as di;
import 'package:hive_flutter/hive_flutter.dart';

void main() {
  setUp(() async {
    // Initialisation minimaliste de Hive pour les tests
    Hive.init('.');
    await Hive.openBox('sessionBox');
    await di.init();
  });

  tearDown(() async {
    await Hive.close();
    await di.sl.reset();
  });

  testWidgets('Test de fumée : l\'application démarre et affiche le bouton Commencer', (WidgetTester tester) async {
    // Construction de l'application
    await tester.pumpWidget(const App());

    // Vérification de la présence du texte de bienvenue
    expect(find.text('Bienvenue dans DysVoix !'), findsOneWidget);

    // Vérification de la présence du bouton Commencer
    expect(find.text('Commencer'), findsOneWidget);

    // Tap sur le bouton Commencer
    await tester.tap(find.text('Commencer'));
    await tester.pumpAndSettle();

    // Vérification qu'on est arrivé sur le menu
    expect(find.text('Quel son veux-tu apprendre ?'), findsOneWidget);
  });
}
