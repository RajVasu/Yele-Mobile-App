import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/core/screens/no_internet_screen.dart';
import 'package:yele/src/core/widgets/custom_appbar.dart';
import 'package:yele/src/core/widgets/custom_bg_widget.dart';
import 'package:yele/src/core/widgets/gap.dart';
import 'package:yele/src/features/user/new_car/components/Search_car_widget.dart';
import 'package:yele/src/features/user/new_car/components/new_car_list.dart';

class NewCarScreen extends StatefulWidget {
  const NewCarScreen({super.key});

  @override
  State<NewCarScreen> createState() => _NewCarScreenState();
}

class _NewCarScreenState extends State<NewCarScreen> {
  @override
  Widget build(BuildContext context) {
    return NoInternetScreen(child: NewCarView());
  }
}

class NewCarView extends StatefulWidget {
  const NewCarView({super.key});

  @override
  State<NewCarView> createState() => _NewCarViewState();
}

class _NewCarViewState extends State<NewCarView> {
  @override
  Widget build(BuildContext context) {
    return CustomBgWidget(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      appBar: customAppBar(title: 'New Car Listing', isBack: false),
      body: Column(
        children: [
          GapH(2.h),
          SearchCarWidget(),
          GapH(2.h),
          Expanded(child: NewCarList()),
        ],
      ),
    );
  }
}
