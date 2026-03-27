import 'package:equatable/equatable.dart';
import 'word.dart';

/// Entité représentant un son (ex: "a") et sa liste de mots associés.
class Sound extends Equatable {
  final String id;
  final List<Word> words;

  const Sound({
    required this.id,
    required this.words,
  });

  @override
  List<Object> get props => [id, words];
}
