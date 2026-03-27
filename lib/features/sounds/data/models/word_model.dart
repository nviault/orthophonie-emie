import '../../domain/entities/word.dart';

/// Modèle de données pour Word, avec conversion JSON.
class WordModel extends Word {
  const WordModel({
    required super.id,
    required super.image,
    required super.audio,
    required super.schema,
  });

  factory WordModel.fromJson(Map<String, dynamic> json) {
    return WordModel(
      id: json['id'],
      image: json['image'],
      audio: json['audio'],
      schema: json['schema'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'audio': audio,
      'schema': schema,
    };
  }
}
