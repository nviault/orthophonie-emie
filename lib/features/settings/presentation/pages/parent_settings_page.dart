import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../injection_container.dart';
import '../bloc/settings_bloc.dart';

/// Page de réglages pour les parents.
/// Permet de configurer le son du jour, la caméra et les seuils.
class ParentSettingsPage extends StatelessWidget {
  const ParentSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SettingsBloc>()..add(LoadSettings()),
      child: const ParentSettingsView(),
    );
  }
}

class ParentSettingsView extends StatelessWidget {
  const ParentSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Réglages Parent'),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is SettingsAuthenticated) {
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildSectionHeader(theme, 'Entraînement'),

                ListTile(
                  title: const Text('Son du jour'),
                  subtitle: Text(state.soundOfDay?.toUpperCase() ?? 'Aucun'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // TODO: Boite de dialogue pour choisir parmi les sons JSON
                  },
                ),

                const Divider(),

                _buildSectionHeader(theme, 'Capteurs'),

                SwitchListTile(
                  title: const Text('Activer la caméra'),
                  subtitle: const Text('Permet à l\'enfant de voir sa bouche'),
                  value: state.cameraEnabled,
                  activeThumbColor: AppTheme.leafGreen,
                  onChanged: (value) {
                    context.read<SettingsBloc>().add(ToggleCamera(value));
                  },
                ),

                const Divider(),

                _buildSectionHeader(theme, 'Microphone'),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Seuil de volume (dB)'),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text('-60'),
                          Expanded(
                            child: Slider(
                              value: state.volumeThreshold,
                              min: -60.0,
                              max: -10.0,
                              activeColor: AppTheme.buttonOrange,
                              onChanged: (value) {
                                context.read<SettingsBloc>().add(ChangeVolumeThreshold(value));
                              },
                            ),
                          ),
                          const Text('-10'),
                        ],
                      ),
                      Text('Seuil actuel: ${state.volumeThreshold.toStringAsFixed(1)} dB'),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                ElevatedButton(
                  onPressed: () {
                    // Déconnexion / Retour accueil
                    Navigator.pushReplacementNamed(context, '/');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.woodBrown,
                  ),
                  child: const Text('Fermer et retourner à l\'accueil'),
                ),
              ],
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildSectionHeader(ThemeData theme, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Text(
        title.toUpperCase(),
        style: theme.textTheme.labelLarge?.copyWith(
          color: AppTheme.leafGreen,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
