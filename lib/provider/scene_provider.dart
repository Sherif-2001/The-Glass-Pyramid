import 'package:glass_pyramid/models/choice.dart';
import 'package:glass_pyramid/models/scene.dart';
import 'package:flutter/material.dart';

class SceneProvider extends ChangeNotifier {
  int _currentScene = 0;

  final List _scenesList = [
    // ---------------------- Intro ---------------------------
    Scene(
      sceneText:
          "In the end it turned out it's easier to destroy the planet than to destroy capitalism....In 2088 , all billionaires fucked off to space , leaving all of us normal folks to fend for ourselves against the Earth's vengeance , most of which they caused mind you , we were slowly dying civilization on a slowly dying planet.",
      nextScene: 1,
    ),
    Scene(
      sceneText:
          "You'd think that would make us unite , forget our differences but no , some people still wanted to feel superior to others , somehow forgetting that they've all been used by the same people nonetheless. There's a lot of factions now fighting over what little land is still habitable. Soon enough there'll be nothing left to fight for.",
      nextScene: 2,
    ),
    Scene(
      sceneText:
          "You're a scavenger looking through old tech-waste that was buried near your home , you find this shiny disk , it looks important , like it's designed to resist being destroyed , it also glows in the dark which is super cool.",
      nextScene: 3,
    ),
    Choice(
      choicesText: [
        "Take it to Elder Blake",
        "Take it to Elder Martin",
        "Take it to Scientist Carlos"
      ],
      nextScenes: [4, 7, 10],
    ),
    // ---------------------- Elder Blake ---------------------------
    Scene(
      sceneText:
          "Elder Blake:\nHello there, elder Blake at your service. What can I help you with?",
      nextScene: 5,
    ),
    Choice(
      choicesText: ["What can you tell me about this disk?"],
      nextScenes: [6],
    ),
    Scene(
      sceneText:
          "Elder Blake:\nWell to be honest, I'm not really a science guy, I'm more into old arts, more specifically the old art of movies, a screen where people do all sorts of silly acts, you'd better go talk to Carlos, he would know more about this than me.",
      nextScene: 3,
    ),
    // ---------------------- Elder Martin ---------------------------
    Scene(
      sceneText:
          "Elder Martin:\nHello there , What can elder Martin do in this fine day?",
      nextScene: 8,
    ),
    Choice(
      choicesText: ["What can you tell me about this disk?"],
      nextScenes: [9],
    ),
    Scene(
      sceneText:
          "Elder Martin:\nThis looks like one of those old devices that were used to store media a long time ago, that's basically all I know about it. You should talk to Carlos, he would know what to do even if he doesn't seem confident in his abilities.",
      nextScene: 3,
    ),
    // ---------------------- Scientist Carlos ---------------------------
    Scene(
      sceneText:
          "Carlos:\nHello there, What did you find in that pile of garbage? batteries? capacitors? I could always use a good capacitor.",
      nextScene: 3,
    )
  ];

  void startGame() {
    _currentScene = 0;
    notifyListeners();
  }

  void onTextClicked() {
    if (isTextVisible) {
      _currentScene = _scenesList[_currentScene].nextScene;
      notifyListeners();
    }
  }

  void onChoiceClicked(int choiceNum) {
    if (!isTextVisible) {
      _currentScene = _scenesList[_currentScene].nextScenes[choiceNum];
      notifyListeners();
    }
  }

// ---------------------------------- Getters ----------------------------------
  bool get isTextVisible {
    return _scenesList[_currentScene] is Scene;
  }

  String get sceneText {
    if (isTextVisible) {
      return _scenesList[_currentScene].sceneText;
    }
    return "";
  }

  int get choiceslength {
    if (!isTextVisible) {
      return _scenesList[_currentScene].choicesText.length;
    }
    return 0;
  }

  List<String> get choicesText {
    if (!isTextVisible) {
      return _scenesList[_currentScene].choicesText;
    }
    return [""];
  }
}
