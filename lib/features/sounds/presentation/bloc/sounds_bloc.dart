import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/sound.dart';
import '../../domain/usecases/get_sounds_use_case.dart';

// --- Événements ---
abstract class SoundsEvent extends Equatable {
  const SoundsEvent();

  @override
  List<Object> get props => [];
}

/// Événement pour charger la liste des sons
class LoadSounds extends SoundsEvent {}

// --- États ---
abstract class SoundsState extends Equatable {
  const SoundsState();

  @override
  List<Object> get props => [];
}

/// État de chargement initial
class SoundsInitial extends SoundsState {}

/// En cours de chargement
class SoundsLoading extends SoundsState {}

/// Sons chargés avec succès
class SoundsLoaded extends SoundsState {
  final List<Sound> sounds;

  const SoundsLoaded({required this.sounds});

  @override
  List<Object> get props => [sounds];
}

/// Erreur lors du chargement
class SoundsError extends SoundsState {
  final String message;

  const SoundsError({required this.message});

  @override
  List<Object> get props => [message];
}

// --- BLoC ---
/// Gère la liste globale des sons pour l'affichage du menu.
class SoundsBloc extends Bloc<SoundsEvent, SoundsState> {
  final GetSoundsUseCase getSoundsUseCase;

  SoundsBloc({required this.getSoundsUseCase}) : super(SoundsInitial()) {
    on<LoadSounds>((event, emit) async {
      emit(SoundsLoading());
      try {
        final sounds = await getSoundsUseCase();
        emit(SoundsLoaded(sounds: sounds));
      } catch (e) {
        emit(SoundsError(message: e.toString()));
      }
    });
  }
}
