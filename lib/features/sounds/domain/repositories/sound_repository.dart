import '../entities/sound.dart';
import '../entities/word.dart';

/// Contrat du dépôt pour la gestion des sons et des mots.
abstract class SoundRepository {
  /// Récupère la liste de tous les sons disponibles.
  Future<List<Sound>> getSounds();

  /// Récupère la liste des mots pour un son donné (par son ID).
  Future<List<Word>> getWordsForSound(String soundId);
}
