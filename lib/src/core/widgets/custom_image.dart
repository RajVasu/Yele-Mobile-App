import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/config/constants/assets.dart';
import 'package:yele/src/core/widgets/custom_text.dart';
import 'package:yele/src/core/widgets/gap.dart';

class CustomAssetImage extends StatelessWidget {
  final double? height;
  final double? width;
  final String image;
  final BoxFit? fit;
  final Key? imageKey;
  final Color? color;
  @override
  const CustomAssetImage({
    super.key,
    this.height,
    this.width,
    required this.image,
    this.fit,
    this.imageKey,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Image.asset(
        image,
        key: imageKey,
        fit: fit,
        color: color,
      ),
    );
  }
}

class CustomNetworkImage extends StatelessWidget {
  final double? height;
  final double? width;
  final String image;
  final BoxFit? fit;
  final Key? imageKey;
  final Color? color;
  const CustomNetworkImage({
    super.key,
    this.height,
    this.width,
    required this.image,
    this.fit,
    this.imageKey,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return image != null
        ? SizedBox(
            height: height,
            width: width,
            child: Image.network(
              image,
              key: imageKey,
              fit: fit,
              color: color,
            ),
          )
        : CustomNoImage();
  }
}

class CustomNoImage extends StatelessWidget {
  double? radius;
  CustomNoImage({super.key, this.radius});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: AppColors.appColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(radius ?? 10.sp),
          border: Border.all(
            color: AppColors.appColor,
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            Assets.assetsImagesNoImageHere,
            scale: 5,
          ),
          GapH(1.h),
          CustomText(
            text: 'No Image here',
            color: AppColors.appColor,
          )
        ],
      ),
    );
  }
}
