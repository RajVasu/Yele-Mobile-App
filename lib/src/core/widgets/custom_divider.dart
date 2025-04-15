import 'package:flutter/material.dart';
import 'package:yele/src/config/constants/app_colors.dart';

class CustomDivider extends StatelessWidget {
  final double? endIntent;
  final double? intent;
  final double? thickness;
  final Color? color;
  const CustomDivider({
    super.key,
    this.endIntent,
    this.intent,
    this.thickness,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color ?? AppColors.dividerColor,
      thickness: thickness ?? 1.2,
      indent: intent,
      endIndent: endIntent,
    );
  }
}
