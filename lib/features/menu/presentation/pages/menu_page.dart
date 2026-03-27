import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// Page de Menu (Dashboard) de DysVoix.
/// Présente les choix simples pour l'enfant après avoir cliqué sur Commencer.
class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.dashboard,
              size: 80,
              color: AppTheme.bubblePink,
            ),
            const SizedBox(height: 20),

            Text(
              'Que souhaites-tu faire ?',
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.woodBrown,
              ),
            ),
            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                onPressed: () {
                  // Action pour les exercices
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.skyBlue,
                ),
                child: const Text('Mes exercices'),
              ),
            ),

            const SizedBox(height: 20),

            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/');
              },
              child: Text(
                'Retour',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: AppTheme.woodBrown,
                  fontSize: 18,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
