import 'package:flutter/material.dart';
import 'package:only_for_me/constants/colors.dart';

Widget customItemQuestion(String text,
    [Color color = CustomColors.borderColorBlue,
    List<Color>? colors,
    Color textColor = Colors.black]) {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.all(20),
    width: double.infinity,
    decoration: BoxDecoration(
        gradient: colors != null && colors.isNotEmpty
            ? LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: colors)
            : null,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color, width: 4),
        color: Colors.white),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          text,
          style: TextStyle(color: textColor, fontSize: 20),
        ),
      ],
    ),
  );
}
