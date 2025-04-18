import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/core/screens/no_internet_screen.dart';
import 'package:yele/src/core/utils/enums.dart';
import 'package:yele/src/core/widgets/custom_button.dart';
import 'package:yele/src/core/widgets/custom_divider.dart';
import 'package:yele/src/core/widgets/custom_text.dart';
import 'package:yele/src/core/widgets/gap.dart';
import 'package:yele/src/features/user/filter/components/filter_checkbox_list_widget.dart';
import 'package:yele/src/features/user/filter/components/filter_header_widget.dart';
import 'package:yele/src/features/user/filter/controller/filter_controller.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    return NoInternetScreen(child: FilterView());
  }
}

class FilterView extends StatefulWidget {
  const FilterView({super.key});

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  FilterController controller = Get.find();
  dynamic type;
  @override
  void initState() {
    type = Get.arguments;
    if (controller.mainList.isEmpty) {
      controller.clearData();
      controller.getCarFilterData();
    } else {
      controller.checkDataList();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<FilterController>(
        init: FilterController(),
        builder: (context) {
          if (controller.formzStatus.value == FormzStatus.loading) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: AppColors.blackColor,
                ),
              ),
            );
          }
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Obx(
                () => Column(
                  children: [
                    GapH(6.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'Filter',
                          fontWeight: FontWeight.w700,
                          fontSize: 18.sp,
                        ),
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Icon(
                            Icons.close,
                            color: AppColors.greyColor,
                            size: 21.sp,
                          ),
                        ),
                      ],
                    ),
                    GapH(2.h),

                    //Make & Model
                    FilterHeaderWidget(
                      onTap:
                          () =>
                              controller.showMakeModelList.value =
                                  !controller.showMakeModelList.value,
                      isShown: controller.showMakeModelList.value,
                      label: 'Make & Model',
                    ),
                    FilterCheckboxListWidget(
                      filterListModel: controller.makeModelList,
                      isShown: controller.showMakeModelList,
                      lableName: 'model',
                    ),
                    GapH(1.h),
                    if (!controller.showMakeModelList.value) ...[
                      CustomDivider(),
                    ],
                    GapH(1.h),

                    //Brands
                    FilterHeaderWidget(
                      onTap:
                          () =>
                              controller.showBrandsList.value =
                                  !controller.showBrandsList.value,
                      isShown: controller.showBrandsList.value,
                      label: 'Brands',
                    ),
                    FilterCheckboxListWidget(
                      filterListModel: controller.brandsList,
                      isShown: controller.showBrandsList,
                      lableName: 'brand',
                    ),
                    GapH(1.h),
                    if (!controller.showBrandsList.value) ...[CustomDivider()],

                    GapH(1.h),

