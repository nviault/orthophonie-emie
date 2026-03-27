/// Contrat pour le dépôt audio.
abstract class AudioRepository {
  /// Joue un son à partir du chemin de l'asset.
  Future<void> play(String path);

  /// Arrête la lecture en cours.
  Future<void> stop();
}
