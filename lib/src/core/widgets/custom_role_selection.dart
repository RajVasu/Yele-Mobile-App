import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/config/constants/app_strings.dart';
import 'package:yele/src/config/constants/assets.dart';
import 'package:yele/src/core/utils/enums.dart';
import 'package:yele/src/core/widgets/custom_image.dart';
import 'package:yele/src/core/widgets/custom_text.dart';
import 'package:yele/src/core/widgets/gap.dart';
import 'package:yele/src/features/auth/register/controller/register_controller.dart';

class CustomRoleSelection extends StatefulWidget {
  const CustomRoleSelection({super.key});

  @override
  State<CustomRoleSelection> createState() => _CustomRoleSelectionState();
}

class _CustomRoleSelectionState extends State<CustomRoleSelection> {
  RegisterController registerController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        CustomText(
          text: AppStrings.selectYourRole,
          fontWeight: FontWeight.w600,
          fontSize: 15.4.sp,
        ),
        GapH(0.5.h),

        Obx(() {
          return DropdownButtonHideUnderline(
            child: DropdownButton2<UserRole>(
              iconStyleData: IconStyleData(
                icon: CustomAssetImage(
                  image: Assets.assetsIconsDropdown,
                  width: 1.5.h,
                  height: 1.5.h,
                ),
              ),

              isExpanded: true,
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),

              buttonStyleData: ButtonStyleData(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.borderColor, width: 1.3),
                ),
              ),
              value: registerController.userRole.value,
              onChanged: (newValue) {
                if (registerController.userRole.value != newValue) {
                  registerController.userRole.value = newValue!;
                }
              },
              items:
                  registerController.rolesList.map<DropdownMenuItem<UserRole>>((
                    String value,
                  ) {
                    return DropdownMenuItem<UserRole>(
                      value: UserRole.values.firstWhere(
                        (e) => e.toString().split('.').last == value,
                      ),
                      child: CustomText(text: value.capitalize!),
                    );
                  }).toList(),
            ),
          );
        }),
        GapH(1.5.h),
      ],
    );
  }
}
