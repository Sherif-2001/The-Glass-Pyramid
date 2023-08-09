import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:glass_pyramid/constants.dart';
import 'package:glass_pyramid/provider/skill_provider.dart';
import 'package:provider/provider.dart';

class StatsSkillWidget extends StatelessWidget {
  final Stat stat;

  StatsSkillWidget({Key? key, required this.stat}) : super(key: key);

  final List<IconData> icons = [
    Icons.engineering,
    Icons.face_retouching_natural_sharp,
    Icons.fitness_center
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<SkillProvider>(
      builder: (context, skillProvider, child) => ListTile(
        leading: Icon(icons[stat.index], color: Colors.green[300], size: 40),
        title: Text(
          stat.name,
          style: TextStyle(
            fontSize: 30,
            color: Colors.green[300],
          ),
        ),
        trailing: DashedCircularProgressBar.square(
          dimensions: 60,
          progress: skillProvider.skillsValues[stat]!,
          maxProgress: 3,
          foregroundColor: Colors.green.shade400,
          backgroundColor: Colors.white,
          backgroundStrokeWidth: 5,
          foregroundStrokeWidth: 5,
          child: Center(
            child: Text(skillProvider.skillsValues[stat]!.toStringAsFixed(0),
                style: const TextStyle(color: Colors.white, fontSize: 35)),
          ),
        ),
        subtitle: Row(
          children: [
            IconButton(
              onPressed: () => skillProvider.decrementSkillValue(stat),
              icon: const Icon(
                Icons.remove_circle,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () => skillProvider.incrementSkillValue(stat),
              icon: const Icon(
                Icons.add_circle,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
