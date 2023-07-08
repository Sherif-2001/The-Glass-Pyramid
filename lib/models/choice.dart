import 'package:glass_pyramid/models/next.dart';

class Choice {
  final int id;
  final String text;
  final NextScene next;

  Choice({required this.id, required this.text, required this.next});

  factory Choice.fromJson(Map<String, dynamic> json) => Choice(
      id: json["id"],
      text: json['text'],
      next: NextScene.fromJson(json['next']));
}
