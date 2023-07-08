import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:glass_pyramid/provider/audio_provider.dart';
import 'package:glass_pyramid/screens/home_page.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  static String id = "splashpageid";

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<AudioProvider>(context, listen: false).playMusic();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                "assets/images/game_image.png",
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Glass Pyramid",
              style: TextStyle(color: Colors.green, fontSize: 40),
            ),
            const SizedBox(height: 30),
            const CircularProgressIndicator(color: Colors.green)
          ],
        ),
      ),
      splashIconSize: 400,
      splashTransition: SplashTransition.fadeTransition,
      animationDuration: const Duration(seconds: 1),
      backgroundColor: const Color(0xff333333),
      nextScreen: const HomePage(),
    );
  }
}
