class GetDealerListModal {
  int? userId;
  String? firstName;
  String? lastName;
  String? dealership;
  String? phoneNumber;
  String? countryCode;
  String? email;
  int? userRole;
  String? userRoleName;
  String? city;
  String? state;
  String? comments;
  String? status;
  String? profileImage;
  bool? isActive;

  GetDealerListModal({
    this.userId,
    this.firstName,
    this.lastName,
    this.dealership,
    this.phoneNumber,
    this.countryCode,
    this.email,
    this.userRole,
    this.userRoleName,
    this.city,
    this.state,
    this.comments,
    this.status,
    this.profileImage,
    this.isActive,
  });

  GetDealerListModal.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    dealership = json['dealership'];
    phoneNumber = json['phone_number'];
    countryCode = json['country_code'];
    email = json['email'];
    userRole = json['user_role'];
    userRoleName = json['user_role_name'];
    city = json['city'];
    state = json['state'];
    comments = json['comments'];
    status = json['status'];
    profileImage = json['profile_image'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['dealership'] = dealership;
    data['phone_number'] = phoneNumber;
    data['country_code'] = countryCode;
    data['email'] = email;
    data['user_role'] = userRole;
    data['user_role_name'] = userRoleName;
    data['city'] = city;
    data['state'] = state;
    data['comments'] = comments;
    data['status'] = status;
    data['profile_image'] = profileImage;
    data['is_active'] = isActive;
    return data;
  }
}
