import 'package:flutter/material.dart';
import '../../domain/usecases/play_word_audio_use_case.dart';

/// Contrôleur léger pour la lecture audio et les feedbacks visuels.
class AudioController extends ChangeNotifier {
  final PlayWordAudio playWordAudio;

  bool isPlaying = false;

  AudioController(this.playWordAudio);

  /// Lit l'audio du mot modèle.
  Future<void> play(String path) async {
    isPlaying = true;
    notifyListeners();

    await playWordAudio(path);

    isPlaying = false;
    notifyListeners();
  }

  /// Mode répétition pour l'apprentissage.
  Future<void> playWithRepeat(String path) async {
    await play(path);
    await Future.delayed(const Duration(seconds: 1));
    await play(path);
  }
}
