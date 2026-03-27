import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/sound_model.dart';

/// Source de données pour le chargement des sons depuis les assets JSON.
abstract class SoundLocalDataSource {
  /// Charge tous les sons depuis le fichier JSON.
  Future<List<SoundModel>> getSounds();
}

class SoundLocalDataSourceImpl implements SoundLocalDataSource {
  final String assetPath;

  SoundLocalDataSourceImpl({this.assetPath = 'assets/data/sounds.json'});

  @override
  Future<List<SoundModel>> getSounds() async {
    // Lecture du fichier JSON depuis les assets Flutter
    final jsonString = await rootBundle.loadString(assetPath);
    final data = json.decode(jsonString);

    return List<SoundModel>.from(
      (data['sounds'] as List).map((x) => SoundModel.fromJson(x)),
    );
  }
}
