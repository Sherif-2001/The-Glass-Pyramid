import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glass_pyramid/provider/audio_provider.dart';
import 'package:glass_pyramid/provider/scene_provider.dart';
import 'package:glass_pyramid/provider/skill_provider.dart';
import 'package:glass_pyramid/screens/credits_page.dart';
import 'package:glass_pyramid/screens/stats_page.dart';
import 'package:glass_pyramid/widgets/main_button.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static String id = "homePageId";

  void showSettingsDialog(BuildContext context) {
    Alert(
      context: context,
      useRootNavigator: true,
      content: Column(
        children: [
          const Divider(thickness: 2, color: Colors.white),
          ListTile(
            title: const Text(
              "BG Music",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            trailing: Consumer<AudioProvider>(
              builder: (context, provider, child) {
                return IconButton(
                  onPressed: () {
                    provider.checkMusicSettings();
                  },
                  icon: Icon(
                    provider.musicSettingsIcon,
                    color: Colors.white,
                    size: 30,
                  ),
                );
              },
            ),
          ),
          ListTile(
            title: const Text(
              "SFX",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            trailing: Consumer<AudioProvider>(
              builder: (context, provider, child) {
                return IconButton(
                  onPressed: () {
                    provider.checkSFXSettings();
                  },
                  icon: Icon(
                    provider.sfxSettingsIcon,
                    color: Colors.white,
                    size: 30,
                  ),
                );
              },
            ),
          )
        ],
      ),
      title: "Settings",
      style: const AlertStyle(
        isCloseButton: false,
        isButtonVisible: false,
        backgroundColor: Colors.black54,
        titleStyle: TextStyle(color: Colors.white, fontSize: 40),
      ),
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Center(
                child: Text(
                  "the glass pyramid".toUpperCase(),
                  style: TextStyle(color: Colors.green[300], fontSize: 35),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/images/game_image.png'),
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Consumer2<SkillProvider, SceneProvider>(
                    builder: (context, skillProvider, sceneProvider, child) =>
                        MainButton(
                      "Start adventure".toUpperCase(),
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
                    () => showSettingsDialog(context),
                  ),
                  const SizedBox(height: 20),
                  Consumer<AudioProvider>(
                    builder: (context, provider, child) {
                      return MainButton(
                        'Credits'.toUpperCase(),
                        () {
                          Navigator.of(context)
                              .pushReplacementNamed(CreditsPage.id);
                          provider.playTypingAudio();
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Consumer<AudioProvider>(
                    builder: (context, audioProvider, child) => MainButton(
                      "exit".toUpperCase(),
                      () {
                        audioProvider.disposeMusicPlayer();
                        audioProvider.disposeTypingPlayer();
                        SystemNavigator.pop();
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
