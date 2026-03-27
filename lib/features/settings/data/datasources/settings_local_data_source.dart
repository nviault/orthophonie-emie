import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

/// Source de données pour les réglages parents.
/// Utilise SecureStorage pour le PIN et Hive pour les préférences.
abstract class SettingsLocalDataSource {
  Future<void> savePin(String pin);
  Future<String?> getPin();

  Future<void> saveCameraEnabled(bool enabled);
  bool getCameraEnabled();

  Future<void> saveSelectedSoundOfDay(String soundId);
  String? getSelectedSoundOfDay();

  Future<void> saveVolumeThreshold(double threshold);
  double getVolumeThreshold();
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final FlutterSecureStorage secureStorage;
  final Box settingsBox;

  SettingsLocalDataSourceImpl({
    required this.secureStorage,
    required this.settingsBox,
  });

  @override
  Future<void> savePin(String pin) async {
    await secureStorage.write(key: 'parent_pin', value: pin);
  }

  @override
  Future<String?> getPin() async {
    return await secureStorage.read(key: 'parent_pin');
  }

  @override
  Future<void> saveCameraEnabled(bool enabled) async {
    await settingsBox.put('camera_enabled', enabled);
  }

  @override
  bool getCameraEnabled() {
    return settingsBox.get('camera_enabled', defaultValue: true);
  }

  @override
  Future<void> saveSelectedSoundOfDay(String soundId) async {
    await settingsBox.put('sound_of_day', soundId);
  }

  @override
  String? getSelectedSoundOfDay() {
    return settingsBox.get('sound_of_day');
  }

  @override
  Future<void> saveVolumeThreshold(double threshold) async {
    await settingsBox.put('volume_threshold', threshold);
  }

  @override
  double getVolumeThreshold() {
    return settingsBox.get('volume_threshold', defaultValue: -40.0);
  }
}
