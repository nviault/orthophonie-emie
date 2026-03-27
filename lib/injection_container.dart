import 'package:get_it/get_it.dart';
import 'features/home/presentation/bloc/home_bloc.dart';

// Service Locator global pour l'injection de dépendances
final sl = GetIt.instance;

/// Initialise les dépendances du projet
/// Gère les Blocs, UseCases, Repositories et DataSources.
Future<void> init() async {
  // Features - Home
  // On enregistre le HomeBloc en tant que factory pour qu'une nouvelle instance
  // soit créée à chaque fois qu'on le demande (recommandé pour les Blocs).
  sl.registerFactory(() => HomeBloc());

  // Use cases (à ajouter plus tard si besoin)

  // Repositories (à ajouter plus tard si besoin)

  // Data sources (à ajouter plus tard si besoin)

  // Core (à ajouter plus tard si besoin)

  // External (ex: SharedPreferences, http client)
}
