import 'package:flutter_test/flutter_test.dart';
import 'package:dysvoix/app.dart';
import 'package:dysvoix/injection_container.dart' as di;

void main() {
  setUp(() async {
    await di.init();
  });

  testWidgets('Test de fumée : l\'application démarre et affiche le bouton Commencer', (WidgetTester tester) async {
    // Construction de l'application
    await tester.pumpWidget(const App());

    // Vérification de la présence du texte de bienvenue
    expect(find.text('Bienvenue dans DysVoix !'), findsOneWidget);

    // Vérification de la présence du bouton Commencer
    expect(find.text('Commencer'), findsOneWidget);

    // Tap sur le bouton Commencer
    await tester.tap(find.byText('Commencer'));
    await tester.pumpAndSettle();

    // Vérification qu'on est arrivé sur le menu
    expect(find.text('Que souhaites-tu faire ?'), findsOneWidget);
  });
}
