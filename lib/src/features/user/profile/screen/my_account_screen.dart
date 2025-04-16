import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yele/src/config/constants/app_colors.dart';
import 'package:yele/src/config/constants/assets.dart';
import 'package:yele/src/core/screens/no_internet_screen.dart';
import 'package:yele/src/core/utils/log.dart';
import 'package:yele/src/core/widgets/custom_appbar.dart';
import 'package:yele/src/core/widgets/custom_image.dart';
import 'package:yele/src/features/user/dashboard/controller/dashboard_controller.dart';
import 'package:yele/src/features/user/profile/components/account_info_widget.dart';
import 'package:yele/src/features/user/profile/components/profile_edit_widget.dart';
import 'package:yele/src/features/user/profile/components/profile_info_widget.dart';
import 'package:yele/src/features/user/profile/controller/profile_controller.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return NoInternetScreen(child: MyAccountView());
  }
}

class MyAccountView extends StatefulWidget {
  const MyAccountView({super.key});

  @override
  State<MyAccountView> createState() => _MyAccountViewState();
}

class _MyAccountViewState extends State<MyAccountView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ProfileController _profileController = Get.find();
  DashboardController dashboardController = Get.find();
  @override
  void initState() {
    super.initState();
    _profileController.getCurrentUserData();
  }

  @override
  void dispose() {
    super.dispose();
    _profileController.clearData();
    Log.s('Dispose');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 20.h,
                      alignment: Alignment.topCenter,
                      decoration: BoxDecoration(
                        color: AppColors.appColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20.sp),
                          bottomRight: Radius.circular(20.sp),
                        ),
                      ),
                      child: customAppBar(
                        title: 'My Account',
                        actionWidget: Container(
                          padding: EdgeInsets.all(13.sp),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.borderColor),
                          ),
                          child: GestureDetector(
                            onTap: () => _onLogoutTap(context),
                            child: CustomAssetImage(
                              image: Assets.assetsIconsLogout,
                              height: 2.h,
                              width: 2.h,
                            ),
                          ),
                        ),
                      ),
                    ),
                    AccountInfoWidget(),
                    Divider(
                      thickness: 3,
                      color: AppColors.borderColor.withOpacity(0.3),
                    ),
                    ProfileInfoWidget(formKey: _formKey),
                  ],
                ),
              ),
              ProfileEditWidget(),
            ],
          ),
        ),
      ),
    );
  }

  void _onLogoutTap(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;
    FocusManager.instance.primaryFocus?.unfocus();

    // Storage.instance.clear();
    Get.back();
    dashboardController.selectedIndex.value = 0;
    await _profileController.logOut();
  }
}
