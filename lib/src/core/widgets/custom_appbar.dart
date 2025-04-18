import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/config/constants/assets.dart';
import 'package:yele/src/core/widgets/custom_image.dart';
import 'package:yele/src/core/widgets/custom_text.dart';
import 'package:yele/src/core/widgets/gap.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget? actionWidget;
  final Function()? onTap;
  final Function()? actionOnTap;
  final bool? isLeadingButton;
  final bool? isLeadingButtonWidget;
  final bool? isActionButton;
  final String? title;
  final String? actionIcon;
  final String? leadingIcon;
  // final double bottomPadding;
  final bool isUserShow;
  final Color? backgroundColor;

  const CustomAppBar({
    super.key,
    this.actionWidget,
    this.onTap,
    this.title = '',
    this.isLeadingButton = true,
    this.isActionButton = false,
    this.isLeadingButtonWidget = false,
    this.actionIcon,
    this.leadingIcon,
    this.actionOnTap,
    // this.bottomPadding = 0,
    this.isUserShow = true,
    this.backgroundColor,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(2.h);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: widget.backgroundColor ?? AppColors.appColor,
      elevation: 0.0,
      // toolbarHeight: 7.h,
      leadingWidth: 15.w,
      leading:
          widget.isLeadingButton == true
              ? GestureDetector(
                onTap: widget.onTap ?? () => Get.back(),
                child: Center(
                  child: Container(
                    color: Colors.transparent,
                    child: Padding(
                      padding: EdgeInsets.only(),
                      child:
                          widget.isLeadingButtonWidget == false
                              ? const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: AppColors.whiteColor,
                              )
                              : CustomAssetImage(
                                image: widget.leadingIcon!,
                                height: 8.w,
                                width: 8.w,
                              ),
                    ),
                  ),
                ),
              )
              : Container(),
      title: CustomText(
        textAlign: TextAlign.start,
        fontSize: 20.sp,
        color: AppColors.whiteColor,
        fontWeight: FontWeight.bold,
        text: widget.title.toString(),
      ),
      centerTitle: false,
      // centerTitle: true,
      actions:
          widget.isActionButton == true
              ? [
                widget.actionWidget ??
                    GestureDetector(
                      onTap: widget.actionOnTap,
                      child: Container(
                        color: Colors.transparent,
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: 5.w,
                            left: 5.w,
                            // top: 2.h,
                          ),
                          child: CustomAssetImage(
                            image: widget.actionIcon!,
                            height: 20,
                            width: 20,
                          ),
                        ),
                      ),
                    ),
              ]
              : [],
    );
  }
}

Widget customAppBar({String? title, bool isBack = true, Widget? actionWidget}) {
  return Padding(
    padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 6.h, bottom: 1.5.h),
    child: Row(
      children: [
        isBack
            ? Container(
              padding: EdgeInsets.all(10),
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: CustomAssetImage(
                  image: Assets.assetsIconsBackIcon,
                  height: 2.5.h,
                  width: 2.5.h,
                ),
              ),
            )
            : Container(),
        GapW(1.w),
        CustomText(
          text: title ?? '',
          color: AppColors.whiteColor,
          fontWeight: FontWeight.bold,
          fontSize: 18.5.sp,
        ),
        if (actionWidget != null) ...[Spacer(), actionWidget],
      ],
    ),
  );
}
