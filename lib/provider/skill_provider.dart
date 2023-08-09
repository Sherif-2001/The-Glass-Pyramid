import 'package:flutter/material.dart';
import 'package:glass_pyramid/constants.dart';

class SkillProvider extends ChangeNotifier {
  int _skillPoints = 3;
  Map<Stat, double> skillsValues = {
    Stat.intelligence: 0,
    Stat.strength: 0,
    Stat.charisma: 0,
  };

  void incrementSkillValue(Stat stat) {
    if (_skillPoints > 0) {
      _skillPoints--;
      skillsValues.update(stat, (value) => ++value);
      notifyListeners();
    }
  }

  void decrementSkillValue(Stat stat) {
    if (skillsValues[stat]! > 0) {
      _skillPoints++;
      skillsValues.update(stat, (value) => --value);
      notifyListeners();
    }
  }

  void resetSkills() {
    skillsValues.updateAll((key, value) => 0);
    _skillPoints = 3;
    notifyListeners();
  }

  Map<Stat, double> get skills => skillsValues;

  int get skillPoints => _skillPoints;
}
