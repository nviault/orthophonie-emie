import 'package:flutter/material.dart';
import 'app.dart';
import 'injection_container.dart' as di;

/// Fonction principale de démarrage de l'application Flutter.
/// On initialise d'abord l'injection de dépendances avant de lancer l'App.
void main() async {
  // Assure l'initialisation correcte de Flutter avant d'appeler l'injection
  WidgetsFlutterBinding.ensureInitialized();

  // Initialisation de GetIt (service locator)
  await di.init();

  // Lancement de l'interface utilisateur
  runApp(const App());
}
