import 'package:flutter/material.dart';
import 'package:glass_pyramid/constants.dart';
import 'package:glass_pyramid/models/skill.dart';
import 'package:glass_pyramid/services/database_helper.dart';

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

  void saveSkills() async {
    await DatabaseHelper.saveSkillsValues(Skill(
        intel: skillsValues[Stat.intelligence]!.toInt(),
        charisma: skillsValues[Stat.charisma]!.toInt(),
        strength: skillsValues[Stat.strength]!.toInt()));
  }

  void loadSkills() async {
    final Skill loadedSkills = await DatabaseHelper.loadSkillsValues();
    skillsValues[Stat.intelligence] = loadedSkills.intel.toDouble();
    skillsValues[Stat.charisma] = loadedSkills.charisma.toDouble();
    skillsValues[Stat.strength] = loadedSkills.strength.toDouble();
    _skillPoints = 0;
  }

// ---------------------------------- Getters ----------------------------------

  Map<Stat, double> get skills => skillsValues;

  int get skillPoints => _skillPoints;
}
