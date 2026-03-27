import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../injection_container.dart';
import '../bloc/settings_bloc.dart';
import 'parent_settings_page.dart';

/// Page d'entrée sécurisée pour les parents.
/// Demande un code PIN de 4 chiffres.
class PinEntryPage extends StatefulWidget {
  const PinEntryPage({super.key});

  @override
  State<PinEntryPage> createState() => _PinEntryPageState();
}

class _PinEntryPageState extends State<PinEntryPage> {
  final TextEditingController _pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SettingsBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Espace Parent'),
        ),
        body: BlocConsumer<SettingsBloc, SettingsState>(
          listener: (context, state) {
            if (state is SettingsAuthenticated) {
              // Navigation vers les réglages si authentifié
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ParentSettingsPage()),
              );
            }
            if (state is SettingsAuthFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
              _pinController.clear();
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Saisissez votre code PIN',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.woodBrown,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _pinController,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    maxLength: 4,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 30, letterSpacing: 20),
                    decoration: const InputDecoration(
                      hintText: '****',
                      counterText: '',
                    ),
                    onChanged: (value) {
                      if (value.length == 4) {
                        context.read<SettingsBloc>().add(VerifyPin(value));
                      }
                    },
                  ),
                  if (state is SettingsAuthenticating)
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
