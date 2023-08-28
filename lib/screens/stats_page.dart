import 'package:flutter/material.dart';
import 'package:glass_pyramid/constants.dart';
import 'package:glass_pyramid/provider/audio_provider.dart';
import 'package:glass_pyramid/provider/scene_provider.dart';
import 'package:glass_pyramid/provider/skill_provider.dart';
import 'package:glass_pyramid/screens/gameplay_page.dart';
import 'package:glass_pyramid/screens/home_page.dart';
import 'package:glass_pyramid/widgets/main_button.dart';
import 'package:glass_pyramid/widgets/stats_page/stats_skill_widget.dart';
import 'package:provider/provider.dart';

class StatsPage extends StatefulWidget {
  static String id = "statsPageId";
  const StatsPage({Key? key}) : super(key: key);

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Consumer<SkillProvider>(
            builder: (context, skillProvider, child) => Text(
              "Skill Points: ${skillProvider.skillPoints.toString()}",
              style: TextStyle(
                fontSize: 40,
                color: Colors.green[300],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ListView.separated(
                shrinkWrap: true,
                itemCount: Stat.values.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 40),
                itemBuilder: (context, index) =>
                    StatsSkillWidget(stat: Stat.values[index]),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Consumer3<SceneProvider, AudioProvider, SkillProvider>(
                    builder: (context, sceneProvider, audioProvider,
                            skillProvider, child) =>
                        MainButton(
                      "Start",
                      () {
                        if (skillProvider.skillPoints == 0) {
                          Navigator.of(context)
                              .pushReplacementNamed(GameplayPage.id);
                          sceneProvider.startGame();
                          audioProvider.playTypingAudio();
                          skillProvider.saveSkills();
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Consumer<AudioProvider>(
                    builder: (context, audioProvider, child) => MainButton(
                      "Back",
                      () {
                        Navigator.of(context).pushReplacementNamed(HomePage.id);
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
