import '../entities/volume_state.dart';

/// Cas d'utilisation pour évaluer l'état du volume (monstre)
/// à partir d'une valeur de décibels.
class EvaluateVolumeUseCase {
  /// Seuil de silence ou faible volume (petit)
  static const double silenceThreshold = -40.0;
  /// Seuil pour devenir un super héros (fort)
  static const double strongThreshold = -15.0;

  /// Traduit une valeur dB en un état visuel pour l'enfant.
  VolumeState call(double decibels) {
    if (decibels < silenceThreshold) {
      return VolumeState.small;
    } else if (decibels < strongThreshold) {
      return VolumeState.normal;
    } else {
      return VolumeState.superHero;
    }
  }
}
