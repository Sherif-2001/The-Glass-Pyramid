class Skill {
  int intel;
  int charisma;
  int strength;

  Skill({required this.intel, required this.charisma, required this.strength});

  factory Skill.fromJson(Map<String, dynamic> json) => Skill(
      intel: json["intel"],
      charisma: json["charisma"],
      strength: json["strength"]);

  Map<String, dynamic> toJson() {
    return {
      "intel": intel,
      "charisma": charisma,
      "strength": strength,
    };
  }
}
