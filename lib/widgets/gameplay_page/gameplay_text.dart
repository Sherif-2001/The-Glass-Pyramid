import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:glass_pyramid/provider/audio_provider.dart';
import 'package:glass_pyramid/provider/scene_provider.dart';
import 'package:provider/provider.dart';

class GameplayText extends StatelessWidget {
  const GameplayText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 300,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Consumer2<AudioProvider, SceneProvider>(
        builder: (context, audioProvider, sceneProvider, child) =>
            AnimatedTextKit(
          key: ValueKey(sceneProvider.sceneText),
          displayFullTextOnTap: true,
          stopPauseOnTap: true,
          repeatForever: true,
          pause: const Duration(days: 1),
          onNextBeforePause: (p0, p1) {
            audioProvider.stopTypingAudio();
          },
          onNext: (p0, p1) {
            sceneProvider.onTextClicked();
            if (sceneProvider.isTextVisible) {
              audioProvider.playTypingAudio();
            }
          },
          animatedTexts: [
            TypewriterAnimatedText(
              sceneProvider.sceneText,
              speed: const Duration(milliseconds: 50),
              textStyle: TextStyle(fontSize: 20, color: Colors.green[300]),
            ),
          ],
        ),
      ),
    );
  }
}
