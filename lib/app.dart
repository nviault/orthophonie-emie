import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/menu/presentation/pages/menu_page.dart';

/// Point d'entrée de l'application UI (MaterialApp)
/// Gère le thème global et les routes simples.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DysVoix',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      // Page d'accueil initiale
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/menu': (context) => const MenuPage(),
      },
    );
  }
}
