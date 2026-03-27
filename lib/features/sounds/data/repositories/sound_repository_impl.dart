import '../../domain/entities/sound.dart';
import '../../domain/entities/word.dart';
import '../../domain/repositories/sound_repository.dart';
import '../datasources/sound_local_data_source.dart';

/// Implémentation du dépôt pour les sons et les mots.
class SoundRepositoryImpl implements SoundRepository {
  final SoundLocalDataSource localDataSource;

  SoundRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Sound>> getSounds() async {
    return await localDataSource.getSounds();
  }

  @override
  Future<List<Word>> getWordsForSound(String soundId) async {
    final sounds = await localDataSource.getSounds();
    final sound = sounds.firstWhere(
      (s) => s.id == soundId,
      orElse: () => throw Exception('Son non trouvé'),
    );
    return sound.words;
  }
}
