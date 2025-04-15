import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/api/endpoints.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/core/widgets/custom_text.dart';
import 'package:yele/src/core/widgets/gap.dart';
import 'package:yele/src/features/user/home/controller/user_home_controller.dart';

class CarMakerWidget extends StatefulWidget {
  const CarMakerWidget({super.key});

  @override
  State<CarMakerWidget> createState() => _CarMakerWidgetState();
}

class _CarMakerWidgetState extends State<CarMakerWidget> {
  final UserHomeController _userHomeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: CustomText(
            text: 'Pick Your Car Make',
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        GapH(15),
        CarouselSlider(
          items: _userHomeController.carBrandList.map((e) {
            return Container(
                width: 35.w,
                padding: EdgeInsets.symmetric(vertical: 3.w, horizontal: 2.h),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderColor),
                  borderRadius: BorderRadius.circular(13.sp),
                ),
                child: Image.network('${Endpoints.baseUrl}${e.brandLogo!}'));
          }).toList(),
          options: CarouselOptions(
            height: 6.h,
            autoPlay: true,
            viewportFraction: 0.4,
            scrollDirection: Axis.horizontal,
            autoPlayCurve: Curves.linear,
          ),
        ),

        /*  GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.5,
          ),
          itemCount: 9, // 8 car makes + "More Brands" button
          itemBuilder: (context, index) {
            if (index < 8) {
              return CarMakeCell(carMake: carMakes[index]);
            } else {
              return const MoreBrandsCell();
            }
          },
        ),
      
       */
      ],
    );
  }
}

class CarMake {
  final String name;
  final String logoPath;
  final Color logoColor;

  CarMake({
    required this.name,
    required this.logoPath,
    required this.logoColor,
  });
}

class CarMakeCell extends StatelessWidget {
  final CarMake carMake;

  const CarMakeCell({super.key, required this.carMake});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: Colors.grey.shade300),
          bottom: BorderSide(
            color: (carMake.name == 'Jeep' || carMake.name == 'Honda')
                ? Colors.transparent
                : Colors.grey.shade300,
          ),
        ),
      ),
      child: InkWell(
        onTap: () {
          debugPrint('Selected ${carMake.name}');
        },
        child: Center(child: getBrandLogo(carMake.name)),
      ),
    );
  }

  Widget getBrandLogo(String brand) {
    // In a real app, you'd use actual image assets
    // This function simulates the logos with icons for the example

    switch (brand) {
      case 'MG':
        return Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: const Center(
            child: Text(
              'MG',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        );
      case 'KIA':
        return const Text(
          'KIA',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
            letterSpacing: 1,
          ),
        );
      case 'Suzuki':
        return Icon(Icons.ac_unit, size: 60, color: Colors.grey.shade600);
      case 'Tata':
        return Icon(Icons.circle, size: 60, color: Colors.blue.shade800);
      case 'Toyota':
        return Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade600, width: 1),
          ),
          child: Center(
            child: Icon(
              Icons.trip_origin,
              size: 50,
              color: Colors.grey.shade600,
            ),
          ),
        );
      case 'Hyundai':
        return Icon(
          Icons.directions_car,
          size: 60,
          color: Colors.blue.shade800,
        );
      case 'Honda':
        return Container(
          width: 60,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: const Center(
            child: Text(
              'H',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            ),
          ),
        );
      case 'Jeep':
        return Text(
          'Jeep',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
            color: Colors.grey.shade600,
          ),
        );
      default:
        return const Icon(Icons.car_repair, size: 48);
    }
  }
}

class MoreBrandsCell extends StatelessWidget {
  const MoreBrandsCell({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: Colors.grey.shade300),
          // bottom: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: InkWell(
        onTap: () {
          debugPrint('More brands selected');
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'More Brands',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.blue.shade900,
                borderRadius: BorderRadius.circular(2),
              ),
              child: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
