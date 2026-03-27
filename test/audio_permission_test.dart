import 'package:flutter_test/flutter_test.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:orthophonie_emie/core/audio/audio_permission_service.dart';

void main() {
  group('AudioPermissionService Tests', () {
    test('La demande de permission audio retourne un état gérable (granted ou denied)', () async {
      final service = AudioPermissionService();

      final status = await service.requestAudioPermission();

      // Vérifie que le statut est bien l'un des types gérables sans planter
      expect(status, isA<PermissionStatus>());
      expect([PermissionStatus.granted, PermissionStatus.denied].contains(status), isTrue);
    });
  });
}
