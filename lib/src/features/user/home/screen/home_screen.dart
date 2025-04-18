import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/api/endpoints.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/config/constants/assets.dart';
import 'package:yele/src/core/database/storage.dart';
import 'package:yele/src/core/screens/no_internet_screen.dart';
import 'package:yele/src/core/widgets/custom_image.dart';
import 'package:yele/src/core/widgets/custom_text.dart';
import 'package:yele/src/core/widgets/gap.dart';
import 'package:yele/src/features/user/home/components/banner_widget.dart';
import 'package:yele/src/features/user/home/components/browse_type.dart';
import 'package:yele/src/features/user/home/components/car_maker_widget.dart';
import 'package:yele/src/features/user/home/components/explore_option_widget.dart';
import 'package:yele/src/features/user/home/components/locate_dealership_widget.dart';
import 'package:yele/src/features/user/home/components/review_widget.dart';
import 'package:yele/src/features/user/home/controller/user_home_controller.dart';
import 'package:yele/src/features/user/profile/controller/profile_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return NoInternetScreen(child: HomeView());
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ProfileController _profileController = Get.find();
  final UserHomeController _homeController = Get.find();
  @override
  void initState() {
    if (Storage.instance.getToken() != null) {
      _profileController.getCurrentUserData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: UserHomeController(),
      builder: (context) {
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: AppColors.gradient.colors,
                ),
              ),
              padding: EdgeInsets.only(top: 3.h),
              child: Column(
                children: [
                  if (Storage.instance.getToken() != null) ...[
                    GapH(3.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.sp),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.whiteColor,
                                width: 2,
                              ),
                            ),
                            child: Obx(
                              () => CircleAvatar(
                                radius: 18.sp,
                                backgroundColor: AppColors.appColor,
                                backgroundImage:
                                    (_profileController
                                                .userData
                                                .value
                                                .profileImage !=
                                            null
                                        ? NetworkImage(
                                          '${Endpoints.baseUrl}${_profileController.userData.value.profileImage!}',
                                        )
                                        : AssetImage(
                                          Assets.assetsImagesUserImage,
                                        )),
                              ),
                            ),
                          ),
                          GapW(2.w),
                          CustomText(
                            text:
                                '${_profileController.userData.value.firstName} ${_profileController.userData.value.lastName}',
                            fontWeight: FontWeight.w700,
                            color: AppColors.whiteColor,
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.all(13.sp),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.whiteColor.withOpacity(0.5),
                              ),
                            ),
                            child: CustomAssetImage(
                              image: Assets.assetsIconsMessage,
                              height: 2.5.h,
                              width: 2.5.h,
                            ),
                          ),
                          GapW(2.w),
                          Container(
                            padding: EdgeInsets.all(13.sp),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.whiteColor.withOpacity(0.5),
                              ),
                            ),
                            child: CustomAssetImage(
                              image: Assets.assetsIconsNotification,
                              height: 2.5.h,
                              width: 2.5.h,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    GapH(15),
                  ],
                  Container(
                    margin: EdgeInsets.all(15.sp),
                    padding: EdgeInsets.all(15.sp),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(20.sp),
                    ),
                    child: Row(
                      children: [
                        GapW(1.w),
                        CustomAssetImage(
                          image: Assets.assetsIconsSearch,
                          height: 2.h,
                          width: 2.h,
                        ),
                        GapW(2.w),
                        CustomText(
                          text: "Search cars...",
                          color: AppColors.greyColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  Future.wait([
                    _profileController.getCurrentUserData(),
                    _homeController.getCarBrandListData(),
                    _homeController.getCarModelListData(),
                    _homeController.getBrowseTypeData(),
                  ]);
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GapH(15),
                      HomeBannerWidget(),
                      GapH(15),
                      ExploreOptionWidget(),
                      GapH(15),
                      ReviewWidget(),
                      GapH(15),
                      CarMakerWidget(),
                      GapH(15),
                      BrowseType(),
                      GapH(15),
                      LocateDealershipWidget(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
