import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glass_pyramid/provider/audio_provider.dart';
import 'package:glass_pyramid/provider/scene_provider.dart';
import 'package:glass_pyramid/provider/skill_provider.dart';
import 'package:glass_pyramid/screens/about_page.dart';
import 'package:glass_pyramid/screens/stats_page.dart';
import 'package:glass_pyramid/widgets/main_button.dart';
import 'package:provider/provider.dart';

class HomePageButtons extends StatelessWidget {
  const HomePageButtons({Key? key, required this.onSettingsClick})
      : super(key: key);

  final VoidCallback onSettingsClick;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Consumer2<SkillProvider, SceneProvider>(
          builder: (context, skillProvider, sceneProvider, child) => MainButton(
            "START NEW ADVENTURE",
            () {
              Navigator.of(context).pushReplacementNamed(StatsPage.id);
              skillProvider.resetSkills();
              sceneProvider.getScenes();
            },
          ),
        ),
        const SizedBox(height: 20),
        MainButton(
          "Settings".toUpperCase(),
          onSettingsClick,
        ),
        const SizedBox(height: 20),
        Consumer<AudioProvider>(builder: (context, provider, child) {
          return MainButton(
            'ABOUT THE GAME',
            () {
              Navigator.of(context).pushReplacementNamed(AboutPage.id);
              provider.playTypingAudio();
            },
          );
        }),
        const SizedBox(height: 20),
        Consumer<AudioProvider>(
          builder: (context, audioProvider, child) => MainButton(
            "EXIT",
            () {
              audioProvider.disposeMusicPlayer();
              audioProvider.disposeTypingPlayer();
              SystemNavigator.pop();
            },
          ),
        ),
      ],
    );
  }
}
