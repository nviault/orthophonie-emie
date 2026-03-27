import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../audio/domain/entities/volume_state.dart';

/// Widget interactif représentant un "monstre" qui réagit au volume.
/// UX enfant : sans texte, juste visuel.
class VolumeMonsterWidget extends StatelessWidget {
  final VolumeState state;

  const VolumeMonsterWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    // Changement de taille et de couleur selon l'état
    double size = 80.0;
    Color color = AppTheme.leafGreen;
    IconData icon = Icons.sentiment_neutral;

    switch (state) {
      case VolumeState.small:
        size = 60.0;
        color = AppTheme.skyBlue;
        icon = Icons.sentiment_satisfied;
        break;
      case VolumeState.normal:
        size = 100.0;
        color = AppTheme.leafGreen;
        icon = Icons.sentiment_very_satisfied;
        break;
      case VolumeState.superHero:
        size = 150.0;
        color = AppTheme.buttonOrange;
        icon = Icons.auto_awesome;
        break;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: AppTheme.woodBrown, width: 4),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 15,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Center(
        child: Icon(
          icon,
          size: size * 0.6,
          color: Colors.white,
        ),
      ),
    );
  }
}
