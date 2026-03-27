import '../entities/word.dart';
import '../repositories/sound_repository.dart';

/// Cas d'utilisation pour récupérer les mots associés à un son.
class GetWordsForSoundUseCase {
  final SoundRepository repository;

  GetWordsForSoundUseCase(this.repository);

  Future<List<Word>> call(String soundId) async {
    return await repository.getWordsForSound(soundId);
  }
}
