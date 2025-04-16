import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/assets.dart';
import 'package:yele/src/config/router/routes.dart';
import 'package:yele/src/core/widgets/custom_appbar.dart';
import 'package:yele/src/core/widgets/custom_bg_widget.dart';
import 'package:yele/src/core/widgets/custom_image.dart';
import 'package:yele/src/core/widgets/custom_text.dart';
import 'package:yele/src/core/widgets/gap.dart';

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({super.key});

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
    Timer? _timer;
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    _timer = Timer(const Duration(seconds: 3), () {
      Get.offNamed(Routes.driverProgressScreen);
    });
  }
    @override
  void dispose() {
    // Cancel the timer if the screen is disposed
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBgWidget(
      appBar: customAppBar(title: 'Confirmation'),

      body: Column(
        children: [
          GapH(18.h),
          CustomAssetImage(image: Assets.assetsImagesConfirmation, width: 30.h),
          GapH(2.h),
          CustomText(
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w600,
            text:
                'Your Appointment has been confirmed. Please keep app open for Driver’s arrival notifications!',
          ),
        ],
      ),
    );
  }
}
