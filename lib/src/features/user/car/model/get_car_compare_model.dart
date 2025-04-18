class GetCarCompareModel {
  int? carId;
  String? carName;
  String? carType;
  String? carBrand;
  String? carFuelType;
  String? carTransmission;
  String? price;
  String? carEngine;
  String? carPower;
  String? carImage;
  String? exterior;
  String? interior;
  String? safety;
  String? audio;

  GetCarCompareModel({
    this.carId,
    this.carName,
    this.carType,
    this.carBrand,
    this.carFuelType,
    this.carTransmission,
    this.price,
    this.carEngine,
    this.carPower,
    this.carImage,
    this.exterior,
    this.interior,
    this.safety,
    this.audio,
  });

  GetCarCompareModel.fromJson(Map<String, dynamic> json) {
    carId = json['car_id'];
    carName = json['car_name'];
    carType = json['car_type'];
    carBrand = json['car_brand'];
    carFuelType = json['car_fuel_type'];
    carTransmission = json['car_transmission'];
    price = json['price'];
    carEngine = json['car_engine'];
    carPower = json['car_power'];
    carImage = json['car_image'];
    exterior = json['Exterior'];
    interior = json['Interior'];
    safety = json['Safety'];
    audio = json['Audio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['car_id'] = carId;
    data['car_name'] = carName;
    data['car_type'] = carType;
    data['car_brand'] = carBrand;
    data['car_fuel_type'] = carFuelType;
    data['car_transmission'] = carTransmission;
    data['price'] = price;
    data['car_engine'] = carEngine;
    data['car_power'] = carPower;
    data['car_image'] = carImage;
    data['Exterior'] = exterior;
    data['Interior'] = interior;
    data['Safety'] = safety;
    data['Audio'] = audio;
    return data;
  }
}
