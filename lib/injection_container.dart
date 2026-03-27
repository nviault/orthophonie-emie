import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'core/audio/audio_manager.dart';
import 'features/audio/domain/usecases/record_production_use_case.dart';
import 'features/home/presentation/bloc/home_bloc.dart';
import 'features/session/data/datasources/session_local_data_source.dart';
import 'features/session/data/repositories/session_repository_impl.dart';
import 'features/session/domain/repositories/session_repository.dart';
import 'features/session/domain/usecases/check_session_lock_use_case.dart';
import 'features/session/domain/usecases/start_session_use_case.dart';
import 'features/session/presentation/bloc/session_bloc.dart';
import 'features/sounds/data/datasources/sound_local_data_source.dart';
import 'features/sounds/data/repositories/sound_repository_impl.dart';
import 'features/sounds/domain/repositories/sound_repository.dart';
import 'features/sounds/domain/usecases/get_sounds_use_case.dart';
import 'features/sounds/domain/usecases/get_words_for_sound_use_case.dart';
import 'features/sounds/presentation/bloc/sounds_bloc.dart';
import 'features/sounds/presentation/bloc/sound_detail_bloc.dart';

// Service Locator global pour l'injection de dépendances
final sl = GetIt.instance;

/// Initialise les dépendances du projet
/// Gère les Blocs, UseCases, Repositories et DataSources.
Future<void> init() async {
  // --- Core ---
  sl.registerLazySingleton(() => AudioManager());

  // --- Features - Audio ---
  sl.registerLazySingleton(() => RecordProductionUseCase(sl()));

  // --- Features - Session ---
  // BLoC
  sl.registerFactory(() => SessionBloc(
    startSessionUseCase: sl(),
    checkSessionLockUseCase: sl(),
  ));

  // Use cases
  sl.registerLazySingleton(() => StartSessionUseCase(sl()));
  sl.registerLazySingleton(() => CheckSessionLockUseCase(sl()));

  // Repositories
  sl.registerLazySingleton<SessionRepository>(
    () => SessionRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<SessionLocalDataSource>(
    () => SessionLocalDataSourceImpl(box: sl()),
  );

  // --- Features - Sounds ---
  // BLoCs
  sl.registerFactory(() => SoundsBloc(getSoundsUseCase: sl()));
  sl.registerFactory(() => SoundDetailBloc(getWordsForSoundUseCase: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetSoundsUseCase(sl()));
  sl.registerLazySingleton(() => GetWordsForSoundUseCase(sl()));

  // Repositories
  sl.registerLazySingleton<SoundRepository>(
    () => SoundRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<SoundLocalDataSource>(
    () => SoundLocalDataSourceImpl(),
  );

  // --- Features - Home ---
  // On enregistre le HomeBloc en tant que factory
  sl.registerFactory(() => HomeBloc());

  // --- External ---
  // On enregistre la boite Hive déjà ouverte dans main.dart
  if (Hive.isBoxOpen('sessionBox')) {
    sl.registerLazySingleton(() => Hive.box('sessionBox'));
  }
}
