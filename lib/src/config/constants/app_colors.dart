import 'package:flutter/material.dart';

class AppColors {
  //common colors
  static const Color transparentColor = Color(0x00000000);
  static const Color whiteColor = Color(0xffffffff);
  static const Color dividerColor = Color(0xffEEEEEE);

  static const Color blackColor = Color(0XFF000000);
  static const Color appColor = Color(0XFF3FA9F5);
  static const Color darkGreyColor = Color(0XFF596780);
  static const Color darkBlueColor = Color(0XFF016F94);
  static const Color redColor = Color(0XFFEA4335);
  static const Color borderColor = Color(0XFFD4D4D4);
  static const Color greyColor = Color(0XFFAAAEB7);
  static const Color yellowColor = Color(0XFFFFC600);
  static const lightPinkColor = Color(0xffFFE3E3);
  static const offWhiteColor = Color(0xffFBFBFB);
  static const lightGreyColor = Color(0xffF6F6F6);
  static const deepRedColor = Color(0xffFF3B30);

  static const suscessSnackColor = Color(0xff0d703f);
  static const errorSnackColor = Color(0xffc72c41);
  static const infoSnackColor = Color(0xff3282b7);

  static const gredientColor = Color(0xFF3CC9E1);

  // Define a LinearGradient
  static const LinearGradient gradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [AppColors.appColor, AppColors.gredientColor],
  );


   static const lightBlueColor = Color(0xffF7F7F7);
  static const vividBlueColor = Color(0xff0277BD);
  static const midGreyColor = Color(0xff7987A5);
  static const blueIceColor = Color(0xffE6F2F9);

}
