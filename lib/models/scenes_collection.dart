import 'package:glass_pyramid/models/scene.dart';

class ScenesCollection {
  final Map<String, List<Scene>> scenes;

  ScenesCollection({required this.scenes});

  factory ScenesCollection.fromJson(Map<String, dynamic> json) {
    final Map<String, List<Scene>> scenes = {};
    json['scenes'].forEach((name, sceneList) {
      scenes[name] = List<Scene>.from(
          sceneList.map((scene) => Scene.fromJson(scene)).toList());
    });
    return ScenesCollection(scenes: scenes);
  }
}
