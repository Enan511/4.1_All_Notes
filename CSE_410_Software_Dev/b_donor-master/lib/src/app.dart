import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:organize_flutter_project/src/views/ui/splash.dart';

class BDonorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: BotToastInit(), //1. call BotToastInit
      navigatorObservers: [BotToastNavigatorObserver()],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Montserrat'
      ),
      home: Splash(),
    );
  }
}
