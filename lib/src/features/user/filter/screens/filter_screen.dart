import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/config/constants/assets.dart';
import 'package:yele/src/core/widgets/custom_button.dart';
import 'package:yele/src/core/widgets/custom_divider.dart';
import 'package:yele/src/core/widgets/custom_image.dart';
import 'package:yele/src/core/widgets/custom_text.dart';
import 'package:yele/src/core/widgets/gap.dart';
import 'package:yele/src/features/user/filter/controller/filter_controller.dart';

class FilterListModel {
  final String title;
  RxBool clicked;

  FilterListModel({required this.title, required this.clicked});
}

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  FilterController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                headerWidget(
                  onTap: () => controller.showMakeModelList.value =
                      !controller.showMakeModelList.value,
                  isShown: controller.showMakeModelList.value,
                  label: 'Make & Model',
                ),
                checkboxListWidget(
                  filterListModel: controller.makeModelList,
                  isShown: controller.showMakeModelList,
                ),
                GapH(1.h),
                if (!controller.showMakeModelList.value) ...[CustomDivider()],
                GapH(1.h),

                //Brands
                headerWidget(
                  onTap: () => controller.showBrandsList.value =
                      !controller.showBrandsList.value,
                  isShown: controller.showBrandsList.value,
                  label: 'Brands',
                ),
                checkboxListWidget(
                  filterListModel: controller.brandsList,
                  isShown: controller.showBrandsList,
                ),
                GapH(1.h),
                if (!controller.showBrandsList.value) ...[CustomDivider()],

                GapH(1.h),

                //Budget
                headerWidget(
                  onTap: () => controller.showBudgetSlider.value =
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
                                  showValueIndicator: ShowValueIndicator.never,
                                ),
                              ),
                              child: RangeSlider(
                                values: controller.budgetValues,
                                min: 100000,
                                max: 350000,
                                divisions: 5,
                                labels: RangeLabels(
                                  '\$${controller.budgetValues.start.round()}',
                                  '\$${controller.budgetValues.end.round()}',
                                ),
                                onChanged: (RangeValues values) {
                                  if (values.start >= 100000 &&
                                      values.start <= 350000 &&
                                      values.end >= 100000 &&
                                      values.end <= 350000) {
                                    setState(() {
                                      controller.budgetValues = values;
                                    });
                                  }
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text:
                                      '\$${controller.budgetValues.start.round()}',
                                  fontSize: 15.5.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.darkGreyColor,
                                ),
                                CustomText(
                                  text:
                                      '\$${controller.budgetValues.end.round()}',
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

                /*   Obx(() {
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
                                  enabledThumbRadius: 8.5.sp,
                                  disabledThumbRadius: 8.5.sp,
                                  elevation: 10,
                                ),
                                trackHeight: 2.0,
                                tickMarkShape: RoundSliderTickMarkShape(
                                  tickMarkRadius: 8.5.sp,
                                ),
                                activeTickMarkColor: AppColors.appColor,
                                inactiveTickMarkColor: AppColors.transparentColor,
                              ),
                            ),
                            child: Slider(
                              padding: EdgeInsets.symmetric(
                                vertical: 2.h,
                                horizontal: 2.w,
                              ),
            
                              value: controller.currentBudget.value,
                              min: controller.budgetValues.first,
                              max: controller.budgetValues.last,
                              divisions: controller.budgetValues.length - 1,
                              label: controller.currentBudget.value
                                  .toStringAsFixed(0),
                              onChanged: (double value) {
                                controller.currentBudget.value = value;
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text:
                                    '\$${controller.budgetValues.first.toInt()}',
                                fontSize: 15.5.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.darkGreyColor,
                              ),
                              CustomText(
                                text: '\$${controller.budgetValues.last.toInt()}',
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
             */
                GapH(1.h),
                CustomDivider(),
                GapH(1.h),

                //Fuel
                headerWidget(
                  onTap: () => controller.showFuelFilters.value =
                      !controller.showFuelFilters.value,
                  isShown: controller.showFuelFilters.value,
                  label: 'Fuel',
                ),
                checkboxListWidget(
                  filterListModel: controller.fuelFilters,
                  isShown: controller.showFuelFilters,
                ),

                GapH(1.h),
                CustomDivider(),
                GapH(1.h),

                //Model Year
                headerWidget(
                  onTap: () => controller.showModelYearFilters.value =
                      !controller.showModelYearFilters.value,
                  isShown: controller.showModelYearFilters.value,
                  label: 'Model Year',
                ),
                checkboxListWidget(
                  filterListModel: controller.modelYearFilters,
                  isShown: controller.showModelYearFilters,
                ),

                GapH(1.h),
                CustomDivider(),
                GapH(1.h),

                //Features
                headerWidget(
                  onTap: () => controller.showFeatureFilters.value =
                      !controller.showFeatureFilters.value,
                  isShown: controller.showFeatureFilters.value,
                  label: 'Features',
                ),
                checkboxListWidget(
                  filterListModel: controller.featureFilters,
                  isShown: controller.showFeatureFilters,
                ),

                GapH(1.h),
                CustomDivider(),
                GapH(1.h),

                //RTO
                headerWidget(
                  onTap: () => controller.showRtoFilters.value =
                      !controller.showRtoFilters.value,
                  isShown: controller.showRtoFilters.value,
                  label: 'RTO',
                ),
                checkboxListWidget(
                  filterListModel: controller.rtoFilters,
                  isShown: controller.showRtoFilters,
                ),

                GapH(1.h),
                CustomDivider(),
                GapH(1.h),

                //Body Type
                headerWidget(
                  onTap: () => controller.showBodyTypeFilters.value =
                      !controller.showBodyTypeFilters.value,
                  isShown: controller.showBodyTypeFilters.value,
                  label: 'Body Type',
                ),
                checkboxListWidget(
                  filterListModel: controller.bodyTypeFilters,
                  isShown: controller.showBodyTypeFilters,
                ),

                GapH(1.h),
                CustomDivider(),
                GapH(1.h),

                //Transmission
                headerWidget(
                  onTap: () => controller.showTransmissionFilters.value =
                      !controller.showTransmissionFilters.value,
                  isShown: controller.showTransmissionFilters.value,
                  label: 'Transmission',
                ),
                checkboxListWidget(
                  filterListModel: controller.transmissionFilters,
                  isShown: controller.showTransmissionFilters,
                ),

                GapH(1.h),
                CustomDivider(),
                GapH(1.h),

                //Owners
                headerWidget(
                  onTap: () => controller.showOwnerFilters.value =
                      !controller.showOwnerFilters.value,
                  isShown: controller.showOwnerFilters.value,
                  label: 'Owners',
                ),
                checkboxListWidget(
                  filterListModel: controller.ownerFilters,
                  isShown: controller.showOwnerFilters,
                ),

                GapH(1.h),
                CustomDivider(),
                GapH(1.h),

                //Seats
                headerWidget(
                  onTap: () => controller.showSeatFilters.value =
                      !controller.showSeatFilters.value,
                  isShown: controller.showSeatFilters.value,
                  label: 'Seats',
                ),
                checkboxListWidget(
                  filterListModel: controller.seatFilters,
                  isShown: controller.showSeatFilters,
                ),

                GapH(1.h),
                CustomDivider(),
                GapH(1.h),

                //KMs Driven
                headerWidget(
                  onTap: () => controller.showKmDrivenFilters.value =
                      !controller.showKmDrivenFilters.value,
                  isShown: controller.showKmDrivenFilters.value,
                  label: 'KMs Driven',
                ),
                checkboxListWidget(
                  filterListModel: controller.kmDrivenFilters,
                  isShown: controller.showKmDrivenFilters,
                ),

                GapH(1.h),
                CustomDivider(),
                GapH(1.h),

                //Color
                headerWidget(
                  onTap: () => controller.showColorFilters.value =
                      !controller.showColorFilters.value,
                  isShown: controller.showColorFilters.value,
                  label: 'Color',
                ),
                checkboxListWidget(
                  filterListModel: controller.colorFilters,
                  isShown: controller.showColorFilters,
                ),
                GapH(3.h),

                CustomButton(text: 'Apply'),

                GapH(5.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget headerWidget({
    required String label,
    required bool Function() onTap,
    required bool isShown,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: AppColors.transparentColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(text: label, fontWeight: FontWeight.w700),
            CustomAssetImage(
              image: isShown
                  ? Assets.assetsIconsDropup
                  : Assets.assetsIconsDropdown,
              color: AppColors.appColor,
              width: 1.5.h,
              height: 1.5.h,
            ),
          ],
        ),
      ),
    );
  }

  Widget checkboxListWidget({
    required List<FilterListModel> filterListModel,
    required RxBool isShown,
  }) {
    return Obx(() {
      return isShown.value
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GapH(1.h),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: filterListModel.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final data = filterListModel[index];
                    return Obx(
                      () => CheckboxListTile(
                        dense: true,
                        visualDensity: VisualDensity.compact,
                        contentPadding: EdgeInsets.zero,
                        side: const BorderSide(
                          color: AppColors.greyColor,
                          width: 0.8,
                        ),
                        fillColor: WidgetStateProperty.resolveWith((states) {
                          if (!states.contains(WidgetState.selected)) {
                            return Colors.white;
                          }
                          return null;
                        }),
                        title: CustomText(
                          text: data.title,
                          fontSize: 15.5.sp,
                          fontWeight: FontWeight.w600,
                          color: data.clicked.value
                              ? AppColors.appColor
                              : AppColors.darkGreyColor,
                        ),
                        value: data.clicked.value,
                        onChanged: (_) =>
                            data.clicked.value = !data.clicked.value,
                        controlAffinity: ListTileControlAffinity.leading,
                        activeColor: AppColors.appColor,
                        checkColor: AppColors.whiteColor,
                        checkboxScaleFactor: 1.5,
                        checkboxShape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    );
                  },
                ),
              ],
            )
          : SizedBox.shrink();
    });
  }
}
