import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class Style {}

class StateColor {
  static const Color danger = Color(0xffE37358);
  static const Color success = Color(0xff63E1A9);
  static const Color warning = Color(0xffE5C361);
}

class DarkPalette {
  static const Color darkGold = Color(0xffE5C361);
  static const Color darkYellow = Color(0xffFBEED3);
  static const Color darkDark = Color(0xff595959);
  static const Color darkGrey1 = Color(0xff595959);
  static const Color darkGrey2 = Color(0xffABAAAA);
  static const Color darkGrey3 = Color(0xffE3E1E1);
  static const Color white = Color(0xff000000);
  static const Color lightBlue = Color(0xff3B7AD8);
  static const Color lightFushia = Color(0xffCD446D);
  static const Gradient borderGradient1 = LinearGradient(colors: <Color>[
    Color(0xffF9F295),
    Color(0xffE0AA3E),
    Color(0xffE0AA34),
    Color(0xffB88A44)
  ], stops: [
    -0.86,
    33.19,
    69.9,
    101.29
  ], transform: GradientRotation(254.74));
}

var font = GoogleFonts.workSans(fontWeight: FontWeight.w700);

class DarkStyle extends Style {
  String fontFamily = "worksans";
  double headingOne = 5.5;
  double heading2Size = 5.5;
  double headingOneSize = 34;
  double headingOneLineHeight = 44.2;

  double headingTwoSize = 24;
  double headingTwoLineHeight = 44.2;

  double headingThreeSize = 18;
  double headingThreeLineHeight = 28.8;

  // Body Big
  // font-family: Work Sans;
  // font-size: 14px;
  // font-style: normal;
  // font-weight: 300;
  // line-height: 24px;
  // letter-spacing: 0em;
  // text-align: left;
  //
  //
  //
  // Body Medium
  // font-family: Work Sans;
  // font-size: 12px;
  // font-style: normal;
  // font-weight: 300;
  // line-height: 20px;
  // letter-spacing: 0em;
  // text-align: left;
  //
  //
  //
  // Body small
  //
  // font-family: Work Sans;
  // font-size: 8px;
  // font-style: normal;
  // font-weight: 300;
  // line-height: 14px;
  // letter-spacing: 0em;
  // text-align: left;

}
