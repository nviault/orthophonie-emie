import '../entities/sound.dart';
import '../repositories/sound_repository.dart';

/// Cas d'utilisation pour lister tous les sons.
class GetSoundsUseCase {
  final SoundRepository repository;

  GetSoundsUseCase(this.repository);

  Future<List<Sound>> call() async {
    return await repository.getSounds();
  }
}
