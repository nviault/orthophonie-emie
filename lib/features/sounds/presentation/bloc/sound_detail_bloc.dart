import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/word.dart';
import '../../domain/usecases/get_words_for_sound_use_case.dart';

// --- Événements ---
abstract class SoundDetailEvent extends Equatable {
  const SoundDetailEvent();

  @override
  List<Object> get props => [];
}

/// Événement pour charger les mots d'un son spécifique
class LoadWordsForSound extends SoundDetailEvent {
  final String soundId;

  const LoadWordsForSound({required this.soundId});

  @override
  List<Object> get props => [soundId];
}

// --- États ---
abstract class SoundDetailState extends Equatable {
  const SoundDetailState();

  @override
  List<Object> get props => [];
}

class SoundDetailInitial extends SoundDetailState {}

class SoundDetailLoading extends SoundDetailState {}

class SoundDetailLoaded extends SoundDetailState {
  final List<Word> words;

  const SoundDetailLoaded({required this.words});

  @override
  List<Object> get props => [words];
}

class SoundDetailError extends SoundDetailState {
  final String message;

  const SoundDetailError({required this.message});

  @override
  List<Object> get props => [message];
}

// --- BLoC ---
/// Gère les détails d'un son particulier (sa liste de mots).
class SoundDetailBloc extends Bloc<SoundDetailEvent, SoundDetailState> {
  final GetWordsForSoundUseCase getWordsForSoundUseCase;

  SoundDetailBloc({required this.getWordsForSoundUseCase}) : super(SoundDetailInitial()) {
    on<LoadWordsForSound>((event, emit) async {
      emit(SoundDetailLoading());
      try {
        final words = await getWordsForSoundUseCase(event.soundId);
        emit(SoundDetailLoaded(words: words));
      } catch (e) {
        emit(SoundDetailError(message: e.toString()));
      }
    });
  }
}
