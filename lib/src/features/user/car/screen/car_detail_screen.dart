import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/core/screens/no_internet_screen.dart';
import 'package:yele/src/core/utils/enums.dart';
import 'package:yele/src/core/widgets/custom_button.dart';
import 'package:yele/src/core/widgets/custom_text.dart';
import 'package:yele/src/core/widgets/gap.dart';
import 'package:yele/src/features/user/car/components/car_appbar_widget.dart';
import 'package:yele/src/features/user/car/components/car_detail_view_widget.dart';
import 'package:yele/src/features/user/car/components/car_over_view_widget.dart';
import 'package:yele/src/features/user/car/components/custom_table_widget.dart';
import 'package:yele/src/features/user/car/components/popular_upcoming_cars_widget.dart';
import 'package:yele/src/features/user/car/controller/car_controller.dart';

class CarDetailScreen extends StatefulWidget {
  const CarDetailScreen({super.key});

  @override
  State<CarDetailScreen> createState() => _CarDetailScreenState();
}

class _CarDetailScreenState extends State<CarDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return NoInternetScreen(child: CarDetailView());
  }
}

class CarDetailView extends StatefulWidget {
  const CarDetailView({super.key});

  @override
  State<CarDetailView> createState() => _CarDetailViewState();
}

class _CarDetailViewState extends State<CarDetailView> {
  final CarController _carController = Get.find();
  var carId = Get.arguments;
  @override
  void initState() {
    _carController.getCarBrandListData(carId: carId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CarController>(
      init: CarController(),
      builder: (context) {
        if (_carController.formzStatus.value == FormzStatus.loading) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: AppColors.blackColor,
              ),
            ),
          );
        }
        return Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (
              BuildContext context,
              bool innerBoxIsScrolled,
            ) {
              return <Widget>[CarAppbarWidget()];
            },
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarDetailViewWidget(),

                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.appColor.withOpacity(0.2),
                          AppColors.appColor.withOpacity(0.01),
                          AppColors.appColor.withOpacity(0.01),
                        ],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GapH(1.5.h),
                        CustomText(
                          text: 'Car Overview',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        GapH(1.5.h),
                        CarOverViewWidget(),
                        Divider(
                          color: AppColors.dividerColor,
                          height: 0,
                          thickness: 1.5,
                        ),
                        GapH(1.5.h),
                        ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text:
                                      _carController
                                          .getCarData
                                          .value
                                          .features![index]
                                          .feature!,
                                  fontSize: 16.sp,
                                  color: AppColors.darkGreyColor,
                                ),
                                CustomText(
                                  text:
                                      _carController
                                          .getCarData
                                          .value
                                          .features![index]
                                          .description!,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (context, index) => GapH(1.5.h),
                          itemCount:
                              _carController.getCarData.value.features!.length,
                        ),
                        GapH(1.5.h),
                        CustomButton(text: 'Book a Test Drive'),
                        GapH(1.5.h),
                        CustomText(
                          text: 'Compare Taisor with Similar Cars',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        GapH(1.5.h),
                        CustomTableWidget(),
                        CustomText(
                          text: 'Popular Upcoming Cras',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        GapH(1.5.h),
                      ],
                    ),
                  ),
                  PopularUpcomingCarsWidget(),
                  GapH(1.5.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
