import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/config/constants/app_strings.dart';
import 'package:yele/src/config/constants/assets.dart';
import 'package:yele/src/core/utils/countries_list.dart';
import 'package:yele/src/core/widgets/custom_text.dart';
import 'package:yele/src/core/widgets/custom_text_field.dart';
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
  TextEditingController searchController = TextEditingController();
  RxList<Country> filteredCountries = RxList(
    countries,
  ); // RxList for filtered countries
  RxString searchQuery = "".obs; // Observable to store the search query

  @override
  void initState() {
    super.initState();
    searchController.addListener(_filterCountries);
  }

  // Function to filter countries based on the search query
  void _filterCountries() {
    final query = searchController.text.toLowerCase();
    searchQuery.value = query; // Store the current search query
    filteredCountries.value =
        countries.where((country) {
          return country.name.toLowerCase().contains(query) ||
              country.dialCode.contains(query);
        }).toList();
  }

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(15.sp),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextfield(
                      prefixIcon: Assets.assetsIconsSearchCar,
                      hintText: AppStrings.serach,
                      prefixIconColor: AppColors.darkGreyColor,
                      controller: searchController,
                    ),
                  ),
                  GapW(1.w),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.close,
                        color: AppColors.greyColor,
                        size: 22.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: filteredCountries.length,
                  shrinkWrap: true,
                  itemBuilder:
                      (context, index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.countryCode.value =
                                filteredCountries[index].dialCode;
                          });
                          phonrNumber = phonrNumber.split(" ").last;
                          widget.numberLenght.value =
                              filteredCountries[index].maxLength.toString();
                          widget.flag.value =
                              filteredCountries[index].code.toLowerCase();
                          filteredCountries.value = countries;
                          searchController.clear();
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
                                  'assets/flags/${filteredCountries[index].code.toLowerCase()}.png',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: CustomText(
                            text: filteredCountries[index].name,
                          ),
                          subtitle: CustomText(
                            text: filteredCountries[index].dialCode,
                          ),
                        ),
                      ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
