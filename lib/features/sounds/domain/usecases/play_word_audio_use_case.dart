import '../repositories/audio_repository.dart';

/// Cas d'utilisation pour jouer l'audio d'un mot (modèle).
class PlayWordAudio {
  final AudioRepository repository;

  PlayWordAudio(this.repository);

  Future<void> call(String path) async {
    // On s'assure de stopper avant de rejouer
    await repository.stop();
    await repository.play(path);
  }
}
