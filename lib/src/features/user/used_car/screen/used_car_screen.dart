import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/core/screens/no_internet_screen.dart';
import 'package:yele/src/core/widgets/custom_appbar.dart';
import 'package:yele/src/core/widgets/custom_bg_widget.dart';
import 'package:yele/src/core/widgets/gap.dart';
import 'package:yele/src/features/user/new_car/components/Search_car_widget.dart';
import 'package:yele/src/features/user/used_car/components/used_car_list.dart';

class UsedCarScreen extends StatefulWidget {
  const UsedCarScreen({super.key});

  @override
  State<UsedCarScreen> createState() => _UsedCarScreenState();
}

class _UsedCarScreenState extends State<UsedCarScreen> {
  @override
  Widget build(BuildContext context) {
    return NoInternetScreen(child: UsedCarView());
  }
}

class UsedCarView extends StatefulWidget {
  const UsedCarView({super.key});

  @override
  State<UsedCarView> createState() => _UsedCarViewState();
}

class _UsedCarViewState extends State<UsedCarView> {
  @override
  Widget build(BuildContext context) {
    return CustomBgWidget(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      appBar: customAppBar(title: 'Used Car Listing', isBack: false),
      body: Column(
        children: [
          GapH(2.h),
          SearchCarWidget(),
          GapH(2.h),
          Expanded(child: UsedCarList()),
        ],
      ),
    );
  }
}
