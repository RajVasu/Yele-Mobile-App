import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/core/widgets/custom_text.dart';
import 'package:yele/src/core/widgets/gap.dart';
import 'package:yele/src/features/user/filter/controller/filter_controller.dart';

class FilterCheckboxListWidget extends StatefulWidget {
  List<FilterListModel> filterListModel;
  RxBool isShown;
  String lableName;
  FilterCheckboxListWidget({
    super.key,
    required this.filterListModel,
    required this.isShown,
    required this.lableName,
  });

  @override
  State<FilterCheckboxListWidget> createState() =>
      _FilterCheckboxListWidgetState();
}

class _FilterCheckboxListWidgetState extends State<FilterCheckboxListWidget> {
  FilterController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return widget.isShown.value
          ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GapH(1.h),
              ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: widget.filterListModel.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final data = widget.filterListModel[index];
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
                        color:
                            data.clicked.value
                                ? AppColors.appColor
                                : AppColors.darkGreyColor,
                      ),
                      value: data.clicked.value,
                      onChanged: (_) {
                        data.clicked.value = !data.clicked.value;
                        if (data.clicked.value) {
                          controller.addSearchData(
                            data: data.title,
                            type: widget.lableName,
                          );
                        } else {
                          controller.removeSearchData(
                            data: data.title,
                            type: widget.lableName,
                          );
                        }
                      },
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

class FilterListModel {
  final String title;
  RxBool clicked;

  FilterListModel({required this.title, required this.clicked});
}
