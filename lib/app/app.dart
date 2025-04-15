import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/bindings.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/config/constants/app_material_color.dart';
import 'package:yele/src/config/constants/app_strings.dart';
import 'package:yele/src/config/router/app_pages.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          scrollBehavior: ScrollConfiguration.of(
            context,
          ).copyWith(overscroll: false, physics: const ClampingScrollPhysics()),
          debugShowCheckedModeBanner: false,
          title: AppStrings.appName,
          initialBinding: InitailBinding(),
          getPages: AppPages.routes,
          initialRoute: AppPages.initialRoute,
          theme: ThemeData(
            useMaterial3: false,
            primaryColor: AppColors.appColor,
            primarySwatch: AppMaterialColor.primaryMaterialColor,
            scaffoldBackgroundColor: AppColors.whiteColor,
            fontFamily: AppStrings.fontFamily,
            appBarTheme: const AppBarTheme(
              scrolledUnderElevation: 0.0,
              backgroundColor: AppColors.whiteColor,
            ),
          ),
        );
      },
    );
  }
}
