import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yele/src/config/router/routes.dart';
import 'package:yele/src/core/screens/no_page_found_screen.dart';
import 'package:yele/src/features/auth/forgot/screen/forgot_password_screen.dart';
import 'package:yele/src/features/auth/forgot/screen/new_password_screen.dart';
import 'package:yele/src/features/auth/forgot/screen/verify_otp_screen.dart';
import 'package:yele/src/features/auth/login/bindings/login_bindings.dart';
import 'package:yele/src/features/auth/login/screen/login_screen.dart';
import 'package:yele/src/features/auth/privacy_policy_screen.dart';
import 'package:yele/src/features/auth/register/bindings/register_bindings.dart';
import 'package:yele/src/features/auth/register/screen/dealer_app_request.dart';
import 'package:yele/src/features/auth/register/screen/driver_register.dart';
import 'package:yele/src/features/auth/register/screen/register_screen.dart';
import 'package:yele/src/features/auth/register/screen/user_register.dart';
import 'package:yele/src/features/dealer/dealer_home/bindings/dealer_home_bindings.dart';
import 'package:yele/src/features/dealer/dealer_home/screen/dealer_home_screen.dart';
import 'package:yele/src/features/driver/driver_home/bindings/driver_home_bindings.dart';
import 'package:yele/src/features/driver/driver_home/screen/driver_home_screen.dart';
import 'package:yele/src/features/onboarding/splash_screen.dart';
import 'package:yele/src/features/user/book_test_drive_screen/bindings/book_test_drive_bindings.dart';
import 'package:yele/src/features/user/book_test_drive_screen/screens/book_test_drive_screen.dart';
import 'package:yele/src/features/user/book_test_drive_screen/screens/confirmation_screen.dart';
import 'package:yele/src/features/user/book_test_drive_screen/screens/driver_progress_screen.dart';
import 'package:yele/src/features/user/booked_test_drives/bindings/booked_test_drives_bindings.dart';
import 'package:yele/src/features/user/booked_test_drives/screens/booked_test_drives_screen.dart';
import 'package:yele/src/features/user/car/bindings/car_bindings.dart';
import 'package:yele/src/features/user/car/screen/car_detail_screen.dart';
import 'package:yele/src/features/user/dashboard/bindings/dashboard_bindings.dart';
import 'package:yele/src/features/user/dashboard/screen/dashboard_screen.dart';
import 'package:yele/src/features/user/filter/bindings/filter_bindings.dart';
import 'package:yele/src/features/user/filter/screens/filter_screen.dart';
import 'package:yele/src/features/user/in_depth_car_reviews/screens/in_depth_car_reviews_screen.dart';
import 'package:yele/src/features/user/profile/bindings/profile_bindings.dart';
import 'package:yele/src/features/user/profile/screen/favorites_cars_screen.dart';
import 'package:yele/src/features/user/profile/screen/my_account_screen.dart';
import 'package:yele/src/features/user/profile/screen/reset_password_screen.dart';
import 'package:yele/src/features/user/profile/screen/saved_search_screen.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Transition transition =
    Platform.isIOS ? Transition.cupertino : Transition.native;

class AppPages {
  static const initialRoute = Routes.splashScreen;

  static final routes = [
    GetPage(
      name: Routes.noPageFoundScreen,
      page: () => NoPageFoundScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.splashScreen,
      page: () => const SplashScreen(),
      transition: transition,
    ),

    /// Authentication
    GetPage(
      name: Routes.loginScreen,
      page: () => const LoginScreen(),
      transition: transition,
      binding: LoginBindings(),
    ),
    GetPage(
      name: Routes.registerScreen,
      page: () => const RegisterScreen(),
      transition: transition,
      binding: RegisterBindings(),
    ),
    GetPage(
      name: Routes.userRegisterScreen,
      page: () => const UserRegisterScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.privacyPolicyScreen,
      page: () => const PrivacyPolicyScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.dealerAppRequestScreen,
      page: () => const DealerAppRequestScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.driverRegisterScreen,
      page: () => const DriverRegisterScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.forgotPasswordScreen,
      page: () => const ForgotPasswordScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.verifyOtpScreen,
      page: () => const VerifyOtpScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.newPasswordScreen,
      page: () => const NewPasswordScreen(),
      transition: transition,
    ),

    /// Role - User
    GetPage(
      name: Routes.dashboardScreen,
      page: () => const DashboardScreen(),
      transition: transition,
      binding: DashboardBindings(),
    ),
    GetPage(
      name: Routes.myAccountScreen,
      page: () => const MyAccountScreen(),
      transition: transition,
      binding: ProfileBindings(),
    ),
    GetPage(
      name: Routes.resetPasswordScreen,
      page: () => const ResetPasswordScreen(),
      transition: transition,
      binding: ProfileBindings(),
    ),
    GetPage(
      name: Routes.carDetailScreen,
      page: () => const CarDetailScreen(),
      transition: transition,
      binding: CarBindings(),
    ),
    GetPage(
      name: Routes.bookedTestDrivesScreen,
      page: () => BookedTestDrivesScreen(),
      transition: transition,
      binding: BookedTestDrivesBindings(),
    ),
    GetPage(
      name: Routes.filterScreen,
      page: () => FilterScreen(),
      transition: transition,
      binding: FilterBindings(),
    ),
      GetPage(
      name: Routes.bookTestDriveScreen,
      page: () => BookTestDriveScreen(),
      transition: transition,
      binding: BookTestDriveBindings(),
    ),
    GetPage(
      name: Routes.confirmationScreen,
      page: () => ConfirmationScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.driverProgressScreen,
      page: () => DriverProgressScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.savedSearchScreen,
      page: () => SavedSearchScreen(),
      transition: transition,
      binding: ProfileBindings(),
    ),
    GetPage(
      name: Routes.favoriteCarsScreen,
      page: () => FavoriteCarsScreen(),
      transition: transition,
      binding: ProfileBindings(),
    ),
    GetPage(
      name: Routes.inDepthCarReviewsScreen,
      page: () => InDepthCarReviewsScreen(),
      transition: transition,
      binding: ProfileBindings(),
    ),


    /// Role - Dealer
    GetPage(
      name: Routes.dealerHomeScreen,
      page: () => DealerHomeScreen(),
      transition: transition,
      binding: DealerHomeBindings(),
    ),

    /// Role - Driver
    GetPage(
      name: Routes.driverHomeScreen,
      page: () => DriverHomeScreen(),
      transition: transition,
      binding: DriverHomeBindings(),
    ),
  ];
}
