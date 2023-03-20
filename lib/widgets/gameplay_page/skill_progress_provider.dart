import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:glass_pyramid/constants.dart';
import 'package:glass_pyramid/provider/skill_provider.dart';
import 'package:provider/provider.dart';

class SkillProgressProvider extends StatelessWidget {
  final Stat stat;

  SkillProgressProvider({Key? key, required this.stat}) : super(key: key);

  final List<IconData> icons = [
    Icons.engineering,
    Icons.face_retouching_natural_sharp,
    Icons.fitness_center
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icons[stat.index], color: Colors.green[300], size: 30),
            Text(
              stat.name,
              style: TextStyle(
                fontSize: 30,
                color: Colors.green[300],
              ),
            ),
          ],
        ),
        Consumer<SkillProvider>(
          builder: (context, skillProvider, child) =>
              DashedCircularProgressBar.square(
            dimensions: 70,
            progress: skillProvider.getSkill(stat)!,
            maxProgress: 3,
            foregroundColor: Colors.green.shade400,
            backgroundColor: Colors.white,
            backgroundStrokeWidth: 5,
            foregroundStrokeWidth: 5,
            child: Center(
              child: Text(skillProvider.getSkill(stat)!.toStringAsFixed(0),
                  style: const TextStyle(color: Colors.white, fontSize: 50)),
            ),
          ),
        ),
      ],
    );
  }
}
