import 'package:flutter/material.dart';
import 'package:only_for_me/constants/fonts.dart';

SnackBar customSnackBar(String message, Color backgroundColor,[int seconds = 2]) {
  return SnackBar(
    content: Text(message,style: textStyleForItim(color: Colors.white),),
    backgroundColor: backgroundColor,
    showCloseIcon: true,
    duration: Duration(seconds: seconds),
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.all(20),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  );
}
