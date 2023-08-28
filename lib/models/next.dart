class NextScene {
  final int id;
  final String name;

  NextScene({required this.id, required this.name});

  factory NextScene.fromJson(Map<String, dynamic> json) => NextScene(
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
    };
  }
}
