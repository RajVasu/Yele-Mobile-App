class GetCarModelListModel {
  String? carModel;

  GetCarModelListModel({this.carModel});

  GetCarModelListModel.fromJson(Map<String, dynamic> json) {
    carModel = json['car_model'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['car_model'] = carModel;
    return data;
  }
}
