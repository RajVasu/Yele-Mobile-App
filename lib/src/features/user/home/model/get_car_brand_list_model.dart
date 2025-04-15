class GetCarBrandListModel {
  int? brandId;
  String? brandName;
  String? brandLogo;
  bool? isActive;

  GetCarBrandListModel(
      {this.brandId, this.brandName, this.brandLogo, this.isActive});

  GetCarBrandListModel.fromJson(Map<String, dynamic> json) {
    brandId = json['brand_id'];
    brandName = json['brand_name'];
    brandLogo = json['brand_logo'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['brand_id'] = brandId;
    data['brand_name'] = brandName;
    data['brand_logo'] = brandLogo;
    data['is_active'] = isActive;
    return data;
  }
}
