import '../repositories/settings_repository.dart';

/// Cas d'utilisation pour vérifier le code PIN parent.
class CheckPinUseCase {
  final SettingsRepository repository;

  CheckPinUseCase(this.repository);

  Future<bool> call(String pin) async {
    return await repository.checkPin(pin);
  }
}

/// Cas d'utilisation pour changer le code PIN parent.
class SavePinUseCase {
  final SettingsRepository repository;

  SavePinUseCase(this.repository);

  Future<void> call(String pin) async {
    await repository.savePin(pin);
  }
}
