import 'package:flutter/material.dart';
import 'package:only_for_me/constants/colors.dart';
import 'package:only_for_me/constants/fonts.dart';
import 'package:only_for_me/service/hive_service.dart';
import 'package:only_for_me/views/custom_app_bar.dart';
import 'package:only_for_me/views/custom_item.dart';
import '../constants/strings.dart';
import '../model/couple_model.dart';
import 'home_page.dart';

class CountListPage extends StatefulWidget {
  static const String id = "/countListPage";

  const CountListPage({super.key});

  @override
  State<CountListPage> createState() => _CountListPageState();
}

class _CountListPageState extends State<CountListPage> {
  List<Couple> coupleList = [];

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.backgroundColor,
        appBar: CustomAppBar(
          title: Strings.countList,
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
            },
          ),
        ),
        body: coupleList.isEmpty
            ? Center(
                child: Text(
                  Strings.isEmpty,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              )
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: ListView.builder(
                  itemCount: coupleList.length,
                  itemBuilder: (ctx, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: customItem(
                        coupleList[index].question,
                        coupleList[index].answer,
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
