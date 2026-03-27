import 'package:hive_flutter/hive_flutter.dart';

/// Source de données locale pour la gestion de la session via Hive.
abstract class SessionLocalDataSource {
  /// Enregistre la date et l'heure du dernier début de session.
  Future<void> saveLastSessionStartTime(DateTime startTime);

  /// Récupère la date et l'heure du dernier début de session.
  DateTime? getLastSessionStartTime();
}

class SessionLocalDataSourceImpl implements SessionLocalDataSource {
  final Box box;

  SessionLocalDataSourceImpl({required this.box});

  @override
  Future<void> saveLastSessionStartTime(DateTime startTime) async {
    await box.put('lastSessionStartTime', startTime.toIso8601String());
  }

  @override
  DateTime? getLastSessionStartTime() {
    final dateStr = box.get('lastSessionStartTime');
    if (dateStr != null) {
      return DateTime.parse(dateStr);
    }
    return null;
  }
}
