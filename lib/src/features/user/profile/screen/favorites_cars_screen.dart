import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/api/endpoints.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/config/constants/assets.dart';
import 'package:yele/src/config/router/routes.dart';
import 'package:yele/src/core/database/storage.dart';
import 'package:yele/src/core/widgets/custom_appbar.dart';
import 'package:yele/src/core/widgets/custom_bg_widget.dart';
import 'package:yele/src/core/widgets/custom_button.dart';
import 'package:yele/src/core/widgets/custom_divider.dart';
import 'package:yele/src/core/widgets/custom_image.dart';
import 'package:yele/src/core/widgets/custom_text.dart';
import 'package:yele/src/core/widgets/custom_text_field.dart';
import 'package:yele/src/core/widgets/gap.dart';
import 'package:yele/src/features/user/car/model/get_car_list_model.dart';
import 'package:yele/src/features/user/profile/controller/favorite_cars_controller.dart';

class FavoriteCarsScreen extends StatefulWidget {
  const FavoriteCarsScreen({super.key});

  @override
  State<FavoriteCarsScreen> createState() => _FavoriteCarsScreenState();
}

class _FavoriteCarsScreenState extends State<FavoriteCarsScreen> {
  final FavoriteCarsController _favoriteCarsController = Get.find();
  bool listEmpty = false;
  @override
  void initState() {
    super.initState();
    _favoriteCarsController.getFavoriteCarListData();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBgWidget(
      appBar: customAppBar(title: 'Favorite Cars'),
      body: LazyLoadScrollView(
        onEndOfPage: () {
          if (_favoriteCarsController.currentPageIndex.value <
              _favoriteCarsController.getFavoriteCarData.value.totalPages!) {
            _favoriteCarsController.paginationselected.value = true;
            _favoriteCarsController.getFavoriteCarListDataPagination();
            setState(() {
              Timer(const Duration(seconds: 5), () {
                setState(() {
                  _favoriteCarsController.paginationselected.value = false;
                });
              });
            });
          }
        },
        child: GetBuilder<FavoriteCarsController>(
          init: FavoriteCarsController(),
          builder: (context) {
            return _favoriteCarsController.favoriteCarList.isNotEmpty
                ? ListView.separated(
                  itemCount: _favoriteCarsController.favoriteCarList.length,
                  padding: EdgeInsets.only(top: 1.h, bottom: 3.h),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    CarListData carData =
                        _favoriteCarsController.favoriteCarList[index];
                    return GestureDetector(
                      onTap: () async {
                        await Get.toNamed(
                          Routes.carDetailScreen,
                          arguments: carData.carId,
                        );
                        await _favoriteCarsController.getFavoriteCarListData();
                      },
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(15.sp),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 7.0,
                                  spreadRadius: 2.0,
                                  color: AppColors.greyColor.withOpacity(0.3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: carData.carName!,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        GapH(0.5.h),
                                        CustomText(
                                          text:
                                              '${carData.carType} - ${carData.carTransmission}',
                                          fontSize: 15.sp,
                                          color: AppColors.darkGreyColor,
                                        ),
                                      ],
                                    ),

                                    GestureDetector(
                                      onTap: () {
                                        _favoriteCarsController
                                            .removeFavoriteCar(
                                              carId: carData.carId,
                                            );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: AppColors.dividerColor,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.favorite,
                                          color: AppColors.appColor,
                                          size: 20.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                GapH(1.5.h),
                                carData.carImage != null
                                    ? ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                        10.sp,
                                      ),
                                      child: CustomNetworkImage(
                                        height: 22.h,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        image:
                                            '${Endpoints.baseUrl}${carData.carImage}',
                                      ),
                                    )
                                    : CustomNoImage(height: 22.h),
                                GapH(1.h),
                                CustomText(
                                  text: '1.2 Smart Plus',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17.5.sp,
                                ),
                                GapH(0.3.h),
                                CustomText(
                                  text:
                                      '${carData.carFuelType} - ${carData.carTransmission}',
                                  fontSize: 15.sp,
                                  color: AppColors.darkGreyColor,
                                ),
                                GapH(1.5.h),
                                CustomText(
                                  text: '${carData.price}',
                                  fontWeight: FontWeight.w700,
                                ),
                                GapH(1.5.h),
                                CustomButton(
                                  text: 'Request More Info',
                                  fontSize: 15.sp,
                                  borderColor: AppColors.appColor,
                                  buttonColor: Colors.transparent,
                                  textColor: AppColors.appColor,
                                  borderWidth: 1,
                                  onTap: () {
                                    if (Storage.instance.getToken() != null) {
                                      requestInfoDialog();
                                    } else {
                                      Get.toNamed(Routes.loginScreen);
                                    }
                                  },
                                ),
                                GapH(1.h),
                                CustomButton(
                                  text: 'Schedule a Test Drive',
                                  fontSize: 15.sp,
                                  onTap:
                                      () => Get.toNamed(
                                        Routes.bookTestDriveScreen,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          if (index ==
                                  _favoriteCarsController
                                          .favoriteCarList
                                          .length -
                                      1 &&
                              _favoriteCarsController
                                  .paginationselected
                                  .value) ...[
                            Padding(
                              padding: EdgeInsets.all(20.sp),
                              child: LoadingAnimationWidget.threeArchedCircle(
                                color: AppColors.appColor,
                                size: 30,
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => GapH(3.h),
                )
                : emptyListWidget();
          },
        ),
      ),
    );
  }

  Widget emptyListWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomAssetImage(image: Assets.assetsImagesFavCars, width: 18.h),
          GapH(2.h),
          CustomText(
            fontWeight: FontWeight.w700,
            textAlign: TextAlign.center,
            fontSize: 18.sp,
            text: 'No Favorite Cars',
          ),
          GapH(0.3.h),
          CustomText(
            textAlign: TextAlign.center,
            color: AppColors.darkGreyColor,
            fontSize: 15.sp,
            text:
                'Empty favorites. Browse around and add items to your favorites list!',
          ),
        ],
      ),
    );
  }

  void saveInquiryDialog() {
    Get.dialog(
      barrierDismissible: false,
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 10.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: CustomText(
                      text:
                          'Thank you for your inquiry. You will receive a text or call from the dealer shortly.',
                      textAlign: TextAlign.center,
                      fontSize: 14.sp,
                      color: AppColors.darkGreyColor,
                    ),
                  ),
                  GapH(2.5.h),
                  CustomAssetImage(image: Assets.assetsImagesCarOnRoad),
                  GapH(3.5.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: CustomButton(
                      padding: EdgeInsets.symmetric(vertical: 0.8.h),
                      text: 'Continue',
                      borderRadius: BorderRadius.circular(3),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      onTap: () => Get.back(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void requestInfoDialog() {
    Get.dialog(
      barrierDismissible: false,
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 5.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 1.8.h),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: SizedBox(
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Center(
                            child: CustomText(
                              text: 'Request More Information',
                              fontWeight: FontWeight.w700,
                              fontSize: 17.sp,
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: GestureDetector(
                              onTap: () => Get.back(),
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.dividerColor,
                                  border: Border.all(
                                    color: AppColors.offWhiteColor,
                                    width: 1,
                                  ),
                                ),
                                child: CustomAssetImage(
                                  image: Assets.assetsImagesCross,
                                  color: AppColors.blackColor,
                                  height: 0.9.h,
                                  width: 0.9.h,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GapH(1.h),
                  CustomDivider(),
                  GapH(0.5.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: CustomText(text: 'Hello, my name is'),
                              ),
                              Expanded(
                                child: CustomTextfield(
                                  controller:
                                      _favoriteCarsController
                                          .firstNameController,
                                  hintText: 'First Name',
                                ),
                              ),
                            ],
                          ),
                          GapH(0.5.h),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextfield(
                                  controller:
                                      _favoriteCarsController
                                          .lastNameController,
                                  hintText: 'Last Name',
                                ),
                              ),
                              GapW(3.w),
                              Expanded(child: CustomText(text: 'and')),
                            ],
                          ),
                          GapH(1.5.h),
                          CustomText(
                            text: '2020 Jeep Wrangler Rubicon . 4WD.',
                            fontWeight: FontWeight.w700,
                          ),
                          GapH(1.5.h),
                          Row(
                            children: [
                              Flexible(
                                fit: FlexFit.loose,
                                child: CustomText(text: 'In the'),
                              ),
                              GapW(3.w),
                              Flexible(
                                flex: 3,
                                fit: FlexFit.loose,
                                child: CustomTextfield(
                                  controller:
                                      _favoriteCarsController
                                          .contactNoController,
                                  hintText: '77084 77084',
                                ),
                              ),
                              GapW(3.w),
                              Flexible(
                                fit: FlexFit.loose,
                                child: CustomText(text: 'area.'),
                              ),
                            ],
                          ),
                          GapH(1.h),
                          CustomText(text: 'You can reach me by email at'),
                          GapH(1.2.h),
                          CustomTextfield(
                            controller: _favoriteCarsController.emailController,
                            hintText: 'Email Address',
                          ),
                          GapH(1.2.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                fit: FlexFit.loose,
                                child: CustomText(text: 'or by Zip code'),
                              ),
                              Flexible(
                                fit: FlexFit.loose,
                                child: CustomTextfield(
                                  controller:
                                      _favoriteCarsController.zipCodeController,
                                  hintText: '183251',
                                ),
                              ),
                              Flexible(
                                fit: FlexFit.loose,
                                child: CustomText(text: 'Thank you!'),
                              ),
                            ],
                          ),
                          GapH(2.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Transform.scale(
                                scale: 1.2,
                                child: Checkbox(
                                  activeColor: AppColors.appColor,
                                  visualDensity: VisualDensity.compact,
                                  side: BorderSide(
                                    width: 1.3,
                                    color: AppColors.greyColor,
                                  ),
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  fillColor: WidgetStateProperty.resolveWith((
                                    states,
                                  ) {
                                    if (!states.contains(
                                      WidgetState.selected,
                                    )) {
                                      return Colors.white;
                                    }
                                    return null;
                                  }),
                                  shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  value:
                                      _favoriteCarsController
                                          .agreeRequestInfo
                                          .value,
                                  onChanged:
                                      (value) =>
                                          _favoriteCarsController
                                              .agreeRequestInfo
                                              .value = !_favoriteCarsController
                                                  .agreeRequestInfo
                                                  .value,
                                ),
                              ),
                              GapW(1.2.w),
                              Expanded(
                                child: CustomText(
                                  fontSize: 14.sp,
                                  height: 1.5,
                                  color: AppColors.darkGreyColor,
                                  text:
                                      'I agree to receive text messages from YELE and calls from the dealership',
                                ),
                              ),
                            ],
                          ),
                          GapH(2.h),
                          Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                  onTap: () => Get.back(),
                                  text: 'Cancel',
                                  borderColor: AppColors.appColor,
                                  buttonColor: AppColors.whiteColor,
                                  textColor: AppColors.appColor,
                                  borderWidth: 1.2,
                                  borderRadius: BorderRadius.circular(10),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 1.2.h,
                                  ),
                                ),
                              ),
                              GapW(3.w),
                              Expanded(
                                child: CustomButton(
                                  onTap: () {
                                    Get.back();
                                    saveInquiryDialog();
                                  },
                                  text: 'Save',
                                  borderRadius: BorderRadius.circular(10),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 1.2.h,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
