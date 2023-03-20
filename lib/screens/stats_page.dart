import 'package:flutter/material.dart';
import 'package:glass_pyramid/constants.dart';
import 'package:glass_pyramid/provider/audio_provider.dart';
import 'package:glass_pyramid/provider/skill_provider.dart';
import 'package:glass_pyramid/screens/gameplay_page.dart';
import 'package:glass_pyramid/screens/home_page.dart';
import 'package:glass_pyramid/widgets/main_button.dart';
import 'package:provider/provider.dart';
import '../provider/scene_provider.dart';
import '../widgets/stats_page/stats_skill_widget.dart';

class StatsPage extends StatefulWidget {
  static String id = "statsPageId";
  const StatsPage({Key? key}) : super(key: key);

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Your Stats",
          style: TextStyle(
            fontSize: 50,
            color: Colors.green[300],
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Consumer<SkillProvider>(
        builder: (context, skillProvider, child) => Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Center(
                child: Text(
                  "Skill Points: ${skillProvider.getSkillPoints().toString()}",
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.green[300],
                  ),
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                itemCount: Stat.values.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 30),
                itemBuilder: (context, index) =>
                    StatsSkillWidget(stat: Stat.values[index]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Consumer<AudioProvider>(
                    builder: (context, audioProvider, child) => Expanded(
                      child: MainButton(
                        "Back",
                        () {
                          Navigator.of(context)
                              .pushReplacementNamed(HomePage.id);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Consumer2<SceneProvider, AudioProvider>(
                      builder: (context, sceneProvider, audioProvider, child) =>
                          MainButton(
                        "Done",
                        () {
                          if (skillProvider.getSkillPoints() == 0) {
                            Navigator.of(context)
                                .pushReplacementNamed(GameplayPage.id);
                            sceneProvider.startGame();
                            audioProvider.playTypingAudio();
                          }
                        },
                      ),
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
