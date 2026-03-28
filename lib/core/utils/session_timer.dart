/// Stub pour la gestion du minuteur de session
class SessionTimer {
  static const int maxSessionSeconds = 600;

  // TODO: implémenter la logique de démarrage, d'arrêt et de rappel
  int _currentSeconds = 0;

  int get currentSeconds => _currentSeconds;

  void setSeconds(int seconds) {
    if (seconds > maxSessionSeconds) {
      _currentSeconds = maxSessionSeconds;
    } else {
      _currentSeconds = seconds;
    }
  }
}
