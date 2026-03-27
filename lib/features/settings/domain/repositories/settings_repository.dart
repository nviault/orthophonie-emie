/// Contrat pour la gestion des réglages parents.
abstract class SettingsRepository {
  Future<void> savePin(String pin);
  Future<bool> checkPin(String pin);

  Future<void> setCameraEnabled(bool enabled);
  bool isCameraEnabled();

  Future<void> setSoundOfDay(String soundId);
  String? getSoundOfDay();

  Future<void> setVolumeThreshold(double threshold);
  double getVolumeThreshold();
}
