import 'package:flutter/material.dart';
import 'package:only_for_me/constants/fonts.dart';
import '../constants/colors.dart';

Widget customTextField(
    TextEditingController controller, String text, [String hintText = '',Color color = Colors.white]) {
  return Container(
    width: double.infinity,
    height: 220,
    decoration: BoxDecoration(
      border: Border.all(color: color,width: 4),
      color: CustomColors.white,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.centerLeft,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 10),
              width: 100,
              height: 35,
              decoration: BoxDecoration(
                color: CustomColors.borderColorTeal,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                text,
                style: textStyleForLato(color: CustomColors.textColorBlack),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              controller: controller,
              style: textStyleForLora(color: CustomColors.inputText),
              expands: true,
              maxLines: null,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: textStyleForLato(color: Colors.grey)),
            ),
          ),
        ),
      ],
    ),
  );
}
