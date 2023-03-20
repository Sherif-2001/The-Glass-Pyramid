import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glass_pyramid/provider/audio_provider.dart';
import 'package:glass_pyramid/provider/scene_provider.dart';
import 'package:glass_pyramid/provider/skill_provider.dart';
import 'package:glass_pyramid/screens/about_page.dart';
import 'package:glass_pyramid/screens/gameplay_page.dart';
import 'package:glass_pyramid/screens/splash_page.dart';
import 'package:glass_pyramid/screens/stats_page.dart';
import 'package:provider/provider.dart';
import 'screens/home_page.dart';

void main(List<String> args) {
  runApp(const MyApp());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SceneProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AudioProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SkillProvider(),
        )
      ],
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(
            fontFamily: "geo",
            scaffoldBackgroundColor: Colors.blueGrey[900],
            sliderTheme: SliderTheme.of(context).copyWith(
              thumbShape: SliderComponentShape.noThumb,
              tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 5),
            ),
          ),
          initialRoute: SplashPage.id,
          routes: {
            SplashPage.id: (context) => const SplashPage(),
            HomePage.id: (context) => const HomePage(),
            AboutPage.id: (context) => AboutPage(),
            GameplayPage.id: (context) => const GameplayPage(),
            StatsPage.id: (context) => const StatsPage()
          },
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
