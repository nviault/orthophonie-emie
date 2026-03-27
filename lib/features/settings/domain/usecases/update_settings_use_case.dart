import '../repositories/settings_repository.dart';

/// Cas d'utilisation pour mettre à jour les réglages parents (Caméra, Seuil, Son).
class UpdateSettingsUseCase {
  final SettingsRepository repository;

  UpdateSettingsUseCase(this.repository);

  Future<void> updateCamera(bool enabled) async {
    await repository.setCameraEnabled(enabled);
  }

  Future<void> updateSoundOfDay(String soundId) async {
    await repository.setSoundOfDay(soundId);
  }

  Future<void> updateVolumeThreshold(double threshold) async {
    await repository.setVolumeThreshold(threshold);
  }
}
