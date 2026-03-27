import '../../domain/entities/sound.dart';
import 'word_model.dart';

/// Modèle de données pour Sound, avec conversion JSON.
class SoundModel extends Sound {
  const SoundModel({
    required super.id,
    required super.words,
  });

  factory SoundModel.fromJson(Map<String, dynamic> json) {
    return SoundModel(
      id: json['id'],
      words: List<WordModel>.from(
        (json['words'] as List).map((x) => WordModel.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'words': (words as List<WordModel>).map((x) => x.toJson()).toList(),
    };
  }
}
