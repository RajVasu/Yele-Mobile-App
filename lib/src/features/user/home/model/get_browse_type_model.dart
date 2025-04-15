class GetBrowseTypeModel {
  int? typeId;
  String? typeName;
  String? carImage;

  GetBrowseTypeModel({this.typeId, this.typeName, this.carImage});

  GetBrowseTypeModel.fromJson(Map<String, dynamic> json) {
    typeId = json['type_id'];
    typeName = json['type_name'];
    carImage = json['car_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type_id'] = typeId;
    data['type_name'] = typeName;
    data['car_image'] = carImage;
    return data;
  }
}
