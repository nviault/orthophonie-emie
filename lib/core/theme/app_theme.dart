import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart'; // Commenté pour respecter la contrainte "Aucun réseau"

/// Classe définissant le thème de l'application inspiré par l'univers "Animal Crossing"
/// Ce thème utilise des couleurs pastel, des formes arrondies et des polices douces.
class AppTheme {
  // Palette de couleurs inspirée d'Animal Crossing
  static const Color leafGreen = Color(0xFF7CB342);
  static const Color skyBlue = Color(0xFF81D4FA);
  static const Color sandBeige = Color(0xFFFFF9C4);
  static const Color woodBrown = Color(0xFF8D6E63);
  static const Color softWhite = Color(0xFFFAFAFA);
  static const Color buttonOrange = Color(0xFFFFB74D);
  static const Color bubblePink = Color(0xFFF48FB1);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: leafGreen,
        primary: leafGreen,
        secondary: bubblePink,
        surface: sandBeige,
      ),
      // Utilisation d'une police système ronde par défaut pour éviter le réseau (google_fonts)
      // En production, on inclurait le fichier .ttf dans assets/fonts/
      fontFamily: 'Verdana', // Verdana est largement disponible et assez lisible/ronde

      // Style des boutons (bien arrondis)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonOrange,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: const BorderSide(color: woodBrown, width: 2),
          ),
          elevation: 4,
        ),
      ),

      // Style de l'AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: leafGreen,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),

      // Style des cartes
      cardTheme: CardThemeData(
        color: sandBeige,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
          side: const BorderSide(color: leafGreen, width: 2),
        ),
      ),
    );
  }
}
