extension ApiImageExtension on String {
  String toApiImage() {
    return '${Endpoints.baseUrl}/$this';
  }
}

class Endpoints {
  static const String baseUrl = 'http://10.0.128.25:8001'; // local
  // static const String baseUrl =
  //     'https://yeleapi.vasundharasolutions.com'; // Testing

  // ****************************************** Auth ****************************************** //

  static const String login = '$baseUrl/api/v1/user/user_login';

  static const String sendOtp = '$baseUrl/api/v1/user/send_otp';
  static const String verifyOtp = '$baseUrl/api/v1/user/verify_otp';
  static const String forgotPassword = '$baseUrl/api/v1/user/forget_password';

  static const String userRegister = '$baseUrl/api/v1/user/user_register';
  static const String sendMail = '$baseUrl/api/v1/user/send_mail';
  static const String verifyMail = '$baseUrl/api/v1/user/verify_email';

  static const String dealerRegister = '$baseUrl/api/v1/dealer/dealer_register';

  static const String driverRegister = '$baseUrl/api/v1/driver/driver_register';
  static const String driverDealerList = '$baseUrl/api/v1/driver/dealer_list';

  // ****************************************** User Role ****************************************** //

  static const String userProfile = '$baseUrl/api/v1/user/user_profile';
  static const String userLogout = '$baseUrl/api/v1/user/user_logout';
  static const String resetPassword = '$baseUrl/api/v1/user/change_password';
  static const String carBrandList = '$baseUrl/api/v1/user/car_brand_list';
  static const String carModelList = '$baseUrl/api/v1/user/car_model_list';
  static const String carTypeList = '$baseUrl/api/v1/user/car_type_list';
  static const String carList = '$baseUrl/api/v1/user/car_list';
  static const String carDetail = '$baseUrl/api/v1/user/car_detail';
}
