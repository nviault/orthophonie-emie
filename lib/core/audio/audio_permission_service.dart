import 'package:permission_handler/permission_handler.dart';

/// Stub pour la gestion des permissions audio
class AudioPermissionService {
  // TODO: implémenter la demande de permission réelle avec permission_handler
  Future<PermissionStatus> requestAudioPermission() async {
    // Simulation pour les tests ou stub initial
    return PermissionStatus.granted;
  }
}
