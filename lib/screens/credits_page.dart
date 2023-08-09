import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:glass_pyramid/provider/audio_provider.dart';
import 'package:glass_pyramid/screens/home_page.dart';
import 'package:glass_pyramid/widgets/main_button.dart';
import 'package:provider/provider.dart';

class CreditsPage extends StatelessWidget {
  static String id = "creditsPage";
  CreditsPage({Key? key}) : super(key: key);

  final List<String> textList = [
    "The Glass pyramid is an interactive story game mixing between fiction & reality, sadness & happiness, and even between past & future.\n\nIt will take you away into an adventure that you will not forget\n\nGood luck and have fun",
    "Directed by\n\nAhmed El-Sarta",
    "Art Director\n\nAhmed El-Sarta",
    "Lead Programmer\n\nSherif Ahmed"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  "credits".toUpperCase(),
                  style: TextStyle(color: Colors.green[300], fontSize: 30),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(20),
                ),
                height: 500,
                child: Consumer<AudioProvider>(
                  builder: (context, provider, child) => Center(
                    child: AnimatedTextKit(
                      onNextBeforePause: (p0, p1) {
                        provider.stopTypingAudio();
                      },
                      onNext: (p0, p1) {
                        provider.playTypingAudio();
                      },
                      repeatForever: true,
                      animatedTexts: List.generate(
                        textList.length,
                        (index) => TypewriterAnimatedText(
                          textList[index].toUpperCase(),
                          speed: const Duration(milliseconds: 50),
                          textStyle: TextStyle(
                            fontSize: 30,
                            color: Colors.green[300],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Consumer<AudioProvider>(
                builder: (context, provider, child) {
                  return MainButton(
                    "Back",
                    () {
                      Navigator.of(context).pushReplacementNamed(HomePage.id);
                      provider.stopTypingAudio();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
