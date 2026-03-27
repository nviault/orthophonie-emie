import '../repositories/session_repository.dart';

/// Cas d'utilisation pour démarrer une session.
/// Enregistre l'heure de début actuelle.
class StartSessionUseCase {
  final SessionRepository repository;

  StartSessionUseCase(this.repository);

  Future<void> call() async {
    final now = DateTime.now();
    await repository.startSession(now);
  }
}
