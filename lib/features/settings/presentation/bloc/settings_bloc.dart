import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../domain/usecases/pin_use_cases.dart';
import '../../domain/usecases/update_settings_use_case.dart';

// --- Événements ---
abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
  @override
  List<Object> get props => [];
}

/// Événement pour charger les réglages actuels
class LoadSettings extends SettingsEvent {}

/// Événement pour vérifier le code PIN
class VerifyPin extends SettingsEvent {
  final String pin;
  const VerifyPin(this.pin);
  @override
  List<Object> get props => [pin];
}

/// Événement pour mettre à jour la caméra
class ToggleCamera extends SettingsEvent {
  final bool enabled;
  const ToggleCamera(this.enabled);
  @override
  List<Object> get props => [enabled];
}

/// Événement pour mettre à jour le son du jour
class SelectSoundOfDay extends SettingsEvent {
  final String soundId;
  const SelectSoundOfDay(this.soundId);
  @override
  List<Object> get props => [soundId];
}

/// Événement pour mettre à jour le seuil de volume
class ChangeVolumeThreshold extends SettingsEvent {
  final double threshold;
  const ChangeVolumeThreshold(this.threshold);
  @override
  List<Object> get props => [threshold];
}

// --- États ---
abstract class SettingsState extends Equatable {
  const SettingsState();
  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingsAuthenticating extends SettingsState {}

class SettingsAuthenticated extends SettingsState {
  final bool cameraEnabled;
  final String? soundOfDay;
  final double volumeThreshold;

  const SettingsAuthenticated({
    required this.cameraEnabled,
    required this.soundOfDay,
    required this.volumeThreshold,
  });

  @override
  List<Object> get props => [cameraEnabled, soundOfDay ?? '', volumeThreshold];
}

class SettingsAuthFailed extends SettingsState {
  final String message;
  const SettingsAuthFailed(this.message);
}

// --- BLoC ---
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final CheckPinUseCase checkPinUseCase;
  final UpdateSettingsUseCase updateSettingsUseCase;
  final SettingsRepository repository;

  SettingsBloc({
    required this.checkPinUseCase,
    required this.updateSettingsUseCase,
    required this.repository,
  }) : super(SettingsInitial()) {

    on<VerifyPin>((event, emit) async {
      emit(SettingsAuthenticating());
      final isValid = await checkPinUseCase(event.pin);
      if (isValid) {
        add(LoadSettings());
      } else {
        emit(const SettingsAuthFailed('Code PIN incorrect'));
      }
    });

    on<LoadSettings>((event, emit) {
      emit(SettingsAuthenticated(
        cameraEnabled: repository.isCameraEnabled(),
        soundOfDay: repository.getSoundOfDay(),
        volumeThreshold: repository.getVolumeThreshold(),
      ));
    });

    on<ToggleCamera>((event, emit) async {
      await updateSettingsUseCase.updateCamera(event.enabled);
      add(LoadSettings());
    });

    on<SelectSoundOfDay>((event, emit) async {
      await updateSettingsUseCase.updateSoundOfDay(event.soundId);
      add(LoadSettings());
    });

    on<ChangeVolumeThreshold>((event, emit) async {
      await updateSettingsUseCase.updateVolumeThreshold(event.threshold);
      add(LoadSettings());
    });
  }
}
