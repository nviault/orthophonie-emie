/// Contrat du dépôt pour la gestion des sessions.
abstract class SessionRepository {
  /// Enregistre le début d'une nouvelle session.
  Future<void> startSession(DateTime startTime);

  /// Récupère la date de début de la dernière session enregistrée.
  DateTime? getLastSessionStartTime();
}
