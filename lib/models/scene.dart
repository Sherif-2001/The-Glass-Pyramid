import 'package:glass_pyramid/models/choice.dart';
import 'package:glass_pyramid/models/next.dart';

class Scene {
  final int id;
  final String? text;
  final List<Choice>? choices;
  final NextScene? nextScene;
  final String? image;

  Scene(
      {required this.id, this.text, this.choices, this.nextScene, this.image});

  factory Scene.fromJson(Map<String, dynamic> json) {
    List<Choice> choices = [];
    if (json['choices'] != null) {
      json['choices'].forEach((json) {
        choices.add(Choice.fromJson(json));
      });
    }
    return Scene(
      id: json['id'],
      text: json['text'],
      choices: choices,
      nextScene: json['next'] != null ? NextScene.fromJson(json['next']) : null,
      image: json["image"],
    );
  }

}
