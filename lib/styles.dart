import 'dart:ui';

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
}

class DarkStyle extends Style {
  double headingOne = 5.5;
  double heading2Size = 5.5;
}
