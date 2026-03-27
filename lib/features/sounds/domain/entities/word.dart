import 'package:equatable/equatable.dart';

/// Entité représentant un mot associé à un son.
class Word extends Equatable {
  final String id;
  final String image;
  final String audio;
  final String schema; // Décomposition syllabique (ex: â-ne)

  const Word({
    required this.id,
    required this.image,
    required this.audio,
    required this.schema,
  });

  @override
  List<Object> get props => [id, image, audio, schema];
}
