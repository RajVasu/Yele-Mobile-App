import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/api/endpoints.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/core/widgets/custom_image.dart';
import 'package:yele/src/core/widgets/custom_text.dart';
import 'package:yele/src/core/widgets/gap.dart';
import 'package:yele/src/features/user/home/controller/user_home_controller.dart';

class BrowseType extends StatefulWidget {
  const BrowseType({super.key});

  @override
  State<BrowseType> createState() => _BrowseTypeState();
}

class _BrowseTypeState extends State<BrowseType> {
  final UserHomeController _userHomeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: 'Browse By Type',
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
          GapH(20),
          GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: _userHomeController.browseTypeList.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  _userHomeController.browseTypeList[index].carImage == null
                      ? CustomNoImage()
                      : Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  '${Endpoints.baseUrl}${_userHomeController.browseTypeList[index].carImage!}'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10.sp),
                          ),
                        ),
                  Container(
                    margin: EdgeInsets.all(15),
                    padding: EdgeInsets.symmetric(
                      vertical: 1.h,
                      horizontal: 4.w,
                    ),
                    // alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(20.sp),
                    ),
                    child: CustomText(
                        text: _userHomeController
                            .browseTypeList[index].typeName!),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
