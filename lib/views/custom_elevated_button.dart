import 'package:flutter/material.dart';

Widget customElevatedButton(VoidCallback function, Color textColor,
    Color background, Color borderColor, String text, TextStyle style) {
  return SizedBox(
    width: double.infinity,
    height: 70,
    child: ElevatedButton(
      onPressed: function,
      style: ElevatedButton.styleFrom(
        foregroundColor: textColor,
        backgroundColor: background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: borderColor,
            width: 3,
          ),
        ),
      ),
      child: Text(text, style: style),
    ),
  );
}
