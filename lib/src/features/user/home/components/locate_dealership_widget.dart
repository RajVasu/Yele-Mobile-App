import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/config/constants/assets.dart';
import 'package:yele/src/core/widgets/custom_dropdown_button.dart';
import 'package:yele/src/core/widgets/custom_image.dart';
import 'package:yele/src/core/widgets/custom_text.dart';
import 'package:yele/src/core/widgets/custom_text_field.dart';
import 'package:yele/src/core/widgets/gap.dart';

class LocateDealershipWidget extends StatefulWidget {
  const LocateDealershipWidget({super.key});

  @override
  State<LocateDealershipWidget> createState() => _LocateDealershipWidgetState();
}

class _LocateDealershipWidgetState extends State<LocateDealershipWidget> {
  final List<String> brandList = [
    'Mercedes-Benz',
    'BMW',
    'Audi',
    'Toyota',
    'Jaguar',
  ];
  final List<String> modelList = ['C-Class', '3 Series', 'A4', 'Camry', 'XE'];
  final List<String> yearsList = ['2020', '2021', '2022', '2023', '2024'];
  final List<String> priceList = [
    '50,000',
    '55,000',
    '60,000',
    '65,000',
    "70,000",
  ];
  final List<String> milageList = [
    '30 MPG',
    '28 MPG',
    '27 MPG',
    '34 MPG',
    '25 MPG',
  ];

  String? selectedBrandValue;
  String? selectedModelValue;
  String? selectedYearValue;
  String? selectedPriceValue;
  String? selectedMilageValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
          colors: AppColors.gradient.colors,
        ),
      ),
      child: Column(
        children: [
          CustomText(
            text: "Locate A Dealership Near Me",
            color: AppColors.whiteColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
          GapH(3.h),
          CustomDropdownButton(
            dropdownPadding: EdgeInsets.all(15.sp),
            buttonDecoration: BoxDecoration(
              border: Border.all(color: AppColors.whiteColor, width: 0.7),
              borderRadius: BorderRadius.circular(10.sp),
            ),
            hint: 'Select Brand',
            value: selectedBrandValue,
            dropdownItems: brandList,
            bgColor: Colors.blue.shade300,
            onChanged: (value) {
              setState(() {});
              selectedBrandValue = value;
            },
          ),
          GapH(1.5.h),
          CustomDropdownButton(
            buttonDecoration: BoxDecoration(
              border: Border.all(color: AppColors.whiteColor, width: 0.7),
              borderRadius: BorderRadius.circular(10.sp),
            ),
            bgColor: Colors.blue.shade300,
            hint: 'Select Model',
            value: selectedModelValue,
            dropdownItems: modelList,

            onChanged: (value) {
              setState(() {});
              selectedModelValue = value;
            },
          ),
          GapH(1.5.h),
          CustomDropdownButton(
            buttonDecoration: BoxDecoration(
              border: Border.all(color: AppColors.whiteColor, width: 0.7),
              borderRadius: BorderRadius.circular(10.sp),
            ),
            bgColor: Colors.blue.shade300,
            hint: 'Make Year',
            value: selectedYearValue,
            dropdownItems: yearsList,

            onChanged: (value) {
              setState(() {});
              selectedYearValue = value;
            },
          ),

          GapH(1.5.h),
          CustomDropdownButton(
            buttonDecoration: BoxDecoration(
              border: Border.all(color: AppColors.whiteColor, width: 0.7),
              borderRadius: BorderRadius.circular(10.sp),
            ),
            bgColor: Colors.blue.shade300,
            hint: 'Select Max Milage',
            value: selectedMilageValue,
            dropdownItems: milageList,

            onChanged: (value) {
              setState(() {});
              selectedMilageValue = value;
            },
          ),
          GapH(1.5.h),
          CustomDropdownButton(
            buttonDecoration: BoxDecoration(
              border: Border.all(color: AppColors.whiteColor, width: 0.7),
              borderRadius: BorderRadius.circular(10.sp),
            ),
            bgColor: Colors.blue.shade300,
            hint: 'Select Max Price',
            value: selectedPriceValue,
            dropdownItems: priceList,

            onChanged: (value) {
              setState(() {});
              selectedPriceValue = value;
            },
          ),
          GapH(1.5.h),
          CustomTextfield(
            height: 40,
            hintText: 'Enter Zip Code',
            bgColorColor: Colors.transparent,
            hintTextColor: AppColors.whiteColor.withOpacity(0.8),
            borderColor: AppColors.whiteColor.withOpacity(0.8),
            borderRadius: BorderRadius.circular(10.sp),
            cursorColor: AppColors.whiteColor,
            textColor: AppColors.whiteColor,
            textInputAction: TextInputAction.done,
          ),
          GapH(1.5.h),
          Container(
            padding: EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(10.sp),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomAssetImage(
                  image: Assets.assetsIconsSearchLocate,
                  height: 2.h,
                  width: 2.h,
                  color: AppColors.appColor,
                ),
                GapW(2.w),
                CustomText(
                  text: "Search",
                  color: AppColors.appColor,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
