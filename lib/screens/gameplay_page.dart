import 'package:flutter/material.dart';
import 'package:glass_pyramid/widgets/gameplay_page/gameplay_choice_buttons.dart';
import 'package:glass_pyramid/widgets/gameplay_page/gameplay_drawer.dart';
import 'package:glass_pyramid/widgets/gameplay_page/gameplay_text.dart';
import 'package:provider/provider.dart';
import '../provider/scene_provider.dart';

class GameplayPage extends StatelessWidget {
  static String id = "gameplayId";

  const GameplayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        drawer: const Drawer(
          backgroundColor: Colors.black54,
          child: GameplayDrawer(),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Consumer<SceneProvider>(
                builder: (context, sceneProvider, child) => Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black, width: 3)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(sceneProvider.sceneImage),
                  ),
                ),
              ),
              Consumer<SceneProvider>(
                builder: (context, sceneProvider, child) => Visibility(
                  visible: sceneProvider.isTextVisible,
                  child: const GameplayText(),
                  replacement: const GameplayChoiceButtons(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
