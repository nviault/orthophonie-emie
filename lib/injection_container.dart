import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'features/home/presentation/bloc/home_bloc.dart';
import 'features/session/data/datasources/session_local_data_source.dart';
import 'features/session/data/repositories/session_repository_impl.dart';
import 'features/session/domain/repositories/session_repository.dart';
import 'features/session/domain/usecases/check_session_lock_use_case.dart';
import 'features/session/domain/usecases/start_session_use_case.dart';
import 'features/session/presentation/bloc/session_bloc.dart';

// Service Locator global pour l'injection de dépendances
final sl = GetIt.instance;

/// Initialise les dépendances du projet
/// Gère les Blocs, UseCases, Repositories et DataSources.
Future<void> init() async {
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

  // --- Features - Home ---
  // On enregistre le HomeBloc en tant que factory
  sl.registerFactory(() => HomeBloc());

  // --- External ---
  // On enregistre la boite Hive déjà ouverte dans main.dart
  final sessionBox = Hive.box('sessionBox');
  sl.registerLazySingleton(() => sessionBox);
}
