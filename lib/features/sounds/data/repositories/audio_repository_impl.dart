import 'package:just_audio/just_audio.dart';
import '../../domain/repositories/audio_repository.dart';

/// Implémentation du dépôt audio utilisant le package just_audio.
class AudioRepositoryImpl implements AudioRepository {
  final AudioPlayer _player;

  AudioRepositoryImpl(this._player);

  @override
  Future<void> play(String path) async {
    try {
      // Pour les assets, on utilise setAsset
      await _player.setAsset(path);
      await _player.play();
    } catch (e) {
      // Ignorer l'erreur ou utiliser un logger
    }
  }

  @override
  Future<void> stop() async {
    await _player.stop();
  }
}
