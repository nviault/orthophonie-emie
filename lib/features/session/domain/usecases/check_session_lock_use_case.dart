import '../repositories/session_repository.dart';

/// Cas d'utilisation pour vérifier le verrouillage de la session.
/// Logique :
/// - Durée session max : 10 minutes.
/// - Verrouillage : 2 heures après la fin de la session complète (donc start + 10m + 2h).
class CheckSessionLockUseCase {
  final SessionRepository repository;

  CheckSessionLockUseCase(this.repository);

  /// Retourne le temps restant avant déverrouillage, ou null si libre.
  Duration? call() {
    final lastStart = repository.getLastSessionStartTime();
    if (lastStart == null) return null;

    final now = DateTime.now();
    // Fin de session complète : start + 10 minutes
    final sessionEndTime = lastStart.add(const Duration(minutes: 10));
    // Fin du verrouillage : fin session + 2 heures
    final lockEndTime = sessionEndTime.add(const Duration(hours: 2));

    if (now.isBefore(lockEndTime)) {
      // Si on est encore dans les 10 minutes de session, ce n'est pas "verrouillé"
      // mais on considère ici qu'une session commencée déclenche le cycle.
      // Le verrouillage s'applique après le début.
      return lockEndTime.difference(now);
    }

    return null;
  }
}
