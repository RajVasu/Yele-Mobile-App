// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
// import 'package:yele/src/config/constants/app_colors.dart';
// import 'package:yele/src/config/constants/assets.dart';
// import 'package:yele/src/core/utils/countries_list.dart';
// import 'package:yele/src/core/widgets/custom_text.dart';
// import 'package:yele/src/core/widgets/gap.dart';
// import 'package:yele/src/features/auth/register/controller/register_controller.dart';

// class CountriesPicker extends StatefulWidget {
//   String phonrNumber;
//   CountriesPicker({super.key, required this.phonrNumber});

//   @override
//   State<CountriesPicker> createState() => _CountriesPickerState();
// }

// class _CountriesPickerState extends State<CountriesPicker> {
//   RegisterController registerController = Get.find();
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         showDialogOnButtonPressing(context, phonrNumber: widget.phonrNumber);
//       },
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           GapW(3.5.w),
//           Container(
//             height: 25,
//             width: 35,
//             decoration: BoxDecoration(
//               color: Colors.amber,
//               borderRadius: BorderRadius.circular(3),
//               image: DecorationImage(
//                 image: AssetImage(
//                   'assets/flags/${registerController.flag.value}.png',
//                 ),
//                 fit: BoxFit.fill,
//               ),
//             ),
//           ),
//           GapW(1.5.w),
//           CustomText(
//             // text: '+91',
//             text: registerController.countryCode.value,
//             fontSize: 15.sp,
//             fontWeight: FontWeight.w500,
//           ),
//           GapW(1.w),
//           SizedBox(child: Image.asset(Assets.assetsIconsDropdown2, scale: 5)),
//           GapW(2.w),
//           Container(
//             color: AppColors.borderColor,
//             width: 1,
//             height: 30,
//             padding: EdgeInsets.symmetric(vertical: 15),
//           ),
//           GapW(2.w),
//         ],
//       ),
//     );
//   }

//   showDialogOnButtonPressing(
//     BuildContext context, {
//     required String phonrNumber,
//   }) => showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return Dialog(
//         insetPadding: EdgeInsets.symmetric(horizontal: 6.w),
//         child: ListView.builder(
//           itemCount: countries.length,
//           itemBuilder:
//               (context, index) => GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     registerController.countryCode.value =
//                         countries[index].dialCode;
//                   });
//                   phonrNumber = phonrNumber.split(" ").last;
//                   registerController.numberLenght.value =
//                       countries[index].maxLength.toString();
//                   registerController.flag.value =
//                       countries[index].code.toLowerCase();
//                   Navigator.of(context).pop();
//                 },
//                 child: ListTile(
//                   leading: Container(
//                     height: 4.h,
//                     width: 6.h,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       image: DecorationImage(
//                         image: AssetImage(
//                           'assets/flags/${countries[index].code.toLowerCase()}.png',
//                         ),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   title: CustomText(text: countries[index].name),
//                   subtitle: CustomText(text: countries[index].dialCode),
//                 ),
//               ),
//         ),
//       );
//     },
//   );
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/config/constants/assets.dart';
import 'package:yele/src/core/utils/countries_list.dart';
import 'package:yele/src/core/widgets/custom_text.dart';
import 'package:yele/src/core/widgets/gap.dart';

class CountriesPicker extends StatefulWidget {
  String phonrNumber;
  RxString flag, countryCode, numberLenght;
  CountriesPicker({
    super.key,
    required this.phonrNumber,
    required this.flag,
    required this.countryCode,
    required this.numberLenght,
  });

  @override
  State<CountriesPicker> createState() => _CountriesPickerState();
}

class _CountriesPickerState extends State<CountriesPicker> {
  // RegisterController registerController = Get.find();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialogOnButtonPressing(context, phonrNumber: widget.phonrNumber);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GapW(3.5.w),
          Container(
            height: 25,
            width: 35,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(3),
              image: DecorationImage(
                image: AssetImage('assets/flags/${widget.flag.value}.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          GapW(1.5.w),
          CustomText(
            // text: '+91',
            text: widget.countryCode.value,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
          ),
          GapW(1.w),
          SizedBox(child: Image.asset(Assets.assetsIconsDropdown2, scale: 5)),
          GapW(2.w),
          Container(
            color: AppColors.borderColor,
            width: 1,
            height: 30,
            padding: EdgeInsets.symmetric(vertical: 15),
          ),
          GapW(2.w),
        ],
      ),
    );
  }

  showDialogOnButtonPressing(
    BuildContext context, {
    required String phonrNumber,
  }) => showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 6.w),
        child: ListView.builder(
          itemCount: countries.length,
          itemBuilder:
              (context, index) => GestureDetector(
                onTap: () {
                  setState(() {
                    widget.countryCode.value = countries[index].dialCode;
                  });
                  phonrNumber = phonrNumber.split(" ").last;
                  widget.numberLenght.value =
                      countries[index].maxLength.toString();
                  widget.flag.value = countries[index].code.toLowerCase();
                  Navigator.of(context).pop();
                },
                child: ListTile(
                  leading: Container(
                    height: 4.h,
                    width: 6.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/flags/${countries[index].code.toLowerCase()}.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: CustomText(text: countries[index].name),
                  subtitle: CustomText(text: countries[index].dialCode),
                ),
              ),
        ),
      );
    },
  );
}
