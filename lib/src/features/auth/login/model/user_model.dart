class UserModel {
  int? userId;
  String? firstName;
  String? lastName;
  int? userRole;
  String? userRoleName;
  String? countryCode;
  String? phoneNumber;
  String? email;
  String? address;
  String? guardianName;
  String? userLicense;
  String? guardianLicense;
  String? profileImage;
  bool? isActive;
  String? dealership;
  String? city;
  String? state;
  String? comments;
  String? status;
  int? dealer;
  String? dealerName;
  String? driverLicense;
  Token? token;
  String? message;
  String? createdAt;

  UserModel({
    this.userId,
    this.firstName,
    this.lastName,
    this.userRole,
    this.userRoleName,
    this.countryCode,
    this.phoneNumber,
    this.email,
    this.address,
    this.guardianName,
    this.userLicense,
    this.guardianLicense,
    this.profileImage,
    this.isActive,
    this.dealership,
    this.city,
    this.state,
    this.comments,
    this.status,
    this.dealer,
    this.dealerName,
    this.driverLicense,
    this.message,
    this.token,
    this.createdAt,
  });

  UserModel.fromJson(Map<String, dynamic> json, {this.message}) {
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    userRole = json['user_role'];
    userRoleName = json['user_role_name'];
    countryCode = json['country_code'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    address = json['address'];
    guardianName = json['guardian_name'];
    userLicense = json['user_license'];
    guardianLicense = json['guardian_license'];
    profileImage = json['profile_image'];
    isActive = json['is_active'];
    dealership = json['dealership'];
    city = json['city'];
    state = json['state'];
    comments = json['comments'];
    status = json['status'];
    dealer = json['dealer'];
    dealerName = json['dealer_name'];
    driverLicense = json['driver_license'];
    token = json['token'] != null ? Token.fromJson(json['token']) : null;
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['user_role'] = userRole;
    data['user_role_name'] = userRoleName;
    data['country_code'] = countryCode;
    data['phone_number'] = phoneNumber;
    data['email'] = email;
    data['address'] = address;
    data['guardian_name'] = guardianName;
    data['user_license'] = userLicense;
    data['guardian_license'] = guardianLicense;
    data['profile_image'] = profileImage;
    data['is_active'] = isActive;
    data['dealership'] = dealership;
    data['city'] = city;
    data['state'] = state;
    data['comments'] = comments;
    data['status'] = status;
    data['dealer'] = dealer;
    data['dealer_name'] = dealerName;
    data['driver_license'] = driverLicense;
    if (token != null) {
      data['token'] = token!.toJson();
    }
    data['message'] = message;
    data['created_at'] = createdAt;
    return data;
  }
}

class Token {
  String? access;

  Token({this.access});

  Token.fromJson(Map<String, dynamic> json) {
    access = json['access'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access'] = access;
    return data;
  }
}
