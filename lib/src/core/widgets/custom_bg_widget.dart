import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';

class CustomBgWidget extends StatefulWidget {
  Widget appBar;
  Widget body;
  EdgeInsetsGeometry? padding;
  CustomBgWidget({
    super.key,
    required this.appBar,
    required this.body,
    this.padding,
  });

  @override
  State<CustomBgWidget> createState() => _CustomBgWidgetState();
}

class _CustomBgWidgetState extends State<CustomBgWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appColor,
      body: Column(
        children: [
          widget.appBar,
          Expanded(
            child: Container(
              width: double.infinity,
              padding:
                  widget.padding ??
                  EdgeInsets.only(left: 6.w, right: 6.w, top: 1.h),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45),
                  topRight: Radius.circular(45),
                ),
              ),
              child: widget.body,
            ),
          ),
        ],
      ),
    );
  }
}
