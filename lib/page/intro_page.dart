import 'package:flutter/material.dart';
import 'package:only_for_me/constants/colors.dart';
import 'package:only_for_me/constants/fonts.dart';
import 'package:only_for_me/constants/images.dart';
import 'package:only_for_me/page/home_page.dart';
import 'package:only_for_me/service/hive_setting_box.dart';

import '../constants/strings.dart';

class IntroPage extends StatefulWidget {
  static const String id = "/introPage";

  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  void initState() {
    SettingBox.storeData(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: CustomImages.introImage, fit: BoxFit.cover),
            ),
            child: Text(
              Strings.intro,
              style: textStyleForJacques(color: Colors.red),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          disabledElevation: 0,
          foregroundColor: Colors.transparent,
          focusColor: Colors.transparent,
          highlightElevation: 0,
          hoverColor: Colors.transparent,
          hoverElevation: 0,
          onPressed: () {
            Navigator.pushReplacementNamed(context, HomePage.id);
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          splashColor: Colors.transparent,
          child: Text(
            'next',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
      ),
    );
  }
}
