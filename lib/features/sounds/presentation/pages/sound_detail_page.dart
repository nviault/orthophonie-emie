import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../injection_container.dart';
import '../../../audio/domain/usecases/record_production_use_case.dart';
import '../bloc/sound_detail_bloc.dart';

/// Page affichant les mots associés à un son spécifique.
class SoundDetailPage extends StatefulWidget {
  final String soundId;

  const SoundDetailPage({super.key, required this.soundId});

  @override
  State<SoundDetailPage> createState() => _SoundDetailPageState();
}

class _SoundDetailPageState extends State<SoundDetailPage> {
  bool _isRecording = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SoundDetailBloc>()..add(LoadWordsForSound(soundId: widget.soundId)),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Son ${widget.soundId.toUpperCase()}'),
        ),
        body: SoundDetailView(
          soundId: widget.soundId,
          isRecording: _isRecording,
          onRecordingChanged: (value) {
            setState(() {
              _isRecording = value;
            });
          },
        ),
      ),
    );
  }
}

class SoundDetailView extends StatelessWidget {
  final String soundId;
  final bool isRecording;
  final Function(bool) onRecordingChanged;

  const SoundDetailView({
    super.key,
    required this.soundId,
    required this.isRecording,
    required this.onRecordingChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<SoundDetailBloc, SoundDetailState>(
      builder: (context, state) {
        if (state is SoundDetailLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is SoundDetailLoaded) {
          return Column(
            children: [
              const SizedBox(height: 20),
              Text(
                'Choisis un mot pour t\'entraîner !',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.woodBrown,
                ),
              ),
              const SizedBox(height: 20),

              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
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
                          Icons.image,
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
                          word.schema,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        trailing: ElevatedButton(
                          onPressed: isRecording ? null : () async {
                            // Appel de l'enregistrement via le UseCase
                            final recordUseCase = sl<RecordProductionUseCase>();
                            await recordUseCase(
                              onStart: () => onRecordingChanged(true),
                              onStop: () => onRecordingChanged(false),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isRecording ? Colors.red : AppTheme.buttonOrange,
                            padding: const EdgeInsets.all(10),
                            shape: const CircleBorder(),
                          ),
                          child: Icon(
                            isRecording ? Icons.mic : Icons.mic_none,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () {
                          // TODO: Jouer le son modèle (âne, avion...)
                        },
                      ),
                    );
                  },
                ),
              ),

              if (isRecording)
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'Je t\'écoute...',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
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
    );
  }
}
