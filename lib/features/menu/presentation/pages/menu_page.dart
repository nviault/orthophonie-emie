import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../injection_container.dart';
import '../../../sounds/presentation/bloc/sounds_bloc.dart';
import '../../../sounds/presentation/pages/sound_detail_page.dart';

/// Page de Menu (Dashboard) de DysVoix.
/// Présente les choix de sons sous forme de bulles cliquables pour l'enfant.
class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Fournit le SoundsBloc au menu pour charger la liste des sons au démarrage
    return BlocProvider(
      create: (context) => sl<SoundsBloc>()..add(LoadSounds()),
      child: const MenuView(),
    );
  }
}

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),

            Text(
              'Quel son veux-tu apprendre ?',
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.woodBrown,
              ),
            ),
            const SizedBox(height: 30),

            // Liste des sons (bulles)
            Expanded(
              child: BlocBuilder<SoundsBloc, SoundsState>(
                builder: (context, state) {
                  if (state is SoundsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is SoundsLoaded) {
                    return GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                      itemCount: state.sounds.length,
                      itemBuilder: (context, index) {
                        final sound = state.sounds[index];
                        return _SoundBubble(
                          label: sound.id.toUpperCase(),
                          onTap: () {
                            // Navigation vers le détail du son
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SoundDetailPage(soundId: sound.id),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }

                  if (state is SoundsError) {
                    return Center(child: Text(state.message));
                  }

                  return Container();
                },
              ),
            ),

            const SizedBox(height: 20),

            // Bouton retour
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
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

/// Widget interne pour représenter un son (bulle Animal Crossing style)
class _SoundBubble extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _SoundBubble({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.skyBlue,
          shape: BoxShape.circle,
          border: Border.all(color: AppTheme.woodBrown, width: 3),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              offset: const Offset(2, 4),
              blurRadius: 5,
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
