import 'package:flutter/material.dart';


class MyText extends Text {

  MyText(data, {
    TextAlign textAlign: TextAlign.center,
    double fontSize: 17.0,
    FontStyle style: FontStyle.normal,
    Color color: Colors.white
}) : super (
    data,
    textAlign: textAlign,
    style: TextStyle(
      fontSize: fontSize,
      fontStyle: style,
      color: color
    )
  );
}