                    //Budget
                    FilterHeaderWidget(
                      onTap:
                          () =>
                              controller.showBudgetSlider.value =
                                  !controller.showBudgetSlider.value,
                      isShown: controller.showBudgetSlider.value,
                      label: 'Budget',
                    ),
                    Obx(() {
                      return controller.showBudgetSlider.value
                          ? Column(
                            children: [
                              Theme(
                                data: ThemeData(
                                  sliderTheme: SliderThemeData(
                                    thumbColor: AppColors.appColor,
                                    activeTrackColor: AppColors.appColor,
                                    inactiveTrackColor: AppColors.dividerColor,
                                    thumbShape: RoundSliderThumbShape(
                                      enabledThumbRadius: 1,
                                      disabledThumbRadius: 1,
                                    ),
                                    trackHeight: 2.0,
                                    showValueIndicator:
                                        ShowValueIndicator.never,
                                  ),
                                ),
                                child: RangeSlider(
                                  values: controller.budgetValues.value,
                                  min: controller.minPrice.value,
                                  max: controller.maxPrice.value,
                                  divisions:
                                      ((controller.maxPrice.value -
                                                  controller.minPrice.value) /
                                              1000)
                                          .round(),

                                  labels: RangeLabels(
                                    '\$${controller.budgetValues.value.start.round()}',
                                    '\$${controller.budgetValues.value.end.round()}',
                                  ),
                                  onChanged: (RangeValues values) {
                                    controller.budgetValues.value = values;
                                    print(controller.budgetValues.value);
                                  },
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text:
                                        '\$${controller.budgetValues.value.start.round()}',
                                    fontSize: 15.5.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.darkGreyColor,
                                  ),
                                  CustomText(
                                    text:
                                        '\$${controller.budgetValues.value.end.round()}',
                                    fontSize: 15.5.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.darkGreyColor,
                                  ),
                                ],
                              ),
                            ],
                          )
                          : SizedBox.shrink();
                    }),

                    GapH(1.h),
                    CustomDivider(),
                    GapH(1.h),

                    //Fuel
                    FilterHeaderWidget(
                      onTap:
                          () =>
                              controller.showFuelFilters.value =
                                  !controller.showFuelFilters.value,
                      isShown: controller.showFuelFilters.value,
                      label: 'Fuel',
                    ),
                    FilterCheckboxListWidget(
                      filterListModel: controller.fuelFilters,
                      isShown: controller.showFuelFilters,
                      lableName: 'fuel_type',
                    ),

                    GapH(1.h),
                    CustomDivider(),
                    GapH(1.h),

                    //Model Year
                    FilterHeaderWidget(
                      onTap:
                          () =>
                              controller.showModelYearFilters.value =
                                  !controller.showModelYearFilters.value,
                      isShown: controller.showModelYearFilters.value,
                      label: 'Model Year',
                    ),
                    FilterCheckboxListWidget(
                      filterListModel: controller.modelYearFilters,
                      isShown: controller.showModelYearFilters,
                      lableName: 'model_year',
                    ),

                    GapH(1.h),
                    CustomDivider(),
                    GapH(1.h),

                    //RTO
                    FilterHeaderWidget(
                      onTap:
                          () =>
                              controller.showRtoFilters.value =
                                  !controller.showRtoFilters.value,
                      isShown: controller.showRtoFilters.value,
                      label: 'RTO',
                    ),
                    FilterCheckboxListWidget(
                      filterListModel: controller.rtoFilters,
                      isShown: controller.showRtoFilters,
                      lableName: 'rto',
                    ),

                    GapH(1.h),
                    CustomDivider(),
                    GapH(1.h),

                    //Body Type
                    FilterHeaderWidget(
                      onTap:
                          () =>
                              controller.showBodyTypeFilters.value =
                                  !controller.showBodyTypeFilters.value,
                      isShown: controller.showBodyTypeFilters.value,
                      label: 'Body Type',
                    ),
                    FilterCheckboxListWidget(
                      filterListModel: controller.bodyTypeFilters,
                      isShown: controller.showBodyTypeFilters,
                      lableName: 'body_type',
                    ),

                    GapH(1.h),
                    CustomDivider(),
                    GapH(1.h),

                    //Transmission
                    FilterHeaderWidget(
                      onTap:
                          () =>
                              controller.showTransmissionFilters.value =
                                  !controller.showTransmissionFilters.value,
                      isShown: controller.showTransmissionFilters.value,
                      label: 'Transmission',
                    ),
                    FilterCheckboxListWidget(
                      filterListModel: controller.transmissionFilters,
                      lableName: 'transmission',
                      isShown: controller.showTransmissionFilters,
                    ),

                    GapH(1.h),
                    CustomDivider(),
                    GapH(1.h),

                    //Owners
                    FilterHeaderWidget(
                      onTap:
                          () =>
                              controller.showOwnerFilters.value =
                                  !controller.showOwnerFilters.value,
                      isShown: controller.showOwnerFilters.value,
                      label: 'Owners',
                    ),
                    FilterCheckboxListWidget(
                      filterListModel: controller.ownerFilters,
                      isShown: controller.showOwnerFilters,
                      lableName: 'owners',
                    ),

                    GapH(1.h),
                    CustomDivider(),
                    GapH(1.h),

                    //Seats
                    FilterHeaderWidget(
                      onTap:
                          () =>
                              controller.showSeatFilters.value =
                                  !controller.showSeatFilters.value,
                      isShown: controller.showSeatFilters.value,
                      label: 'Seats',
                    ),
                    FilterCheckboxListWidget(
                      filterListModel: controller.seatFilters,
                      lableName: 'seats',
                      isShown: controller.showSeatFilters,
                    ),

                    GapH(1.h),
                    CustomDivider(),
                    GapH(1.h),

                    //KMs Driven
                    FilterHeaderWidget(
                      onTap:
                          () =>
                              controller.showKmDrivenFilters.value =
                                  !controller.showKmDrivenFilters.value,
                      isShown: controller.showKmDrivenFilters.value,
                      label: 'KMs Driven',
                    ),
                    FilterCheckboxListWidget(
                      filterListModel: controller.kmDrivenFilters,
                      isShown: controller.showKmDrivenFilters,
                      lableName: 'kms_driven',
                    ),

                    GapH(1.h),
                    CustomDivider(),
                    GapH(1.h),

                    //Color
                    FilterHeaderWidget(
                      onTap:
                          () =>
                              controller.showColorFilters.value =
                                  !controller.showColorFilters.value,
                      isShown: controller.showColorFilters.value,
                      label: 'Color',
                    ),
                    FilterCheckboxListWidget(
                      filterListModel: controller.colorFilters,
                      lableName: 'color',
                      isShown: controller.showColorFilters,
                    ),
                    GapH(5.h),

                    CustomButton(
                      text: 'Apply',
                      onTap: () {
                        controller.addMianData(type: type);
                      },
                    ),

                    GapH(5.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
