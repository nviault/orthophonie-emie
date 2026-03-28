import 'dart:async';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

/// Gestionnaire audio centralisé.
/// Gère l'enregistrement avec record et la lecture avec just_audio.
class AudioManager {
  final AudioRecorder _recorder = AudioRecorder();
  final AudioPlayer _player = AudioPlayer();

  StreamSubscription<RecordState>? _recordSub;
  StreamSubscription<Amplitude>? _amplitudeSub;

  Timer? _maxDurationTimer;
  Timer? _silenceTimer;

  bool _isRecording = false;

  /// Expose le flux d'amplitude en temps réel de l'enregistrement.
  /// L'intervalle par défaut est 80ms pour une réactivité fluide.
  Stream<Amplitude> onAmplitudeChanged([Duration interval = const Duration(milliseconds: 80)]) {
    return _recorder.onAmplitudeChanged(interval);
  }

  /// Démarre l'enregistrement audio.
  /// S'arrête automatiquement après 4s ou 1s de silence.
  Future<void> startRecording({required Function(String path) onComplete}) async {
    if (await _recorder.hasPermission()) {
      final directory = await getTemporaryDirectory();
      final path = '${directory.path}/my_record.m4a';

      // Configuration de l'enregistrement
      const config = RecordConfig();

      await _recorder.start(config, path: path);
      _isRecording = true;

      // Limite maximum de 4 secondes
      _maxDurationTimer = Timer(const Duration(seconds: 4), () {
        stopRecording();
      });

      // Détection de silence (Seuil -40 dB, silence de 1 seconde)
      _amplitudeSub = _recorder.onAmplitudeChanged(const Duration(milliseconds: 100)).listen((amp) {
        if (amp.current < -40) {
          _silenceTimer ??= Timer(const Duration(seconds: 1), () {
            stopRecording();
          });
        } else {
          _silenceTimer?.cancel();
          _silenceTimer = null;
        }
      });

      _recordSub = _recorder.onStateChanged().listen((state) async {
        if (state == RecordState.stop && _isRecording) {
          _isRecording = false;
          _cleanup();
          onComplete(path);
        }
      });
    }
  }

  /// Arrête l'enregistrement manuellement ou via les timers.
  Future<void> stopRecording() async {
    if (await _recorder.isRecording()) {
      await _recorder.stop();
    }
  }

  /// Lit un fichier audio à partir d'un chemin local ou d'un asset.
  Future<void> play(String path, {bool isAsset = false}) async {
    try {
      if (isAsset) {
        await _player.setAsset(path);
      } else {
        await _player.setFilePath(path);
      }
      await _player.play();
    } catch (e) {
      // Gérer l'erreur de lecture
    }
  }

  void _cleanup() {
    _maxDurationTimer?.cancel();
    _silenceTimer?.cancel();
    _amplitudeSub?.cancel();
    _recordSub?.cancel();
    _silenceTimer = null;
  }

  /// Libère les ressources
  void dispose() {
    _cleanup();
    _recorder.dispose();
    _player.dispose();
  }
}
