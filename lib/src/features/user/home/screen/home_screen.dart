import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/config/constants/assets.dart';
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
  RxInt currentPage = 0.obs;
  RxInt currentIndex = 0.obs;
  RxInt selectedIndex = 0.obs;
  final PageController _pageController = PageController();
  final PageController _pageModelController = PageController();
  final List<Map<String, String>> carBrands = [
    {
      'name': 'Mercedes',
      'logo':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/9/90/Mercedes-Logo.svg/1200px-Mercedes-Logo.svg.png',
    },
    {
      'name': 'Suzuki',
      'logo':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/Suzuki_logo_2.svg/2560px-Suzuki_logo_2.svg.png',
    },
    {
      'name': 'Tata',
      'logo':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8e/Tata_logo.svg/2231px-Tata_logo.svg.png',
    },
    {
      'name': 'Hyundai',
      'logo':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/4/44/Hyundai_Motor_Company_logo.svg/2560px-Hyundai_Motor_Company_logo.svg.png',
    },
    {
      'name': 'Honda',
      'logo':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/3/38/Honda.svg/2560px-Honda.svg.png',
    },
    {
      'name': 'Jeep',
      'logo':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/d/db/Jeep_logo.svg/2560px-Jeep_logo.svg.png',
    },
    {
      'name': 'Kia',
      'logo':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Kia-logo.png/1200px-Kia-logo.png',
    },
    {
      'name': 'MG',
      'logo':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f5/MG_Motors_logo.svg/2560px-MG_Motors_logo.svg.png',
    },
    {
      'name': 'Mercedes',
      'logo':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/9/90/Mercedes-Logo.svg/1200px-Mercedes-Logo.svg.png',
    },
    {
      'name': 'Suzuki',
      'logo':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/Suzuki_logo_2.svg/2560px-Suzuki_logo_2.svg.png',
    },
    {
      'name': 'Tata',
      'logo':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8e/Tata_logo.svg/2231px-Tata_logo.svg.png',
    },
    {
      'name': 'Hyundai',
      'logo':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/4/44/Hyundai_Motor_Company_logo.svg/2560px-Hyundai_Motor_Company_logo.svg.png',
    },
    {
      'name': 'Kia',
      'logo':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Kia-logo.png/1200px-Kia-logo.png',
    },
    {
      'name': 'MG',
      'logo':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f5/MG_Motors_logo.svg/2560px-MG_Motors_logo.svg.png',
    },
    {
      'name': 'Honda',
      'logo':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/3/38/Honda.svg/2560px-Honda.svg.png',
    },
    {
      'name': 'Jeep',
      'logo':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/d/db/Jeep_logo.svg/2560px-Jeep_logo.svg.png',
    },
  ];
  List<String> carModel = [
    'Corolla',
    'Glanza',
    'Rumion',
    'Hilux',
    'Urban Cruiser Taisor',
    'Urban Cruiser Hyryder',
    'Innova Crysta',
    'Vellfire',
    'Avalon',
    'Allion',
    'Alphard',
    'Avanza',
    'Century',
    'Avalon',
    'Avanza',
    'Rumion',
    'Hilux',
    'Urban Cruiser Taisor',
    'Century',
    'Corolla',
    'Vellfire',
    'Glanza',
    'Allion',
    'Urban Cruiser Hyryder',
    'Alphard',
    'Innova Crysta',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    _pageModelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [
                  const Color(0xFF3FA9F5),
                  const Color(0xFF3FA9F5),
                  const Color(0xFF3FA9F5),
                  const Color(0xFF3CC9E1),
                  // First color
                ],
              ),
            ),
            padding: EdgeInsets.only(top: 3.h),
            child: Column(
              children: [
                GapH(15),
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
    );
  }
}
