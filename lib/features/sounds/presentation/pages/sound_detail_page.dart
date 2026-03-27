import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record/record.dart';
import '../../../../core/audio/audio_manager.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../injection_container.dart';
import '../../../audio/domain/entities/volume_state.dart';
import '../../../audio/domain/usecases/evaluate_volume_use_case.dart';
import '../../../audio/domain/usecases/record_production_use_case.dart';
import '../bloc/sound_detail_bloc.dart';
import '../bloc/audio_controller.dart';
import '../widgets/volume_monster_widget.dart';
import '../widgets/word_card.dart';

/// Page affichant les mots associés à un son spécifique.
class SoundDetailPage extends StatefulWidget {
  final String soundId;

  const SoundDetailPage({super.key, required this.soundId});

  @override
  State<SoundDetailPage> createState() => _SoundDetailPageState();
}

class _SoundDetailPageState extends State<SoundDetailPage> {
  bool _isRecording = false;
  VolumeState _volumeState = VolumeState.small;
  StreamSubscription<Amplitude>? _amplitudeSub;
  final _evaluateVolumeUseCase = EvaluateVolumeUseCase();
  late AudioController _audioController;

  @override
  void initState() {
    super.initState();
    _audioController = sl<AudioController>();
  }

  @override
  void dispose() {
    _amplitudeSub?.cancel();
    _audioController.dispose();
    super.dispose();
  }

  void _startListeningToAmplitude() {
    _amplitudeSub = sl<AudioManager>().onAmplitudeChanged(const Duration(milliseconds: 80)).listen((amp) {
      if (mounted) {
        setState(() {
          _volumeState = _evaluateVolumeUseCase(amp.current);
        });
      }
    });
  }

  void _stopListeningToAmplitude() {
    _amplitudeSub?.cancel();
    _amplitudeSub = null;
    if (mounted) {
      setState(() {
        _volumeState = VolumeState.small;
      });
    }
  }

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
          volumeState: _volumeState,
          audioController: _audioController,
          onRecordingChanged: (value) {
            setState(() {
              _isRecording = value;
              if (_isRecording) {
                _startListeningToAmplitude();
              } else {
                _stopListeningToAmplitude();
              }
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
  final VolumeState volumeState;
  final AudioController audioController;
  final Function(bool) onRecordingChanged;

  const SoundDetailView({
    super.key,
    required this.soundId,
    required this.isRecording,
    required this.volumeState,
    required this.audioController,
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

              if (isRecording)
                Container(
                  height: 180,
                  alignment: Alignment.center,
                  child: VolumeMonsterWidget(state: volumeState),
                )
              else
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'Choisis un mot pour t\'entraîner !',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.woodBrown,
                    ),
                  ),
                ),

              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: state.words.length,
                  itemBuilder: (context, index) {
                    final word = state.words[index];
                    return Stack(
                      children: [
                        WordCard(
                          label: word.id,
                          imagePath: word.image,
                          audioPath: word.audio,
                          controller: audioController,
                        ),
                        // Bouton d'enregistrement par-dessus ou à côté
                        Positioned(
                          right: 0,
                          bottom: 30,
                          child: ElevatedButton(
                            onPressed: isRecording ? null : () async {
                              final recordUseCase = sl<RecordProductionUseCase>();
                              await recordUseCase(
                                onStart: () => onRecordingChanged(true),
                                onStop: () {
                                  onRecordingChanged(false);
                                  // Petit feedback visuel de succès ?
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isRecording ? Colors.red : AppTheme.buttonOrange,
                              padding: const EdgeInsets.all(8),
                              shape: const CircleBorder(),
                              elevation: 2,
                            ),
                            child: Icon(
                              isRecording ? Icons.mic : Icons.mic_none,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
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
    );
  }
}
