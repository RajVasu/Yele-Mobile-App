import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/config/constants/assets.dart';
import 'package:yele/src/core/widgets/custom_image.dart';
import 'package:yele/src/core/widgets/custom_text.dart';
import 'package:yele/src/core/widgets/gap.dart';
import 'package:yele/src/features/user/car/controller/car_controller.dart';

class CarDetailViewWidget extends StatefulWidget {
  const CarDetailViewWidget({super.key});

  @override
  State<CarDetailViewWidget> createState() => _CarDetailViewWidgetState();
}

class _CarDetailViewWidgetState extends State<CarDetailViewWidget> {
  final CarController _carController = Get.find();
  @override
  Widget build(BuildContext context) {
    List tempList = [
      {
        'name': '${_carController.getCarData.value.kmDriven} KM',
        'icon': Assets.assetsIconsDistance,
      },
      {
        'name': _carController.getCarData.value.fuelType,
        'icon': Assets.assetsIconsPetrol,
      },
      {
        'name': _carController.getCarData.value.transmission,
        'icon': Assets.assetsIconsManual,
      },
      {
        'name': _carController.getCarData.value.owners,
        'icon': Assets.assetsIconsOwner,
      },
    ];
    return Padding(
      padding: EdgeInsets.all(18.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GapH(1.h),
          CustomText(
            text: _carController.getCarData.value.carName!,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
          GapH(1.h),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: _carController.getCarData.value.carPrice!,
                    color: AppColors.appColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  CustomText(text: 'EMI \$500.00 / month'),
                ],
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.yellowColor),
                  borderRadius: BorderRadius.circular(15.sp),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star, color: AppColors.yellowColor),
                        Icon(Icons.star, color: AppColors.yellowColor),
                        Icon(Icons.star, color: AppColors.yellowColor),
                        Icon(Icons.star, color: AppColors.yellowColor),
                      ],
                    ),
                    CustomText(
                      text: '32 Ratings',
                      color: AppColors.darkGreyColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(color: AppColors.dividerColor, height: 5.h, thickness: 1.5),
          Row(
            children: [
              CustomText(text: 'Color', fontWeight: FontWeight.w700),
              Spacer(),
              CustomText(
                text: _carController.getCarData.value.color!,
                color: AppColors.darkGreyColor,
              ),
            ],
          ),
          GapH(2.h),

          Container(
            padding: EdgeInsets.all(10.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.sp),
              gradient: LinearGradient(
                colors: [
                  AppColors.gradient.colors[0].withOpacity(0.3),
                  AppColors.gradient.colors[1].withOpacity(0.3),
                ],
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10.sp),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppColors.gradient,
                  ),
                  child: CustomAssetImage(
                    image: Assets.assetsIconsDoller,
                    height: 1.5.h,
                    width: 1.5.h,
                  ),
                ),
                GapW(1.w),
                CustomText(
                  text: 'GREAT PRICE according to our Price Indicator.',
                  fontWeight: FontWeight.w600,
                  fontSize: 15.sp,
                ),
                GapW(1.w),
              ],
            ),
          ),
          GapH(3.h),
          SizedBox(
            height: 7.h,
            child: ListView.separated(
              itemCount: tempList.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return SpecificationItem(
                  icon: tempList[index]['icon'],
                  label: '${tempList[index]['name']}',
                );
              },
              separatorBuilder:
                  (context, index) => Container(
                    width: 1,
                    height: 8.h,
                    color: AppColors.dividerColor,
                    margin: EdgeInsets.symmetric(
                      vertical: 0.5.h,
                      horizontal: 3.w,
                    ),
                  ),
            ),
          ),
          Divider(color: AppColors.dividerColor, height: 0.5.h, thickness: 1),
          GapH(3.h),
          CustomText(
            text: 'Specifications',
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
          GapH(1.h),
          CustomText(
            text: _carController.getCarData.value.specification!,
            fontSize: 15.sp,
            fontWeight: FontWeight.normal,
            color: AppColors.darkGreyColor,
          ),
        ],
      ),
    );
  }
}

class SpecificationItem extends StatelessWidget {
  final String icon;
  final String label;

  const SpecificationItem({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 18.w,
      child: Column(
        children: [
          CustomAssetImage(
            image: icon,
            height: 28,
            width: 28,
            color: AppColors.darkGreyColor,
          ),
          const SizedBox(height: 8),
          CustomText(
            text: label,
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: AppColors.darkGreyColor,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
