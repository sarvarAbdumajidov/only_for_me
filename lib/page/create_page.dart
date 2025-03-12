import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:only_for_me/constants/colors.dart';
import 'package:only_for_me/constants/fonts.dart';
import 'package:only_for_me/constants/strings.dart';
import 'package:only_for_me/model/couple_model.dart';
import 'package:only_for_me/page/home_page.dart';
import 'package:only_for_me/service/hive_service.dart';
import 'package:only_for_me/service/log_service.dart';
import 'package:only_for_me/views/custom_app_bar.dart';
import 'package:only_for_me/views/custom_elevated_button.dart';
import 'package:only_for_me/views/custom_snackBar.dart';
import 'package:only_for_me/views/custom_text_field.dart';
import 'package:uuid/uuid.dart';

class CreatePage extends StatefulWidget {
  static const String id = '/createPage';

  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();

  _clearController() {
    _questionController.clear();
    _answerController.clear();
  }

  String _generateId() {
    var uuid = Uuid();
    return uuid.v4();
  }

  Future<void> _fetchData() async {
    String question = _questionController.text.trim();
    String answer = _answerController.text.trim();

    if (question.isEmpty || answer.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          customSnackBar(Strings.fillInTheBlank, CustomColors.snackBarColor));
      return;
    }

    // data

    var couple = Couple(id: _generateId(), question: question, answer: answer);
    HiveService.storeData(couple);

    _clearController();
    ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
        Strings.createSuccessSnack, CustomColors.borderColorBlue));
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _clearController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: CustomColors.backgroundColor,
        appBar: CustomAppBar(
          title: Strings.create,
          centerTitle: true,
          leading: BackButton(
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 100),
                  reverseTransitionDuration: Duration(milliseconds: 100),
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      HomePage(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                ),
              );

              // Navigator.of(context).pushAndRemoveUntil(
              //   MaterialPageRoute(builder: (context) => HomePage()),
              //       (route) => false,
              // );
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 50, bottom: 25),
                  child: customTextField(
                    _questionController,
                    Strings.question,
                    Strings.hintQuestion,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25, bottom: 50),
                  child: customTextField(
                    _answerController,
                    Strings.answer,
                    Strings.hintAnswer,
                  ),
                ),
                customElevatedButton(
                  _fetchData,
                  CustomColors.textColor,
                  CustomColors.borderColorTeal,
                  CustomColors.buttonColorTeal,
                  Strings.create,
                  textStyleForLato(color: CustomColors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
