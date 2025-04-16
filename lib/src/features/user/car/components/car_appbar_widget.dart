import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/api/endpoints.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/features/user/car/controller/car_controller.dart';

class CarAppbarWidget extends StatefulWidget {
  const CarAppbarWidget({super.key});

  @override
  State<CarAppbarWidget> createState() => _CarAppbarWidgetState();
}

class _CarAppbarWidgetState extends State<CarAppbarWidget> {
  final CarController _carController = Get.find();
  final RxDouble _currentPage = 0.0.obs;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      actionsPadding: EdgeInsets.zero,
      backgroundColor: AppColors.appColor,
      // leadingWidth: 16.w,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,

      actions: [
        GestureDetector(
          onTap:
              () =>
                  _carController.favorite.value =
                      !_carController.favorite.value,
          child: Container(
            margin: EdgeInsets.only(right: 5.w, top: 9.sp, bottom: 9.sp),
            padding: EdgeInsets.all(12.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Obx(
              () => Icon(
                _carController.favorite.value
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: AppColors.appColor,
                size: 18.sp,
              ),
            ),
          ),
        ),
      ],

      leading: GestureDetector(
        onTap: () => Get.back(),
        child: Container(
          height: 1.h,
          width: 1.h,
          margin: EdgeInsets.only(left: 5.w, top: 9.sp, bottom: 9.sp),
          padding: EdgeInsets.all(10.sp),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.blackColor,
            size: 18.sp,
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        // title: Container(color: Colors.amber),
        background: Stack(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                onPageChanged: (index, reason) {
                  print(index);
                  _currentPage.value = double.parse(index.toString());
                },
                height: 400,
                viewportFraction: 1.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.linear,
                enlargeCenterPage: true,
                enlargeFactor: 0.0,
                aspectRatio: 16 / 9,
                scrollDirection: Axis.horizontal,
              ),
              items:
                  _carController.getCarData.value.carImages!
                      .map(
                        (e) => SizedBox(
                          width: double.infinity,
                          child: Image.network(
                            '${Endpoints.baseUrl}${e.image}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                      .toList(),
            ),
            if (_carController.getCarData.value.carImages!.length > 1)
              Align(
                alignment: Alignment.bottomCenter,
                child: Obx(() {
                  final dotsCount =
                      _carController.getCarData.value.carImages!.length;
                  final fadeOutDistance = dotsCount > 2 ? 2 : dotsCount - 1;
                  return DotsIndicator(
                    fadeOutLastDot: true,
                    dotsCount: dotsCount,
                    position: _currentPage.toDouble(),
                    fadeOutDistance: fadeOutDistance,
                    decorator: DotsDecorator(
                      activeColor: AppColors.whiteColor,
                      size: const Size.square(6.0),
                      activeSize: const Size(15.0, 6.0),
                      activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  );
                }),
              ),
          ],
        ),
      ),
    );
  }
}
