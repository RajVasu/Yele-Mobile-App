import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/core/widgets/custom_text.dart';
import 'package:yele/src/features/user/car/controller/car_controller.dart';

class CarOverViewWidget extends StatefulWidget {
  const CarOverViewWidget({super.key});

  @override
  State<CarOverViewWidget> createState() => _CarOverViewWidgetState();
}

class _CarOverViewWidgetState extends State<CarOverViewWidget> {
  final CarController _carController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomLabel(
          label1: 'Car Make',
          label2: 'Car Model Year',
          value1: _carController.getCarData.value.ownerName!,
          value2: _carController.getCarData.value.carModelYear!.toString(),
        ),

        CustomLabel(
          label1: 'Car Model',
          label2: 'Car Type',
          value1: _carController.getCarData.value.carModel!,
          value2: _carController.getCarData.value.carTypeName!.toString(),
        ),

        CustomLabel(
          label1: 'RTO',
          label2: 'Transmission',
          value1: _carController.getCarData.value.rto!,
          value2: _carController.getCarData.value.transmission!.toString(),
        ),

        CustomLabel(
          label1: 'Ownership',
          label2: 'Seats',
          value1: _carController.getCarData.value.carOwnerType!,
          value2: _carController.getCarData.value.seats.toString(),
        ),

        CustomLabel(
          label1: 'Reg Numbers',
          label2: 'Engine Capacity',
          value1: _carController.getCarData.value.regNumber!,
          value2: _carController.getCarData.value.engineCapacity!,
        ),

        CustomLabel(
          label1: 'Fuel Type',
          label2: 'Spare Key',
          value1: _carController.getCarData.value.fuelType!,
          value2: _carController.getCarData.value.spareKey.toString(),
        ),

        CustomLabel(
          label1: 'Color',
          label2: 'Insurance',
          value1: _carController.getCarData.value.color!,
          value2:
              '${_carController.getCarData.value.insuranceStartDate!} - ${_carController.getCarData.value.insuranceEndDate!}',
        ),

        CustomLabel(
          label1: 'Power (bhp)',
          label2: '',
          value1: _carController.getCarData.value.power!,
          value2: '',
        ),
      ],
    );
  }
}

class CustomLabel extends StatelessWidget {
  final String label1, label2;
  final String value1, value2;
  final double fontSize;
  final Color labelColor;
  final Color valueColor;
  final FontWeight valueFontWeight;

  const CustomLabel({
    super.key,
    required this.label1,
    required this.label2,
    required this.value1,
    required this.value2,
    this.fontSize = 16.0,
    this.labelColor = AppColors.darkGreyColor,
    this.valueColor = AppColors.blackColor,
    this.valueFontWeight = FontWeight.w700,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: label1,
                fontSize: fontSize.sp,
                color: labelColor,
              ),

              CustomText(
                text: value1,
                fontSize: fontSize.sp,
                fontWeight: valueFontWeight,
                color: valueColor,
              ),
            ],
          ),
        ),
        Container(
          color: AppColors.dividerColor,
          height: 8.h,
          width: 1.5,
          margin: EdgeInsets.symmetric(horizontal: 3.w),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: label2,
                fontSize: fontSize.sp,
                color: labelColor,
              ),
              CustomText(
                text: value2,
                fontSize: fontSize.sp,
                fontWeight: valueFontWeight,
                color: valueColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
