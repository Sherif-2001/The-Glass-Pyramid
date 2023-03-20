import 'package:flutter/material.dart';
import 'package:glass_pyramid/provider/audio_provider.dart';
import 'package:glass_pyramid/provider/scene_provider.dart';
import 'package:glass_pyramid/widgets/main_button.dart';
import 'package:provider/provider.dart';

class GameplayChoiceButtons extends StatelessWidget {
  const GameplayChoiceButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<AudioProvider, SceneProvider>(
      builder: (context, audioProvider, sceneProvider, child) =>
          ListView.separated(
        shrinkWrap: true,
        itemCount: sceneProvider.choiceslength,
        itemBuilder: (context, index) => MainButton(
          sceneProvider.choicesText[index],
          () {
            audioProvider.playTypingAudio();
            sceneProvider.onChoiceClicked(index);
          },
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 20),
      ),
    );
  }
}
