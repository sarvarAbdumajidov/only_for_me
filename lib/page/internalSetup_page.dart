import 'package:flutter/material.dart';
import 'package:only_for_me/constants/fonts.dart';
import 'package:only_for_me/model/couple_model.dart';
import 'package:only_for_me/page/setup_page.dart';
import 'package:only_for_me/service/hive_service.dart';
import 'package:only_for_me/views/custom_app_bar.dart';
import 'package:only_for_me/views/custom_elevated_button.dart';
import 'package:only_for_me/views/custom_text_field.dart';

import '../constants/colors.dart';
import '../constants/strings.dart';
import '../service/log_service.dart';
import '../views/custom_snackBar.dart';

class InternalSetupPage extends StatefulWidget {
  static const String id = "/internalSetupPage";

  const InternalSetupPage({super.key});

  @override
  State<InternalSetupPage> createState() => _InternalSetupPageState();
}

class _InternalSetupPageState extends State<InternalSetupPage> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();

  _clearController() {
    _questionController.clear();
    _answerController.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _clearController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)!.settings.arguments as Couple;
    _questionController.text = data.question;
    _answerController.text = data.answer;

    void _updateData() {
      String question = _questionController.text.trim();
      String answer = _answerController.text.trim();
      if (question.isEmpty || answer.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(Strings.fillInTheBlank, CustomColors.snackBarColor));
        return;
      }

      var updateCouple =
          Couple(id: data.id, question: question, answer: answer);
      HiveService.storeData(updateCouple);
      _clearController();
      ScaffoldMessenger.of(context).showSnackBar(
          customSnackBar(Strings.successSnack, CustomColors.borderColorBlue));
      Future.delayed(
        Duration(seconds: 2),
        () {
          Navigator.pop(context, true);
        },
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.backgroundColor,
        appBar: CustomAppBar(
          title: Strings.setup,
          centerTitle: true,
          leading: BackButton(
            onPressed: () {
              Navigator.of(context).pop(
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 100),
                  reverseTransitionDuration: Duration(milliseconds: 100),
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      SetupPage(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                ),
              );
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50, bottom: 25),
                  child: customTextField(_questionController, Strings.question),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 50),
                  child: customTextField(_answerController, Strings.answer),
                ),
                customElevatedButton(
                  () {
                    _updateData();
                  },
                  CustomColors.white,
                  CustomColors.borderColorTeal,
                  CustomColors.buttonColorTeal,
                  Strings.change,
                  textStyleForLato(
                    color: CustomColors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
