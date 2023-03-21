import 'package:flutter/material.dart';

bool use_compass = true;
Color kPrimaryColor = Color(0xffFC9D45);
Color kSecondaryColor = Color(0xff573353);

final kTitle = TextStyle(
  fontFamily: 'Klasik',
  fontSize: SizeConfig.blockSizeH! * 7,
  color: kSecondaryColor,
);

final kBodyText1 = TextStyle(
  color: kSecondaryColor,
  fontSize: SizeConfig.blockSizeH! * 4.5,
  fontWeight: FontWeight.bold,
);


class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? blockSizeH;
  static double? blockSizeV;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    blockSizeH = screenWidth! / 100;
    blockSizeV = screenHeight! / 100;
  }
}