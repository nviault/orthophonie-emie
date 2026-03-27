import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../injection_container.dart';
import '../bloc/home_bloc.dart';

/// Page d'accueil du projet DysVoix.
/// Présente un bouton central "Commencer" avec un style "Animal Crossing".
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeBloc>(),
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
            Navigator.pushReplacementNamed(context, '/menu');
          }
        },
        child: Container(
          width: double.infinity,
          color: theme.colorScheme.background,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Utilisation de la couleur du thème pour l'icône
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

              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return const CircularProgressIndicator();
                  }

                  return ElevatedButton(
                    onPressed: () {
                      context.read<HomeBloc>().add(StartJourney());
                    },
                    child: const Text('Commencer'),
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
