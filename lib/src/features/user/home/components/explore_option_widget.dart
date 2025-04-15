import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/api/endpoints.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/core/widgets/custom_text.dart';
import 'package:yele/src/core/widgets/gap.dart';
import 'package:yele/src/features/user/home/controller/user_home_controller.dart';
import 'package:yele/src/features/user/home/model/get_car_brand_list_model.dart';
import 'package:yele/src/features/user/home/model/get_car_model_list_model.dart';

class ExploreOptionWidget extends StatefulWidget {
  const ExploreOptionWidget({super.key});

  @override
  State<ExploreOptionWidget> createState() => _ExploreOptionWidgetState();
}

class _ExploreOptionWidgetState extends State<ExploreOptionWidget> {
  final UserHomeController _userHomeController = Get.find();
  RxInt currentPage = 0.obs;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.sp),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
          colors: [const Color(0xFF3FA9F5), const Color(0xFF3CC9E1)],
        ),
        borderRadius: BorderRadius.circular(15.sp),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomText(
            text: 'Explore your options',
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 17.sp,
          ),
          GapH(2.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildSelectionButton('Select Brand', 0, () {
                  currentPage.value = 0;
                }),
                SizedBox(width: 2.w),
                _buildSelectionButton('Select Model', 1, () {
                  currentPage.value = 1;
                }),
                SizedBox(width: 2.w),
                _buildSelectionButton('Select Make Year', 2, () {
                  currentPage.value = 2;
                }),
              ],
            ),
          ),
          GapH(2.h),
          Container(
            padding: EdgeInsets.all(15.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.sp),
            ),
            child: Obx(
              () => currentPage.value == 0
                  ? PaginatedCarBrandView(
                      carBrandList: _userHomeController.carBrandList)
                  : currentPage.value == 1
                      ? PaginatedCarModelView(
                          carModel: _userHomeController.carModelList)
                      : PaginationedCarYear(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionButton(String text, int index, void Function() onTap) {
    return Obx(
      () => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
          decoration: BoxDecoration(
            color:
                index == currentPage.value ? Colors.white : Colors.transparent,
            border: Border.all(
              color: index == currentPage.value
                  ? Colors.transparent
                  : Colors.white,
            ),
            borderRadius: BorderRadius.circular(20.sp),
          ),
          child: Center(
            child: CustomText(
              text: text,
              color: index == currentPage.value
                  ? AppColors.appColor
                  : Colors.white,
              fontSize: 14.sp,
            ),
          ),
        ),
      ),
    );
  }
}

class PaginatedCarModelView extends StatelessWidget {
  final List<GetCarModelListModel> carModel;

  PaginatedCarModelView({super.key, required this.carModel});

  final RxInt selectedIndex = 0.obs;
  final PageController _pageModelController = PageController();

  @override
  Widget build(BuildContext context) {
    final int itemsPerPage = 13;

    List<List<GetCarModelListModel>> getPagedItems() {
      List<List<GetCarModelListModel>> pages = [];

      for (int i = 0; i < carModel.length; i += itemsPerPage) {
        pages.add(
          carModel.sublist(
            i,
            (i + itemsPerPage < carModel.length)
                ? i + itemsPerPage
                : carModel.length,
          ),
        );
      }

      return pages;
    }

    return Column(
      children: [
        SizedBox(
          height: 22.h, // Adjust the height as per your requirement.
          child: PageView.builder(
            controller: _pageModelController,
            onPageChanged: (index) {
              selectedIndex.value = index;
            },
            itemCount: getPagedItems().length, // Number of pages.
            itemBuilder: (context, pageIndex) {
              final pageItems =
                  getPagedItems()[pageIndex]; // Get items for the current page.

              return Wrap(
                runSpacing: 1.h,
                spacing: 2.w,
                children: pageItems.map((e) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 1.h,
                      horizontal: 3.w,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: AppColors.greyColor.withOpacity(0.3),
                      ),
                      borderRadius: BorderRadius.circular(20.sp),
                    ),
                    child: CustomText(
                      text: e.carModel!,
                      color: AppColors.darkGreyColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            getPagedItems().length, // Create indicator for each page.
            (index) =>
                Obx(() => _buildPageIndicator(index == selectedIndex.value)),
          ),
        ),
      ],
    );
  }

  // Custom page indicator widget.
  Widget _buildPageIndicator(bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0.5.w),
      height: 1.h,
      width: isSelected ? 6.w : 2.w,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.appColor : AppColors.greyColor,
        borderRadius: BorderRadius.circular(15.sp),
      ),
    );
  }
}

