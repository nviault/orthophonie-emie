import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app.dart';
import 'injection_container.dart' as di;

/// Fonction principale de démarrage de l'application Flutter.
/// On initialise d'abord l'injection de dépendances et Hive avant de lancer l'App.
void main() async {
  // Assure l'initialisation correcte de Flutter avant d'appeler l'injection
  WidgetsFlutterBinding.ensureInitialized();

  // Initialisation de Hive (stockage local pour la session)
  await Hive.initFlutter();
  // Ouverture d'une boite Hive pour stocker les informations de session
  await Hive.openBox('sessionBox');

  // Initialisation de GetIt (service locator)
  await di.init();

  // Lancement de l'interface utilisateur
  runApp(const App());
}
