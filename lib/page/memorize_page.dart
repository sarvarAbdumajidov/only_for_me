import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:only_for_me/constants/colors.dart';
import 'package:only_for_me/constants/fonts.dart';
import 'package:only_for_me/model/couple_model.dart';
import 'package:only_for_me/service/hive_service.dart';
import 'package:only_for_me/service/log_service.dart';
import 'package:only_for_me/views/custom_app_bar.dart';
import 'package:only_for_me/views/custom_snackBar.dart';
import '../constants/strings.dart';
import '../views/custom_elevated_button.dart';
import '../views/custom_item_question.dart';
import '../views/custom_text_field.dart';
import 'home_page.dart';

class MemorizePage extends StatefulWidget {
  static const String id = "/memorizePage";

  const MemorizePage({super.key});

  @override
  State<MemorizePage> createState() => _MemorizePageState();
}

class _MemorizePageState extends State<MemorizePage> {
  final TextEditingController _answerController = TextEditingController();
  List<Couple> coupleList = [];
  List<Couple> constList = [];
  Couple? currentCouple;
  bool isTap = false;
  String? oldData;

  @override
  void initState() {
    super.initState();
    _loadData();
    LogService.d(oldData.toString());
  }
  @override
  void dispose() {
    _answerController.clear();
    super.dispose();
  }

  void _updateData() {
    String answer = _answerController.text.trim();
    if (answer.isEmpty) {
      return;
    }
    String answers = '● ${currentCouple!.answer}\n● $answer';
    var updateData = Couple(
        id: currentCouple!.id,
        question: currentCouple!.question,
        answer: answers);
    HiveService.storeData(updateData);
    _answerController.clear();
    ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(Strings.successSnack, CustomColors.borderColorBlue,1));
  }

  void _loadData() {
    List<Couple> fetchList = HiveService.getAllCouples();
    setState(() {
      coupleList = fetchList;
      constList = fetchList;
      if (coupleList.isNotEmpty) {
        currentCouple = coupleList.removeAt(0);
        oldData = currentCouple!.answer.toString();
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      if (coupleList.isNotEmpty) {
        currentCouple = coupleList.removeAt(0);
        oldData = currentCouple!.answer.toString();
      } else {
        coupleList = List.from(constList);
        coupleList.shuffle();
        if (coupleList.isNotEmpty) {
          currentCouple = coupleList.removeAt(0);
          oldData = currentCouple!.answer.toString();
        }
        ScaffoldMessenger.of(context).showSnackBar(
          customSnackBar(
            Strings.restarted,
            CustomColors.snackBarColor,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(title: Strings.memorize, centerTitle: true,leading: BackButton(
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
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),),
        backgroundColor: CustomColors.backgroundColor,
        body: currentCouple == null
            ? Center(
          child: Text(
            Strings.isEmpty,
            style: TextStyle(color: Colors.white,fontSize: 25),
          ),
        )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50, bottom: 25),
                        child: customItemQuestion(
                          currentCouple!.question,
                          CustomColors.snackBarColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25, bottom: 50),
                        child: customTextField(
                          _answerController,
                          Strings.answer,
                          Strings.hintAnswer,
                          CustomColors.snackBarColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 50),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isTap = !isTap;
                            });
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              customItemQuestion(
                                  currentCouple!.answer,
                                  isTap
                                      ? CustomColors.borderColorTeal
                                      : CustomColors.transparent,
                                  isTap
                                      ? []
                                      : [Color(0xFF2c3e50), Color(0xFF4ca1af)],
                                  isTap
                                      ? Colors.black
                                      : Colors.black.withOpacity(0.01)),
                              isTap
                                  ? Icon(
                                      CupertinoIcons.eye_slash,
                                      size: 40,
                                      color: Colors.transparent,
                                    )
                                  : Icon(
                                      CupertinoIcons.eye_slash,
                                      size: 40,
                                      color: Colors.white,
                                    )
                            ],
                          ),
                        ),
                      ),
                      customElevatedButton(
                        () {
                          _updateData();
                          _nextQuestion();

                          setState(() {
                            isTap = false;
                            LogService.d(oldData.toString());
                          });
                        },
                        CustomColors.white,
                        CustomColors.borderColorTeal,
                        CustomColors.buttonColorTeal,
                        Strings.next,
                        textStyleForLato(
                          color: CustomColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
