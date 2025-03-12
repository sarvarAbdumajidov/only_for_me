import 'package:flutter/material.dart';

class Fonts {
  Fonts._();

  static const lato = "Lato";
  static const lora = "Lora";
  static const itim = "Itim";
  static const jacques = "Jacques";
}

TextStyle textStyleForLato(
    {double fontSize = 20, required Color color, double? height}) {
  return TextStyle(
    height: height,
    fontSize: fontSize,
    fontFamily: Fonts.lato,
    fontWeight: FontWeight.bold,
  );
}

TextStyle textStyleForItim(
    {double fontSize = 22, required Color color, double? height}) {
  return TextStyle(
    height: height,
    fontSize: fontSize,
    fontFamily: Fonts.itim,
    fontWeight: FontWeight.w500,
  );
}

TextStyle textStyleForJacques(
    {double fontSize = 40, required Color color, double? height}) {
  return TextStyle(
    height: height,
    fontSize: fontSize,
    fontFamily: Fonts.jacques,
    fontWeight: FontWeight.w500,
  );
}

TextStyle textStyleForLora(
    {double fontSize = 22, required Color color, double? height}) {
  return TextStyle(
    height: height,
    fontSize: fontSize,
    fontFamily: Fonts.lora,
    fontWeight: FontWeight.w600,
  );

}
TextStyle textStyleForEmpty(
    {double fontSize = 25, required Color color, double? height}) {
  return TextStyle(
    height: height,
    fontSize: fontSize,
    fontWeight: FontWeight.w600,
  );
}
