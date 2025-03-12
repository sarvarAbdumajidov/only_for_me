import 'package:flutter/material.dart';
import 'package:only_for_me/constants/colors.dart';
import 'package:only_for_me/page/countList_page.dart';
import 'package:only_for_me/page/create_page.dart';
import 'package:only_for_me/page/home_page.dart';
import 'package:only_for_me/page/internalSetup_page.dart';
import 'package:only_for_me/page/intro_page.dart';
import 'package:only_for_me/page/memorize_page.dart';
import 'package:only_for_me/page/setup_page.dart';

class MyApp extends StatelessWidget {
  final bool isIntroShown;

  const MyApp({super.key, required this.isIntroShown});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            color: CustomColors.introColor,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: isIntroShown ? HomePage.id : IntroPage.id,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case InternalSetupPage.id:
            return PageRouteBuilder(

              transitionDuration: Duration(milliseconds: 300),
              pageBuilder: (context, animation, secondaryAnimation) =>
                  InternalSetupPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            );
          default:
            return null;
        }
      },
      routes: {
        HomePage.id: (context) => HomePage(),
        CreatePage.id: (context) => CreatePage(),
        CountListPage.id: (context) => CountListPage(),
        InternalSetupPage.id: (context) => InternalSetupPage(),
        IntroPage.id: (context) => IntroPage(),
        MemorizePage.id: (context) => MemorizePage(),
        SetupPage.id: (context) => SetupPage(),
      },
    );
  }
}
