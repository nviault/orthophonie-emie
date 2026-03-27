import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../injection_container.dart';
import '../bloc/sound_detail_bloc.dart';

/// Page affichant les mots associés à un son spécifique.
class SoundDetailPage extends StatelessWidget {
  final String soundId;

  const SoundDetailPage({super.key, required this.soundId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SoundDetailBloc>()..add(LoadWordsForSound(soundId: soundId)),
      child: SoundDetailView(soundId: soundId),
    );
  }
}

class SoundDetailView extends StatelessWidget {
  final String soundId;

  const SoundDetailView({super.key, required this.soundId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Son ${soundId.toUpperCase()}'),
      ),
      body: BlocBuilder<SoundDetailBloc, SoundDetailState>(
        builder: (context, state) {
          if (state is SoundDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is SoundDetailLoaded) {
            return Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  'Voici les mots avec le son "${soundId}"',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.woodBrown,
                  ),
                ),
                const SizedBox(height: 20),

                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: state.words.length,
                    itemBuilder: (context, index) {
                      final word = state.words[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          leading: const Icon(
                            Icons.image, // Placeholder pour l'image
                            size: 40,
                            color: AppTheme.leafGreen,
                          ),
                          title: Text(
                            word.id.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.woodBrown,
                            ),
                          ),
                          subtitle: Text(
                            word.schema, // Décomposition syllabique
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.play_circle_fill, // Icône pour jouer le son
                            size: 40,
                            color: AppTheme.buttonOrange,
                          ),
                          onTap: () {
                            // Jouer le son du mot (non implémenté pour l'instant)
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }

          if (state is SoundDetailError) {
            return Center(child: Text(state.message));
          }

          return Container();
        },
      ),
    );
  }
}
