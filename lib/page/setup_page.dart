import 'package:flutter/material.dart';
import 'package:only_for_me/constants/fonts.dart';
import 'package:only_for_me/model/couple_model.dart';
import 'package:only_for_me/page/internalSetup_page.dart';
import 'package:only_for_me/service/hive_service.dart';
import 'package:only_for_me/service/log_service.dart';
import 'package:only_for_me/views/custom_elevated_button.dart';

import '../constants/colors.dart';
import '../constants/strings.dart';
import '../views/custom_app_bar.dart';
import '../views/custom_item.dart';
import 'home_page.dart';

class SetupPage extends StatefulWidget {
  static const String id = "/setupPage";

  const SetupPage({super.key});

  @override
  State<SetupPage> createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  late int doubleTapIndex;
  List<int> selectedIndex = [];
  List<Couple> coupleList = [];

  void _selection(int index) {
    setState(() {
      if (selectedIndex.contains(index)) {
        selectedIndex.remove(index);
      } else {
        selectedIndex.add(index);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    List<Couple> fetchedCouples = HiveService.getAllCouples();
    setState(() {
      coupleList = fetchedCouples;
    });
  }

  void _deleteData() {
    setState(() {
      for (int item in selectedIndex) {
        HiveService.removeCouple(coupleList[item].id);
      }
      _loadData();
      selectedIndex.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.backgroundColor,
        appBar: CustomAppBar(
          title: Strings.setup,
          centerTitle: true,
          leading: BackButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
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
                (routes) => false,
              );
            },
          ),
        ),
        body: coupleList.isEmpty
            ? Center(
                child: Text(
                  Strings.isEmpty,
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              )
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Column(
                  children: [
                    Expanded(
                      flex: 9,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: ListView.builder(
                          itemCount: coupleList.length,
                          itemBuilder: (ctx, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: GestureDetector(
                                onDoubleTap: () async {
                                  setState(() {
                                    selectedIndex.clear();
                                  });

                                  // var result = await Navigator.of(context).pushNamed(
                                  //   PageRouteBuilder(
                                  //     transitionDuration:
                                  //         Duration(milliseconds: 300),
                                  //     pageBuilder: (context, animation,
                                  //         secondaryAnimation) {
                                  //       return InternalSetupPage();
                                  //     },
                                  //     transitionsBuilder: (context, animation,
                                  //         secondaryAnimation, child) {
                                  //       return FadeTransition(
                                  //           opacity: animation, child: child);
                                  //     },
                                  //   ),
                                  // );

                                  var result = await Navigator.of(context)
                                      .pushNamed(InternalSetupPage.id,
                                          arguments: coupleList[index]);
                                  if (result != null && result == true) {
                                    _loadData();
                                  }
                                },
                                onTap: () {
                                  setState(() {
                                    _selection(index);
                                    LogService.i(index.toString());
                                  });
                                },
                                child: customItem(
                                    coupleList[index].question,
                                    coupleList[index].answer,
                                    selectedIndex.contains(index)
                                        ? CustomColors.delete
                                        : CustomColors.borderColorBlue),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: customElevatedButton(
                        _deleteData,
                        CustomColors.white,
                        selectedIndex.isEmpty
                            ? CustomColors.borderColorTeal
                            : CustomColors.delete,
                        selectedIndex.isEmpty
                            ? CustomColors.buttonColorTeal
                            : CustomColors.delete,
                        Strings.select,
                        textStyleForLato(
                          color: CustomColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
