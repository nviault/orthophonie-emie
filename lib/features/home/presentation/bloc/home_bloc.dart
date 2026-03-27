import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// --- Événements ---
abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

/// Événement déclenché quand l'enfant appuie sur "Commencer"
class StartJourney extends HomeEvent {}

// --- États ---
abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

/// État de base affichant le bouton Commencer
class HomeInitial extends HomeState {}

/// État temporaire indiquant que l'action est en cours
class HomeLoading extends HomeState {}

/// État déclenché pour naviguer vers le menu (redirige vers MenuPage)
class HomeStarted extends HomeState {}

// --- BLoC ---
/// Gère la logique de la page d'accueil simple pour l'instant
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<StartJourney>((event, emit) async {
      emit(HomeLoading());
      // On simule un petit chargement (facultatif mais sympa pour l'UX enfant)
      await Future.delayed(const Duration(milliseconds: 500));
      emit(HomeStarted());
    });
  }
}
