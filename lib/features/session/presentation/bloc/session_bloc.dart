import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/check_session_lock_use_case.dart';
import '../../domain/usecases/start_session_use_case.dart';

// --- Événements ---
abstract class SessionEvent extends Equatable {
  const SessionEvent();

  @override
  List<Object> get props => [];
}

/// Événement pour charger l'état de la session (si verrouillé ou non)
class LoadSessionStatus extends SessionEvent {}

/// Événement pour démarrer une nouvelle session
class StartSession extends SessionEvent {}

// --- États ---
abstract class SessionState extends Equatable {
  const SessionState();

  @override
  List<Object> get props => [];
}

/// État initial pendant le chargement
class SessionInitial extends SessionState {}

/// La session est libre pour l'enfant (pas de verrouillage)
class SessionAvailable extends SessionState {}

/// La session est active pour les 10 prochaines minutes (non verrouillé encore)
class SessionActive extends SessionState {}

/// La session est verrouillée (l'enfant doit attendre)
class SessionLocked extends SessionState {
  final Duration remainingTime;

  const SessionLocked({required this.remainingTime});

  @override
  List<Object> get props => [remainingTime];
}

// --- BLoC ---
/// Gère la logique de session : démarrage, verrouillage et temps restant.
class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final StartSessionUseCase startSessionUseCase;
  final CheckSessionLockUseCase checkSessionLockUseCase;

  SessionBloc({
    required this.startSessionUseCase,
    required this.checkSessionLockUseCase,
  }) : super(SessionInitial()) {
    on<LoadSessionStatus>((event, emit) {
      final lockTime = checkSessionLockUseCase();
      if (lockTime != null && lockTime.isNegative == false) {
        emit(SessionLocked(remainingTime: lockTime));
      } else {
        emit(SessionAvailable());
      }
    });

    on<StartSession>((event, emit) async {
      await startSessionUseCase();
      // On recharge l'état pour vérifier immédiatement
      add(LoadSessionStatus());
    });
  }
}
