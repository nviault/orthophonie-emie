import 'package:flutter_test/flutter_test.dart';
import 'package:orthophonie_emie/core/utils/session_timer.dart';

void main() {
  group('SessionTimer Tests', () {
    test('Une session ne peut pas dépasser 600 secondes (10 minutes)', () {
      final timer = SessionTimer();

      // Tentative de réglage à 601 secondes
      timer.setSeconds(601);

      expect(timer.currentSeconds, lessThanOrEqualTo(600));
      expect(timer.currentSeconds, 600);
    });

    test('Une session peut être réglée à une valeur inférieure à 600 secondes', () {
      final timer = SessionTimer();

      timer.setSeconds(300);

      expect(timer.currentSeconds, 300);
    });
  });
}
