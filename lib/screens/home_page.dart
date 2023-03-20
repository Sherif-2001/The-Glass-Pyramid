import 'package:flutter/material.dart';
import 'package:glass_pyramid/provider/audio_provider.dart';
import 'package:glass_pyramid/widgets/home_page/home_page_buttons.dart';
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
                  "the Glass Pyramid",
                  style: TextStyle(color: Colors.green[300], fontSize: 35),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/game_image.png'),
              ),
              const SizedBox(height: 20),
              HomePageButtons(
                onSettingsClick: () => showSettingsDialog(context),
              )
            ],
          ),
        ),
      ),
    );
  }
}
