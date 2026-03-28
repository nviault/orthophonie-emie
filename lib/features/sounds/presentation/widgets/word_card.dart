import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../bloc/audio_controller.dart';

/// Carte représentant un mot avec son image, audio et feedback visuel.
class WordCard extends StatelessWidget {
  final String label;
  final String imagePath;
  final String audioPath;
  final AudioController controller;

  const WordCard({
    super.key,
    required this.label,
    required this.imagePath,
    required this.audioPath,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return GestureDetector(
          onTap: () => controller.play(audioPath),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedScale(
                scale: controller.isPlaying ? 1.15 : 1.0,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: controller.isPlaying
                        ? AppTheme.leafGreen.withValues(alpha: 0.3)
                        : AppTheme.sandBeige,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: controller.isPlaying ? AppTheme.leafGreen : AppTheme.woodBrown,
                      width: 3,
                    ),
                    boxShadow: [
                      if (controller.isPlaying)
                        BoxShadow(
                          color: AppTheme.leafGreen.withValues(alpha: 0.4),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      imagePath,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.image,
                        size: 100,
                        color: AppTheme.leafGreen,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                label.toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.woodBrown,
                  fontSize: 14,
                ),
              ),
              Icon(
                controller.isPlaying ? Icons.volume_up : Icons.play_circle_fill,
                size: 32,
                color: controller.isPlaying ? AppTheme.buttonOrange : AppTheme.buttonOrange.withValues(alpha: 0.7),
              ),
            ],
          ),
        );
      },
    );
  }
}
