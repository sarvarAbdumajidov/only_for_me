import 'package:flutter/material.dart';
import 'package:only_for_me/constants/colors.dart';
import 'package:only_for_me/constants/fonts.dart';

Widget customItem(String question, String answer,[Color color = CustomColors.borderColorBlue]) {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.all(20),
    width: double.infinity,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color, width: 4),
        color: Colors.white),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          question,
          style: textStyleForLato(color: Colors.black),
        ),
        Divider(
          height: 20,
          thickness: 2,
          color: CustomColors.borderColorBlue,
        ),
        Text(
          answer,
          style: textStyleForLato(color: Colors.black)
          ,
        ),
      ],
    ),
  );
}