class PaginatedCarBrandView extends StatelessWidget {
  final List<GetCarBrandListModel> carBrandList;
  PaginatedCarBrandView({super.key, required this.carBrandList});

  final PageController _pageController = PageController();

  RxInt currentIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 22.h,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              currentIndex.value = index;
            },
            itemCount: (carBrandList.length / 8).ceil(),
            itemBuilder: (context, pageIndex) {
              return GridView.builder(
                padding: EdgeInsets.all(10.sp),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 8,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 3.w,
                  mainAxisSpacing: 2.h,
                ),
                itemBuilder: (context, index) {
                  final brandIndex = pageIndex * 8 + index;
                  if (brandIndex < carBrandList.length) {
                    return Container(
                      padding: EdgeInsets.all(15.sp),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      child: Image.network(
                        '${Endpoints.baseUrl}${carBrandList[brandIndex].brandLogo}',
                        errorBuilder: (
                          context,
                          error,
                          stackTrace,
                        ) {
                          return Icon(Icons.error);
                        },
                      ),
                    );
                  }
                  return SizedBox();
                },
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            (carBrandList.length / 8).ceil(),
            (index) => Obx(
              () => _buildPageIndicator(
                index == currentIndex.value,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPageIndicator(bool isActive) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0.5.w),
      height: 1.h,
      width: isActive ? 6.w : 2.w,
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.appColor
            : AppColors.greyColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(15.sp),
      ),
    );
  }
}

class PaginationedCarYear extends StatefulWidget {
  const PaginationedCarYear({super.key});

  @override
  State<PaginationedCarYear> createState() => _PaginationedCarYearState();
}

class _PaginationedCarYearState extends State<PaginationedCarYear> {
  final PageController _pageController = PageController();
  List<int> carYearList =
      List.generate(2025 - 2000 + 1, (index) => 2000 + index);
  RxInt currentIndex = 0.obs;

  final int itemsPerPage = 16;

  List<List<int>> getPagedItems() {
    List<List<int>> pages = [];
    for (int i = 0; i < carYearList.length; i += itemsPerPage) {
      pages.add(carYearList.sublist(
        i,
        i + itemsPerPage > carYearList.length
            ? carYearList.length
            : i + itemsPerPage,
      ));
    }
    return pages;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 22.h, // Adjust the height as per your requirement.
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              currentIndex.value = index;
            },
            itemCount: getPagedItems().length, // Number of pages.
            itemBuilder: (context, pageIndex) {
              final pageItems =
                  getPagedItems()[pageIndex]; // Get items for the current page.

              return Wrap(
                runSpacing: 1.h,
                spacing: 3.w,
                children: pageItems.map((e) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 1.h,
                      horizontal: 5.w,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: AppColors.greyColor.withOpacity(0.3),
                      ),
                      borderRadius: BorderRadius.circular(20.sp),
                    ),
                    child: CustomText(
                      text: e.toString(),
                      color: AppColors.darkGreyColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            (carYearList.length / 16).ceil(),
            (index) => Obx(
              () => _buildPageIndicator(
                index == currentIndex.value,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPageIndicator(bool isActive) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0.5.w),
      height: 1.h,
      width: isActive ? 6.w : 2.w,
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.appColor
            : AppColors.greyColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(15.sp),
      ),
    );
  }
}
