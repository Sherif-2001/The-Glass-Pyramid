import 'package:flutter/services.dart';
import 'package:glass_pyramid/models/next.dart';
import 'package:glass_pyramid/models/scene.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:glass_pyramid/models/scenes_collection.dart';
import 'package:glass_pyramid/services/database_helper.dart';

class SceneProvider extends ChangeNotifier {
  late ScenesCollection _scenesCollection;
  late Scene _currentScene;

  void startGame() {
    _currentScene = _scenesCollection.scenes["intro"]![0];
    notifyListeners();
  }

  void loadGame(NextScene scene) async {
    await getScenes();
    _currentScene = _scenesCollection.scenes[scene.name]![scene.id - 1];
    notifyListeners();
  }

  void saveGame() async {
    await DatabaseHelper.saveCurrentScene(_currentScene.nextScene!);
  }

  void onTextClicked() async {
    _currentScene = _scenesCollection.scenes[_currentScene.nextScene!.name]![
        _currentScene.nextScene!.id - 1];
    notifyListeners();
  }

  void onChoiceClicked(int choiceNum) {
    _currentScene = _scenesCollection.scenes[_currentScene.choices![choiceNum]
        .next.name]![_currentScene.choices![choiceNum].next.id - 1];
    notifyListeners();
  }

  Future getScenes() async {
    String scenesString = await rootBundle.loadString('assets/scenes.json');
    final scenesJson = json.decode(scenesString);
    _scenesCollection = ScenesCollection.fromJson(scenesJson);
    notifyListeners();
  }

// ---------------------------------- Getters ----------------------------------

  bool get isTextVisible {
    return _currentScene.choices!.isEmpty;
  }

  String get sceneText {
    return _currentScene.text ?? "";
  }

  String get sceneImage {
    return _currentScene.image ?? "assets/images/game_image.png";
  }

  int get choiceslength {
    return !isTextVisible ? _currentScene.choices!.length : 0;
  }

  List<String> get choicesText {
    return !isTextVisible
        ? _currentScene.choices!.map((e) => e.text).toList()
        : [];
  }
}
