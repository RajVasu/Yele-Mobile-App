class GetCarListModel {
  Links? links;
  int? total;
  int? page;
  int? pageSize;
  int? totalPages;
  bool? success;
  List<CarListData>? carListData;

  GetCarListModel({
    this.links,
    this.total,
    this.page,
    this.pageSize,
    this.totalPages,
    this.success,
    this.carListData,
  });

  GetCarListModel.fromJson(Map<String, dynamic> json) {
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    total = json['total'];
    page = json['page'];
    pageSize = json['page_size'];
    totalPages = json['total_pages'];
    success = json['success'];
    if (json['data'] != null) {
      carListData = <CarListData>[];
      json['data'].forEach((v) {
        carListData!.add(CarListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (links != null) {
      data['links'] = links!.toJson();
    }
    data['total'] = total;
    data['page'] = page;
    data['page_size'] = pageSize;
    data['total_pages'] = totalPages;
    data['success'] = success;
    if (carListData != null) {
      data['data'] = carListData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Links {
  dynamic next;
  dynamic previous;

  Links({this.next, this.previous});

  Links.fromJson(Map<String, dynamic> json) {
    next = json['next'];
    previous = json['previous'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['next'] = next;
    data['previous'] = previous;
    return data;
  }
}

class CarListData {
  int? carId;
  String? carName;
  String? carModel;
  String? carBrand;
  String? carType;
  String? carFuelType;
  String? carTransmission;
  String? price;
  String? carColor;
  String? carImage;

  CarListData({
    this.carId,
    this.carName,
    this.carModel,
    this.carBrand,
    this.carType,
    this.carFuelType,
    this.carTransmission,
    this.price,
    this.carColor,
    this.carImage,
  });

  CarListData.fromJson(Map<String, dynamic> json) {
    carId = json['car_id'];
    carName = json['car_name'];
    carModel = json['car_model'];
    carBrand = json['car_brand'];
    carType = json['car_type'];
    carFuelType = json['car_fuel_type'];
    carTransmission = json['car_transmission'];
    price = json['price'];
    carColor = json['car_color'];
    carImage = json['car_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['car_id'] = carId;
    data['car_name'] = carName;
    data['car_model'] = carModel;
    data['car_brand'] = carBrand;
    data['car_type'] = carType;
    data['car_fuel_type'] = carFuelType;
    data['car_transmission'] = carTransmission;
    data['price'] = price;
    data['car_color'] = carColor;
    data['car_image'] = carImage;
    return data;
  }
}
