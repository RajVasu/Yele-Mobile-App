import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/config/constants/assets.dart';
import 'package:yele/src/core/widgets/custom_image.dart';
import 'package:yele/src/features/user/car/controller/car_controller.dart';

class CarAppbarWidget extends StatefulWidget {
  const CarAppbarWidget({super.key});

  @override
  State<CarAppbarWidget> createState() => _CarAppbarWidgetState();
}

class _CarAppbarWidgetState extends State<CarAppbarWidget> {
  final RxDouble _currentPage = 0.0.obs;
  CarController controller = Get.find();

  List imageList = [
    Assets.assetsImagesBCar1,
    Assets.assetsImagesBCar3,
    Assets.assetsImagesBCar5,
  ];
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      actionsPadding: EdgeInsets.zero,
      backgroundColor: AppColors.appColor,
      leadingWidth: 16.w,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      actions: [
          GestureDetector(
          onTap: () => controller.favorite.value = !controller.favorite.value,
          child: Container(
            margin: EdgeInsets.only(right: 5.w, top: 9.sp, bottom: 9.sp),
            padding: EdgeInsets.all(10.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Obx(
              () => Icon(
                controller.favorite.value
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
          margin: EdgeInsets.only(left: 5.w, top: 10.sp, bottom: 10.sp),
          padding: EdgeInsets.all(13.5.sp),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: CustomAssetImage(
            image: Assets.assetsIconsBackIcon,
            height: 2.h,
            width: 2.h,
            color: AppColors.blackColor,
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
              items: imageList
                  .map(
                    (e) => SizedBox(
                      width: double.infinity,
                      child: Image.asset(e, fit: BoxFit.cover),
                    ),
                  )
                  .toList(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Obx(
                () => DotsIndicator(
                  fadeOutLastDot: true,
                  dotsCount: imageList.length,
                  position: _currentPage.toDouble(),
                  fadeOutDistance: 2,
                  decorator: DotsDecorator(
                    activeColor: AppColors.whiteColor,
                    size: const Size.square(6.0),
                    activeSize: const Size(15.0, 6.0),
                    activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
