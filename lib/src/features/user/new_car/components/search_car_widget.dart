import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/config/constants/assets.dart';
import 'package:yele/src/config/router/routes.dart';
import 'package:yele/src/core/widgets/custom_image.dart';
import 'package:yele/src/core/widgets/custom_text.dart';
import 'package:yele/src/core/widgets/custom_text_field.dart';
import 'package:yele/src/core/widgets/gap.dart';
import 'package:yele/src/features/user/filter/controller/filter_controller.dart';
import 'package:yele/src/features/user/new_car/controller/new_car_controller.dart';
import 'package:yele/src/features/user/used_car/controller/used_car_controller.dart';

class SearchCarWidget extends StatefulWidget {
  String type;
  SearchCarWidget({super.key, required this.type});

  @override
  State<SearchCarWidget> createState() => _SearchCarWidgetState();
}

class _SearchCarWidgetState extends State<SearchCarWidget> {
  final FilterController _filterController = Get.find();
  final NewCarController _newCarController = Get.find();
  final UsedCarController _usedCarController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: CustomTextfield(
                prefixIcon: Assets.assetsIconsSearchCar,
                hintText: 'Search cars...',
                readOnly: true,
                prefixIconColor: AppColors.darkGreyColor,
                borderRadius: BorderRadius.circular(30.sp),
              ),
            ),
            GapW(2.w),
            GestureDetector(
              onTap:
                  () =>
                      Get.toNamed(Routes.filterScreen, arguments: widget.type),
              child: Container(
                height: 5.5.h,
                width: 5.5.h,
                padding: EdgeInsets.all(15.sp),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.borderColor, width: 1.4),
                ),
                child: CustomAssetImage(image: Assets.assetsIconsFilter),
              ),
            ),
          ],
        ),

        // UI
        Obx(() {
          // This will react to changes in the searchingList automatically
          return _filterController.mainList.isNotEmpty
              ? Column(
                children: [
                  GapH(1.5.h),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _filterController.mainList.clear(); // Clear the list
                          if (widget.type == 'Used Car') {
                            _usedCarController.getUsedCarListData();
                          } else {
                            _newCarController.getNewCarListData();
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 3.w,
                            vertical: 0.5.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.appColor,
                            borderRadius: BorderRadius.circular(10.sp),
                          ),
                          child: CustomText(
                            text: 'Clear All',
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                      GapW(1.5.w),
                      Expanded(
                        child: SizedBox(
                          height: 3.5.h,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              return Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 3.w),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE6E6E6),
                                  borderRadius: BorderRadius.circular(10.sp),
                                ),
                                child: Row(
                                  children: [
                                    CustomText(
                                      text: _filterController.mainList[index],
                                      color: AppColors.darkGreyColor,
                                    ),
                                    GapW(4.w),
                                    GestureDetector(
                                      onTap: () {
                                        _filterController.removeMainData(
                                          data:
                                              _filterController.mainList[index],
                                        );
                                      },
                                      child: Icon(
                                        Icons.close,
                                        color: AppColors.darkGreyColor,
                                        size: 18.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => GapW(1.5.w),
                            itemCount: _filterController.mainList.length,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
              : SizedBox.shrink(); // Return an empty widget if the list is empty
        }),
        // if (_filterController.serchingList.isNotEmpty) ...[
        //   GapH(1.5.h),
        //   GetBuilder<FilterController>(
        //     init: FilterController(),
        //     builder: (context) {
        //       return Row(
        //         children: [
        //           GestureDetector(
        //             onTap: () {
        //               _filterController.serchingList.clear();
        //             },
        //             child: Container(
        //               padding: EdgeInsets.symmetric(
        //                 horizontal: 3.w,
        //                 vertical: 0.5.h,
        //               ),
        //               decoration: BoxDecoration(
        //                 color: AppColors.appColor,
        //                 borderRadius: BorderRadius.circular(10.sp),
        //               ),
        //               child: CustomText(
        //                 text: 'Clear All',
        //                 color: AppColors.whiteColor,
        //               ),
        //             ),
        //           ),
        //           GapW(1.5.w),
        //           Expanded(
        //             child: SizedBox(
        //               // color: AppColors.appColor,
        //               height: 3.5.h,

        //               child: ListView.separated(
        //                 scrollDirection: Axis.horizontal,
        //                 shrinkWrap: true,
        //                 padding: EdgeInsets.zero,
        //                 itemBuilder: (context, index) {
        //                   return Container(
        //                     alignment: Alignment.center,
        //                     padding: EdgeInsets.symmetric(
        //                       horizontal: 3.w,
        //                       // vertical: 0.5.h,
        //                     ),

        //                     decoration: BoxDecoration(
        //                       color: const Color(0xFFE6E6E6),
        //                       borderRadius: BorderRadius.circular(10.sp),
        //                     ),
        //                     child: Row(
        //                       children: [
        //                         CustomText(
        //                           text: _filterController.serchingList[index],
        //                           color: AppColors.darkGreyColor,
        //                         ),
        //                         GapW(4.w),
        //                         GestureDetector(
        //                           onTap: () {
        //                             _filterController.removeSearchData(
        //                               data:
        //                                   _filterController.serchingList[index],
        //                             );
        //                           },
        //                           child: Icon(
        //                             Icons.close,
        //                             color: AppColors.darkGreyColor,
        //                             size: 18.sp,
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                   );
        //                 },
        //                 separatorBuilder: (context, index) => GapW(1.5.w),
        //                 itemCount: _filterController.serchingList.length,
        //               ),
        //             ),
        //           ),
        //         ],
        //       );
        //     },
        //   ),
        // ],
      ],
    );
  }
}
