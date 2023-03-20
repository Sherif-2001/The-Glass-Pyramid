import 'package:flutter/material.dart';
import 'package:glass_pyramid/provider/audio_provider.dart';
import 'package:glass_pyramid/provider/scene_provider.dart';
import 'package:glass_pyramid/screens/home_page.dart';
import 'package:glass_pyramid/widgets/gameplay_page/skill_progress_provider.dart';
import 'package:provider/provider.dart';
import 'package:glass_pyramid/constants.dart';

class GameplayDrawer extends StatelessWidget {
  const GameplayDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text(
          "Your Stats",
          style: TextStyle(color: Colors.green, fontSize: 40),
        ),
        ListView.separated(
          shrinkWrap: true,
          itemCount: Stat.values.length,
          separatorBuilder: (context, index) => const SizedBox(height: 20),
          itemBuilder: (context, index) =>
              SkillProgressProvider(stat: Stat.values[index]),
        ),
        Consumer<AudioProvider>(
          builder: (context, audioProvider, child) => IconButton(
            onPressed: audioProvider.checkSFXSettings,
            icon: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white),
              ),
              child: Icon(
                audioProvider.sfxSettingsIcon,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ),
        Consumer2<SceneProvider, AudioProvider>(
          builder: (context, sceneProvider, audioProivder, child) =>
              ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            label: Text(
              "Main Menu".toUpperCase(),
              style: const TextStyle(fontSize: 30),
            ),
            icon: const Icon(Icons.door_back_door),
            onPressed: () => {
              Navigator.of(context).pushReplacementNamed(HomePage.id),
              audioProivder.stopTypingAudio(),
            },
          ),
        )
      ],
    );
  }
}
