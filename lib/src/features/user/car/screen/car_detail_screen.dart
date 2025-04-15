import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/config/constants/assets.dart';
import 'package:yele/src/config/router/routes.dart';
import 'package:yele/src/core/database/storage.dart';
import 'package:yele/src/core/screens/no_internet_screen.dart';
import 'package:yele/src/core/widgets/custom_button.dart';
import 'package:yele/src/core/widgets/custom_divider.dart';
import 'package:yele/src/core/widgets/custom_image.dart';
import 'package:yele/src/core/widgets/custom_text.dart';
import 'package:yele/src/core/widgets/custom_text_field.dart';
import 'package:yele/src/core/widgets/gap.dart';
import 'package:yele/src/features/user/car/components/car_appbar_widget.dart';
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
  List imageList = [
    Assets.assetsImagesBCar1,
    Assets.assetsImagesBCar3,
    Assets.assetsImagesBCar5,
  ];
  List tempList = [
    {'name': '32,458 KM', 'icon': Assets.assetsIconsDistance},
    {'name': 'Petrol', 'icon': Assets.assetsIconsPetrol},
    {'name': 'Manual', 'icon': Assets.assetsIconsManual},
    {'name': '2nd Owner', 'icon': Assets.assetsIconsOwner},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[CarAppbarWidget()];
        },
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(18.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GapH(1.h),
                    CustomText(
                      text: 'Toyota Urban Cruiser taisor',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    GapH(1.h),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: '\$ 250000.00',
                              color: AppColors.appColor,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                            ),
                            CustomText(text: 'EMI \$500.00 / month'),
                          ],
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.yellowColor),
                            borderRadius: BorderRadius.circular(15.sp),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: AppColors.yellowColor,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: AppColors.yellowColor,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: AppColors.yellowColor,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: AppColors.yellowColor,
                                  ),
                                ],
                              ),
                              CustomText(
                                text: '32 Ratings',
                                color: AppColors.darkGreyColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: AppColors.dividerColor,
                      height: 5.h,
                      thickness: 1.5,
                    ),
                    Row(
                      children: [
                        CustomText(text: 'Color', fontWeight: FontWeight.w700),
                        Spacer(),
                        CustomText(
                          text: 'Yellow',
                          color: AppColors.darkGreyColor,
                        ),
                      ],
                    ),
                    GapH(2.h),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.yellowColor,
                          radius: 15.sp,
                        ),
                        GapW(2.w),
                        CircleAvatar(
                          backgroundColor: AppColors.errorSnackColor,
                          radius: 15.sp,
                        ),
                        GapW(2.w),
                        CircleAvatar(
                          backgroundColor: AppColors.darkBlueColor,
                          radius: 15.sp,
                        ),
                        GapW(2.w),
                        CircleAvatar(
                          backgroundColor: AppColors.darkGreyColor,
                          radius: 15.sp,
                        ),
                        GapW(2.w),
                        CircleAvatar(
                          backgroundColor: AppColors.suscessSnackColor,
                          radius: 15.sp,
                        ),
                      ],
                    ),
                    GapH(2.h),
                    Container(
                      padding: EdgeInsets.all(10.sp),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.sp),
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF3FA9F5).withOpacity(0.3),
                            const Color(0xFF3CC9E1).withOpacity(0.3),
                          ],
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10.sp),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  const Color(0xFF3FA9F5),
                                  const Color(0xFF3CC9E1),
                                ],
                              ),
                            ),
                            child: CustomAssetImage(
                              image: Assets.assetsIconsDoller,
                              height: 1.5.h,
                              width: 1.5.h,
                            ),
                          ),
                          GapW(1.w),
                          CustomText(
                            text:
                                'GREAT PRICE according to our Price Indicator.',
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp,
                          ),
                          GapW(1.w),
                        ],
                      ),
                    ),
                    GapH(3.h),
                    SizedBox(
                      height: 7.h,
                      child: ListView.separated(
                        itemCount: tempList.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return SpecificationItem(
                            icon: tempList[index]['icon'],
                            label: '${tempList[index]['name']}',
                          );
                        },
                        separatorBuilder: (context, index) => Container(
                          width: 1,
                          height: 8.h,
                          color: AppColors.dividerColor,
                          margin: EdgeInsets.symmetric(
                            vertical: 0.5.h,
                            horizontal: 3.w,
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: AppColors.dividerColor,
                      height: 0.5.h,
                      thickness: 1,
                    ),
                    GapH(3.h),
                    CustomText(
                      text: 'Specifications',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    GapH(1.h),
                    CustomText(
                      text:
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam fringilla augue nec est tristique auctor. Donec non est at libero vulputate rutrum.',
                      fontSize: 15.sp,
                      fontWeight: FontWeight.normal,
                      color: AppColors.darkGreyColor,
                    ),
                    GapH(1.5.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomAssetImage(
                          image: Assets.assetsIconsDone,
                          height: 2.5.h,
                          width: 2.5.h,
                        ),
                        GapW(2.w),
                        Expanded(
                          child: CustomText(
                            text:
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam fringilla augue nec est tristique auctor.',
                            fontSize: 15.sp,
                            fontWeight: FontWeight.normal,
                            color: AppColors.darkGreyColor,
                          ),
                        ),
                      ],
                    ),
                    GapH(1.5.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomAssetImage(
                          image: Assets.assetsIconsDone,
                          height: 2.5.h,
                          width: 2.5.h,
                        ),
                        GapW(2.w),
                        Expanded(
                          child: CustomText(
                            text:
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam fringilla augue nec est tristique auctor.',
                            fontSize: 15.sp,
                            fontWeight: FontWeight.normal,
                            color: AppColors.darkGreyColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
                    Row(
                      children: [
                        CarOverViewWidget(),
                        GapW(3.w),
                        Container(width: 1, color: AppColors.greyColor),
                        GapW(3.w),
                        CarOverViewWidget(),
                      ],
                    ),
                    Divider(
                      color: AppColors.dividerColor,
                      height: 5.h,
                      thickness: 1.5,
                    ),
                    CustomText(
                      text: 'Audio',
                      fontSize: 16.sp,
                      color: AppColors.darkGreyColor,
                    ),
                    CustomText(
                      text:
                          'AM/FM Radio, USB & AUX Input, Bluetooth, EQ Settings',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    GapH(1.5.h),
                    CustomText(
                      text: 'Interior',
                      fontSize: 16.sp,
                      color: AppColors.darkGreyColor,
                    ),
                    CustomText(
                      text:
                          'Power-Adjustable Seats (Driver & Passenger), Heated & Ventilated Seats, Massage Seats, Adjustable Steering Wheel (Tilt & Telescopic), Ambient Lighting, Dual-Zone / Tri-Zone Climate Control, Rear AC Vents',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    GapH(1.5.h),
                    CustomText(
                      text: 'Exterior',
                      fontSize: 16.sp,
                      color: AppColors.darkGreyColor,
                    ),
                    CustomText(
                      text:
                          'Keyless Entry with Request Sensor, Electric / Auto-Folding Side Mirrors, Shark Fin Antenna, Rain-Sensing Wipers, Panoramic Sunroof, Alloy Wheels, Fog Lamps, Daytime Running Lights, Halogen Headlights',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    GapH(3.h),
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
  }
}

class CarOverViewWidget extends StatelessWidget {
  const CarOverViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 5,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: 'Car Make',
          fontSize: 16.sp,
          color: AppColors.darkGreyColor,
        ),
        CustomText(
          text: 'Toyota',
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ),
        GapH(1.5.h),
        CustomText(
          text: 'Car Make',
          fontSize: 16.sp,
          color: AppColors.darkGreyColor,
        ),
        CustomText(
          text: 'Toyota',
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ),
        GapH(1.5.h),
        CustomText(
          text: 'Car Make',
          fontSize: 16.sp,
          color: AppColors.darkGreyColor,
        ),
        CustomText(
          text: 'Toyota',
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ),
        GapH(1.5.h),
        CustomText(
          text: 'Car Model',
          fontSize: 16.sp,
          color: AppColors.darkGreyColor,
        ),
        CustomText(
          text: 'Corolla',
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ),
        GapH(1.5.h),
        CustomText(
          text: 'RTO',
          fontSize: 16.sp,
          color: AppColors.darkGreyColor,
        ),
        CustomText(
          text: '2415 1st Avenue, CA',
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ),
        GapH(1.5.h),
        CustomText(
          text: 'Ownership',
          fontSize: 16.sp,
          color: AppColors.darkGreyColor,
        ),
        CustomText(
          text: '2nd Owner',
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ),
        GapH(1.5.h),
        CustomText(
          text: 'Reg Numbers',
          fontSize: 16.sp,
          color: AppColors.darkGreyColor,
        ),
        CustomText(
          text: 'Reg-654398654320',
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ),
        GapH(1.5.h),
        CustomText(
          text: 'Fuel Type',
          fontSize: 16.sp,
          color: AppColors.darkGreyColor,
        ),
        CustomText(
          text: 'Diesel',
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ),
        GapH(1.5.h),
        CustomText(
          text: 'Color',
          fontSize: 16.sp,
          color: AppColors.darkGreyColor,
        ),
        CustomText(text: 'Red', fontSize: 16.sp, fontWeight: FontWeight.w700),
        GapH(1.5.h),
        CustomText(
          text: 'Power (bhp)',
          fontSize: 16.sp,
          color: AppColors.darkGreyColor,
        ),
        CustomText(
          text: '90-100',
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ),
        GapH(1.5.h),
      ],
    );
  }
}

class SpecificationItem extends StatelessWidget {
  final String icon;
  final String label;

  const SpecificationItem({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 18.w,
      child: Column(
        children: [
          CustomAssetImage(
            image: icon,
            height: 28,
            width: 28,
            color: AppColors.darkGreyColor,
          ),
          const SizedBox(height: 8),
          CustomText(
            text: label,
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: AppColors.darkGreyColor,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class CustomTableWidget extends StatefulWidget {
  const CustomTableWidget({super.key});

  @override
  State<CustomTableWidget> createState() => _CustomTableWidgetState();
}

class _CustomTableWidgetState extends State<CustomTableWidget> {
  List comList = [
    'Starting MSRP',
    'Engine (cc)',
    'Fuel',
    'Transmission',
    'Power (bhp)',
    'Exterior',
    'Interior',
    'Audio',
    'Safety',
  ];

  List comValueList = [
    {
      'image': Assets.assetsImagesBCar4,
      'car_name': 'Toyota Urban Cruiser Taisor',
      'starting': '\$5,3,1900',
      'engine': '998 to 1197',
      'fuel': 'Petrol',
      'transmission': 'Manual',
      'power': '',
      'exterior': '',
      'interior': '',
      'audio': '',
      'safety': '',
    },
    {
      'image': Assets.assetsImagesBCar3,
      'car_name': 'Maruti Fronx',
      'starting': '\$3,0,000',
      'engine': '900 to 1100',
      'fuel': 'Diesel',
      'transmission': 'Automatic',
      'power': '',
      'exterior': '',
      'interior': '',
      'audio': '',
      'safety': '',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: EdgeInsets.only(top: 2.h, left: 3.w, right: 3.w, bottom: 2.h),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 30.w,
              child: DataTable(
                horizontalMargin: 0,
                dataRowColor: MaterialStateProperty.all(AppColors.whiteColor),
                headingRowColor:
                    MaterialStateProperty.all(AppColors.whiteColor),
                columnSpacing: 0,
                headingRowHeight: 22.h,
                border: TableBorder(
                  verticalInside: BorderSide(color: AppColors.borderColor),
                  horizontalInside: BorderSide(color: AppColors.borderColor),
                  right: BorderSide(color: AppColors.borderColor),
                ),
                columns: const [DataColumn(label: Text(''))],
                rows: [
                  ...comList.map(
                    (team) => DataRow(
                      cells: [
                        DataCell(
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomText(
                              text: '$team',
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkGreyColor,
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  horizontalMargin: 0,
                  dataRowColor: MaterialStateProperty.all(AppColors.whiteColor),
                  headingRowColor: MaterialStateProperty.all(
                    AppColors.whiteColor,
                  ),
                  columnSpacing: 0,
                  headingRowHeight: 22.h,
                  border: const TableBorder(
                    verticalInside: BorderSide(color: AppColors.borderColor),
                    horizontalInside: BorderSide(color: AppColors.borderColor),
                  ),
                  columns: comValueList.toList().map((data) {
                    return DataColumn(
                      headingRowAlignment: MainAxisAlignment.center,
                      label: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomAssetImage(
                              image: data['image'],
                              height: 15.h,
                              width: 15.h,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: CustomText(
                                text: data['car_name'],
                                fontSize: 15.sp,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  rows: [
                    tableDataWidget(data: 'starting'),
                    tableDataWidget(data: 'engine'),
                    tableDataWidget(data: 'fuel'),
                    tableDataWidget(data: 'transmission'),
                    tableDataWidget(data: 'power'),
                    tableDataWidget(data: 'exterior'),
                    tableDataWidget(data: 'interior'),
                    tableDataWidget(data: 'audio'),
                    tableDataWidget(data: 'safety'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DataRow tableDataWidget({data}) {
    return DataRow(
      cells: comValueList.toList().map((e) {
        return DataCell(Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: CustomText(
              text: e[data],
              fontWeight: FontWeight.bold,
              fontSize: 13.sp,
            ),
          ),
        ));
      }).toList(),
    );
  }
}

class PopularUpcomingCarsWidget extends StatefulWidget {
  const PopularUpcomingCarsWidget({super.key});

  @override
  State<PopularUpcomingCarsWidget> createState() =>
      _PopularUpcomingCarsWidgetState();
}

class _PopularUpcomingCarsWidgetState extends State<PopularUpcomingCarsWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
    CarController controller = Get.find();


  List<Widget> myTabs = [
    Tab(
      text: 'Hatchback',
    ),
    Tab(text: 'Sedan'),
    Tab(text: 'Luxury'),
    Tab(text: 'SUV'),
    Tab(text: 'MUV'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   return SizedBox(
      height: 60.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Custom TabBar
            TabBar(
              controller: _tabController,
              tabs: myTabs,
              isScrollable: true,
              unselectedLabelColor: AppColors.darkGreyColor,
              indicatorColor: AppColors.appColor, // Active tab indicator color
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 3,
              mouseCursor: MouseCursor.defer,
              physics: const NeverScrollableScrollPhysics(),
              labelColor: AppColors.appColor, // Selected tab label color
              labelStyle: TextStyle(
                color: AppColors.appColor,
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),
            ),
            GapH(2.h),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: List.generate(
                  5,
                  (index) => ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Container(
                            width: 75.w,
                            padding: EdgeInsets.all(15.sp),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.transparentColor,
                              ),
                              borderRadius: BorderRadius.circular(15.sp),
                            ),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: 'Maruti Suzuki Swift',
                                  fontWeight: FontWeight.w700,
                                ),
                                GapH(0.5.h),
                                CustomText(
                                  text: 'Hatchback - Manual - 1/5 Variants',
                                  fontSize: 15.sp,
                                  color: AppColors.greyColor,
                                ),
                                GapH(2.h),
                                CustomAssetImage(
                                  image: Assets.assetsImagesCar,
                                  width: 70.w,
                                ),
                                GapH(1.h),
                                CustomText(
                                  fontSize: 17.5.sp,
                                  text: '1.2 Smart Plus',
                                  fontWeight: FontWeight.w700,
                                ),
                                GapH(0.5.h),
                                CustomText(
                                  text:
                                      'Petrol - Manual - Available in 4 colors',
                                  fontSize: 15.5.sp,
                                  color: AppColors.darkGreyColor,
                                ),

                                GapH(1.5.h),
                                CustomText(
                                  text: '\$9999.52',
                                  fontSize: 19.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                                GapH(1.5.h),

                                CustomButton(
                                  text: 'Request More Info',
                                  fontSize: 15.sp,
                                  borderColor: AppColors.appColor,
                                  buttonColor: Colors.transparent,
                                  textColor: AppColors.appColor,
                                  borderWidth: 1,
                                  onTap: () {
                                    if (Storage.instance.getToken() != null) {
                                      requestInfoDialog();
                                    } else {
                                      Get.toNamed(Routes.loginScreen);
                                    }
                                  },
                                ),
                                GapH(1.h),
                                CustomButton(
                                  text: 'See Details',
                                  fontSize: 15.sp,
                                  onTap:
                                      () => Get.toNamed(Routes.carDetailScreen),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              width: 26.w,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: AppColors.redColor,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15.sp),
                                  bottomLeft: Radius.circular(15.sp),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.star_border,
                                    color: AppColors.whiteColor,
                                    size: 17.sp,
                                  ),
                                  GapW(1.w),
                                  CustomText(
                                    text: 'Bestseller',
                                    fontSize: 15.sp,
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return GapW(5.w);
                    },
                    itemCount: 10,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void saveInquiryDialog() {
    Get.dialog(
      barrierDismissible: false,
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 10.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: CustomText(
                      text:
                          'Thank you for your inquiry. You will receive a text or call from the dealer shortly.',
                      textAlign: TextAlign.center,
                      fontSize: 14.sp,
                      color: AppColors.darkGreyColor,
                    ),
                  ),
                  GapH(2.5.h),
                  CustomAssetImage(image: Assets.assetsImagesCarOnRoad),
                  GapH(3.5.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: CustomButton(
                      padding: EdgeInsets.symmetric(vertical: 0.8.h),
                      text: 'Continue',
                      borderRadius: BorderRadius.circular(3),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      onTap: () => Get.back(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void requestInfoDialog() {
    Get.dialog(
      barrierDismissible: false,
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 5.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 1.8.h),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 1.h),

                      width: double.infinity,
                      child: Stack(
                        children: [
                          Center(
                            child: CustomText(
                              text: 'Request More Information',
                              fontWeight: FontWeight.w700,
                              fontSize: 17.sp,
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () => Get.back(),
                              child: Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.dividerColor,
                                  border: Border.all(
                                    color: AppColors.offWhiteColor,
                                    width: 1,
                                  ),
                                ),
                                child: CustomAssetImage(
                                  image: Assets.assetsImagesCross,
                                  color: AppColors.blackColor,
                                  height: 0.9.h,
                                  width: 0.9.h,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  CustomDivider(),
                  GapH(0.5.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: CustomText(text: 'Hello, my name is'),
                              ),
                              Expanded(
                                child: CustomTextfield(
                                  controller: controller.firstNameController,
                                  hintText: 'First Name',
                                ),
                              ),
                            ],
                          ),
                          GapH(0.5.h),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextfield(
                                  controller: controller.lastNameController,
                                  hintText: 'Last Name',
                                ),
                              ),
                              GapW(3.w),
                              Expanded(child: CustomText(text: 'and')),
                            ],
                          ),
                          GapH(1.5.h),
                          CustomText(
                            text: '2020 Jeep Wrangler Rubicon . 4WD.',
                            fontWeight: FontWeight.w700,
                          ),
                          GapH(1.5.h),
                          Row(
                            children: [
                              Flexible(
                                fit: FlexFit.loose,
                                child: CustomText(text: 'In the'),
                              ),
                              GapW(3.w),
                              Flexible(
                                flex: 3,
                                fit: FlexFit.loose,
                                child: CustomTextfield(
                                  controller: controller.contactNoController,
                                  hintText: '77084 77084',
                                ),
                              ),
                              GapW(3.w),
                              Flexible(
                                fit: FlexFit.loose,
                                child: CustomText(text: 'area.'),
                              ),
                            ],
                          ),
                          GapH(1.h),
                          CustomText(text: 'You can reach me by email at'),
                          GapH(1.2.h),
                          CustomTextfield(
                            controller: controller.emailController,
                            hintText: 'Email Address',
                          ),
                          GapH(1.2.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                fit: FlexFit.loose,
                                child: CustomText(text: 'or by Zip code'),
                              ),
                              Flexible(
                                fit: FlexFit.loose,
                                child: CustomTextfield(
                                  controller: controller.zipCodeController,
                                  hintText: '183251',
                                ),
                              ),
                              Flexible(
                                fit: FlexFit.loose,
                                child: CustomText(text: 'Thank you!'),
                              ),
                            ],
                          ),
                          GapH(2.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Transform.scale(
                                scale: 1.2,
                                child: Checkbox(
                                  activeColor: AppColors.appColor,
                                  visualDensity: VisualDensity.compact,
                                  side: BorderSide(
                                    width: 1.3,
                                    color: AppColors.greyColor,
                                  ),
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  fillColor: WidgetStateProperty.resolveWith((
                                    states,
                                  ) {
                                    if (!states.contains(
                                      WidgetState.selected,
                                    )) {
                                      return Colors.white;
                                    }
                                    return null;
                                  }),
                                  shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  value: controller.agreeRequestInfo.value,
                                  onChanged:
                                      (value) =>
                                          controller.agreeRequestInfo.value =
                                              !controller
                                                  .agreeRequestInfo
                                                  .value,
                                ),
                              ),
                              GapW(1.2.w),
                              Expanded(
                                child: CustomText(
                                  fontSize: 14.sp,
                                  height: 1.5,
                                  color: AppColors.darkGreyColor,
                                  text:
                                      'I agree to receive text messages from YELE and calls from the dealership',
                                ),
                              ),
                            ],
                          ),
                          GapH(2.h),
                          Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                  onTap: () => Get.back(),
                                  text: 'Cancel',
                                  borderColor: AppColors.appColor,
                                  buttonColor: AppColors.whiteColor,
                                  textColor: AppColors.appColor,
                                  borderWidth: 1.2,
                                  borderRadius: BorderRadius.circular(10),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 1.2.h,
                                  ),
                                ),
                              ),
                              GapW(3.w),
                              Expanded(
                                child: CustomButton(
                                  onTap: () {
                                    Get.back();
                                    saveInquiryDialog();
                                  },
                                  text: 'Save',
                                  borderRadius: BorderRadius.circular(10),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 1.2.h,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}