import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:organize_flutter_project/src/business_logic/services/hive_services/hive_services.dart';
import 'package:organize_flutter_project/src/views/ui/login_register.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final pages = [
    PageViewModel(
        pageColor: const Color(0xFFff7171),
        // iconImageAssetPath: 'assets/air-hostess.png',
        bubble: Image.asset('assets/images/intro_one_blood_transfusion.png'),
        body: Text(
          'Donate your blood for save life and be a hero',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: .4
          ),
        ),
        title: Text(
          'Donate blood',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            letterSpacing: .4
          ),
        ),
        titleTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
        bodyTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
        mainImage: Image.asset(
          'assets/images/intro_one_blood_transfusion.png',
          height: 180.0,
          width: 180.0,
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
        )),
    PageViewModel(
        pageColor: const Color(0xFFffaa71),
        // iconImageAssetPath: 'assets/air-hostess.png',
        bubble: Image.asset('assets/images/intro2.png'),
        body: Text(
          'Search blood donor when you are in emergency',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: .4
          ),
        ),
        title: Text(
          'Search blood donor',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            letterSpacing: .4
          ),
        ),
        titleTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
        bodyTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
        mainImage: Image.asset(
          'assets/images/intro2.png',
          height: 180.0,
          width: 180.0,
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
        )),
    PageViewModel(
        pageColor: const Color(0xFF6e6d6d),
        // iconImageAssetPath: 'assets/air-hostess.png',
        bubble: Image.asset('assets/images/intro3.png'),
        body: Text(
          'See your friends are helping others from your news feed',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: .4
          ),
        ),
        title: Text(
          'Explore update around you',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            letterSpacing: .4
          ),
        ),
        titleTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
        bodyTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
        mainImage: Image.asset(
          'assets/images/intro3.png',
          height: 180.0,
          width: 180.0,
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
        )),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(//ThemeData
      body: Builder(
        builder: (context) => IntroViewsFlutter(
          pages,
          onTapSkipButton: (){
            HiveServices.addIntegerData(name: 'first_time', data: 1);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginRegister(),
              ), //MaterialPageRoute
            );
          },
          showNextButton: true,
          showBackButton: true,
          onTapDoneButton: () {
            HiveServices.addIntegerData(name: 'first_time', data: 1);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginRegister(),
              ), //MaterialPageRoute
            );
          },
          pageButtonTextStyles: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ), //IntroViewsFlutter
      ), //Builder
    ); //Material App
  }
}