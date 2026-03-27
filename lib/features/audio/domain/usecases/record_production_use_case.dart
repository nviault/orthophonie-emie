import '../../../../core/audio/audio_manager.dart';

/// Cas d'utilisation pour l'enregistrement et le playback automatique d'un essai de l'enfant.
class RecordProductionUseCase {
  final AudioManager audioManager;

  RecordProductionUseCase(this.audioManager);

  /// Démarre l'enregistrement et joue immédiatement après l'arrêt auto.
  Future<void> call({required Function() onStart, required Function() onStop}) async {
    onStart();
    await audioManager.startRecording(
      onComplete: (path) async {
        onStop();
        // Playback immédiat
        await audioManager.play(path);
      },
    );
  }

  /// Arrête manuellement l'enregistrement.
  Future<void> stop() async {
    await audioManager.stopRecording();
  }
}
