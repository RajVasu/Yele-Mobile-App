
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/config/constants/assets.dart';
import 'package:yele/src/core/widgets/custom_image.dart';
import 'package:yele/src/core/widgets/custom_text.dart';

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
                headingRowColor: MaterialStateProperty.all(
                  AppColors.whiteColor,
                ),
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
                  columns:
                      comValueList.toList().map((data) {
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
      cells:
          comValueList.toList().map((e) {
            return DataCell(
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: CustomText(
                    text: e[data],
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp,
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }
}
