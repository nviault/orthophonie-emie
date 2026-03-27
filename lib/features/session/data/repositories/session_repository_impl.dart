import '../../domain/repositories/session_repository.dart';
import '../datasources/session_local_data_source.dart';

/// Implémentation du dépôt de session.
/// Gère la persistance de l'état de la session.
class SessionRepositoryImpl implements SessionRepository {
  final SessionLocalDataSource localDataSource;

  SessionRepositoryImpl({required this.localDataSource});

  @override
  Future<void> startSession(DateTime startTime) async {
    await localDataSource.saveLastSessionStartTime(startTime);
  }

  @override
  DateTime? getLastSessionStartTime() {
    return localDataSource.getLastSessionStartTime();
  }
}
