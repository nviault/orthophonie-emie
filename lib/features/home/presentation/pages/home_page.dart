import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../injection_container.dart';
import '../../../session/presentation/bloc/session_bloc.dart';
import '../bloc/home_bloc.dart';

/// Page d'accueil du projet DysVoix.
/// Présente un bouton central "Commencer" avec un style "Animal Crossing".
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // On fournit les deux Blocs (Home et Session) à l'accueil
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<HomeBloc>()),
        // Charge l'état de la session dès la création
        BlocProvider(create: (context) => sl<SessionBloc>()..add(LoadSessionStatus())),
      ],
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('DysVoix'),
      ),
      body: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeStarted) {
            // Navigation vers le menu uniquement si l'état home est started
            Navigator.pushReplacementNamed(context, '/menu');
          }
        },
        child: Container(
          width: double.infinity,
          color: theme.colorScheme.background,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.emoji_nature,
                size: 100,
                color: AppTheme.leafGreen,
              ),
              const SizedBox(height: 20),

              Text(
                'Bienvenue dans DysVoix !',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: AppTheme.woodBrown,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              Text(
                'Prêt pour une nouvelle aventure ?',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 50),

              // Affichage du bouton "Commencer" basé sur l'état de la session
              BlocBuilder<SessionBloc, SessionState>(
                builder: (context, sessionState) {
                  if (sessionState is SessionLocked) {
                    final duration = sessionState.remainingTime;
                    final hours = duration.inHours;
                    final minutes = duration.inMinutes % 60;

                    // Formatage du texte pour l'enfant
                    final timeText = hours > 0
                        ? 'Reviens dans ${hours}h ${minutes}min'
                        : 'Reviens dans ${minutes}min';

                    return ElevatedButton(
                      onPressed: null, // Désactivé si verrouillé
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey, // Couleur grise pour le verrou
                        side: const BorderSide(color: Colors.grey),
                      ),
                      child: Text(timeText),
                    );
                  }

                  // Si session disponible ou active
                  return BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, homeState) {
                      if (homeState is HomeLoading) {
                        return const CircularProgressIndicator();
                      }

                      return ElevatedButton(
                        onPressed: () {
                          // 1. Démarre la session métier
                          context.read<SessionBloc>().add(StartSession());
                          // 2. Démarre l'action d'interface
                          context.read<HomeBloc>().add(StartJourney());
                        },
                        child: const Text('Commencer'),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
