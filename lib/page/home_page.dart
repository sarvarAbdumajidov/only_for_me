import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:only_for_me/constants/colors.dart';
import 'package:only_for_me/constants/fonts.dart';
import 'package:only_for_me/constants/strings.dart';
import 'package:only_for_me/page/countList_page.dart';
import 'package:only_for_me/page/create_page.dart';
import 'package:only_for_me/page/memorize_page.dart';
import 'package:only_for_me/page/setup_page.dart';
import 'package:only_for_me/views/custom_elevated_button.dart';

class HomePage extends StatefulWidget {
  static const String id = "/homePage";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController controller = TextEditingController();

  _navigateCreate() {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 100),
        pageBuilder: (context, animation, secondaryAnimation) => CreatePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  _navigateCountList() {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 100),
        pageBuilder: (context, animation, secondaryAnimation) =>
            CountListPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  _navigateSetup() {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 100),
        pageBuilder: (context, animation, secondaryAnimation) => SetupPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  _navigateMemorize() {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 100),
        pageBuilder: (context, animation, secondaryAnimation) => MemorizePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.backgroundColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: customElevatedButton(
                      _navigateCreate,
                      CustomColors.textColor,
                      CustomColors.buttonColor,
                      CustomColors.borderColor,
                      Strings.create,
                      textStyleForLato(
                        color: CustomColors.textColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: customElevatedButton(
                      _navigateCountList,
                      CustomColors.textColor,
                      CustomColors.buttonColor,
                      CustomColors.borderColor,
                      Strings.countList,
                      textStyleForLato(
                        color: CustomColors.textColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: customElevatedButton(
                      _navigateSetup,
                      CustomColors.textColor,
                      CustomColors.buttonColor,
                      CustomColors.borderColor,
                      Strings.setup,
                      textStyleForLato(
                        color: CustomColors.textColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: customElevatedButton(
                      _navigateMemorize,
                      CustomColors.textColor,
                      CustomColors.buttonColor,
                      CustomColors.borderColor,
                      Strings.memorize,
                      textStyleForLato(
                        color: CustomColors.textColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
