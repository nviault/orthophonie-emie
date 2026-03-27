import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_local_data_source.dart';

/// Implémentation du dépôt pour les réglages parents.
class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource localDataSource;

  SettingsRepositoryImpl({required this.localDataSource});

  @override
  Future<void> savePin(String pin) async {
    await localDataSource.savePin(pin);
  }

  @override
  Future<bool> checkPin(String pin) async {
    final savedPin = await localDataSource.getPin();
    // PIN par défaut si aucun n'est défini : 0000
    if (savedPin == null) return pin == '0000';
    return savedPin == pin;
  }

  @override
  Future<void> setCameraEnabled(bool enabled) async {
    await localDataSource.saveCameraEnabled(enabled);
  }

  @override
  bool isCameraEnabled() {
    return localDataSource.getCameraEnabled();
  }

  @override
  Future<void> setSoundOfDay(String soundId) async {
    await localDataSource.saveSelectedSoundOfDay(soundId);
  }

  @override
  String? getSoundOfDay() {
    return localDataSource.getSelectedSoundOfDay();
  }

  @override
  Future<void> setVolumeThreshold(double threshold) async {
    await localDataSource.saveVolumeThreshold(threshold);
  }

  @override
  double getVolumeThreshold() {
    return localDataSource.getVolumeThreshold();
  }
}
