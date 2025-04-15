import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/config/constants/assets.dart';
import 'package:yele/src/config/router/routes.dart';
import 'package:yele/src/core/database/storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    Timer(const Duration(seconds: 3), () {
      Navigator.of(
        context,
      ).pushNamedAndRemoveUntil(Routes.dashboardScreen, (route) => false);
      print(Storage.instance.getToken());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appColor,
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.whiteColor.withAlpha(13),
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(20.w),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(Assets.assetsImagesAppLogo),
              scale: 3.5,
            ),
          ),
        ),
      ),
    );
  }
}
