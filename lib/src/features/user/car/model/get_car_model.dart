class GetCarModel {
  int? carId;
  String? ownerName;
  String? carName;
  int? carBrand;
  String? carBrandName;
  int? carModelYear;
  String? carModel;
  int? carType;
  String? carTypeName;
  String? rto;
  String? transmission;
  String? owners;
  int? seats;
  String? kmDriven;
  String? regNumber;
  String? engineCapacity;
  String? fuelType;
  int? spareKey;
  String? carPrice;
  String? color;
  String? power;
  String? carCondition;
  String? insuranceStartDate;
  String? insuranceEndDate;
  String? carOwnerType;
  dynamic dealer;
  int? admin;
  String? adminName;
  String? specification;
  List<Features>? features;
  bool? isActive;
  List<CarImages>? carImages;

  GetCarModel({
    this.carId,
    this.ownerName,
    this.carName,
    this.carBrand,
    this.carBrandName,
    this.carModelYear,
    this.carModel,
    this.carType,
    this.carTypeName,
    this.rto,
    this.transmission,
    this.owners,
    this.seats,
    this.kmDriven,
    this.regNumber,
    this.engineCapacity,
    this.fuelType,
    this.spareKey,
    this.carPrice,
    this.color,
    this.power,
    this.carCondition,
    this.insuranceStartDate,
    this.insuranceEndDate,
    this.carOwnerType,
    this.dealer,
    this.admin,
    this.adminName,
    this.specification,
    this.features,
    this.isActive,
    this.carImages,
  });

  GetCarModel.fromJson(Map<String, dynamic> json) {
    carId = json['car_id'];
    ownerName = json['owner_name'];
    carName = json['car_name'];
    carBrand = json['car_brand'];
    carBrandName = json['car_brand_name'];
    carModelYear = json['car_model_year'];
    carModel = json['car_model'];
    carType = json['car_type'];
    carTypeName = json['car_type_name'];
    rto = json['rto'];
    transmission = json['transmission'];
    owners = json['owners'];
    seats = json['seats'];
    kmDriven = json['km_driven'];
    regNumber = json['reg_number'];
    engineCapacity = json['engine_capacity'];
    fuelType = json['fuel_type'];
    spareKey = json['spare_key'];
    carPrice = json['car_price'];
    color = json['color'];
    power = json['power'];
    carCondition = json['car_condition'];
    insuranceStartDate = json['insurance_start_date'];
    insuranceEndDate = json['insurance_end_date'];
    carOwnerType = json['car_owner_type'];
    dealer = json['dealer'];
    admin = json['admin'];
    adminName = json['admin_name'];
    specification = json['specification'];
    if (json['features'] != null) {
      features = <Features>[];
      json['features'].forEach((v) {
        features!.add(Features.fromJson(v));
      });
    }
    isActive = json['is_active'];
    if (json['car_images'] != null) {
      carImages = <CarImages>[];
      json['car_images'].forEach((v) {
        carImages!.add(CarImages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['car_id'] = carId;
    data['owner_name'] = ownerName;
    data['car_name'] = carName;
    data['car_brand'] = carBrand;
    data['car_brand_name'] = carBrandName;
    data['car_model_year'] = carModelYear;
    data['car_model'] = carModel;
    data['car_type'] = carType;
    data['car_type_name'] = carTypeName;
    data['rto'] = rto;
    data['transmission'] = transmission;
    data['owners'] = owners;
    data['seats'] = seats;
    data['km_driven'] = kmDriven;
    data['reg_number'] = regNumber;
    data['engine_capacity'] = engineCapacity;
    data['fuel_type'] = fuelType;
    data['spare_key'] = spareKey;
    data['car_price'] = carPrice;
    data['color'] = color;
    data['power'] = power;
    data['car_condition'] = carCondition;
    data['insurance_start_date'] = insuranceStartDate;
    data['insurance_end_date'] = insuranceEndDate;
    data['car_owner_type'] = carOwnerType;
    data['dealer'] = dealer;
    data['admin'] = admin;
    data['admin_name'] = adminName;
    data['specification'] = specification;
    if (features != null) {
      data['features'] = features!.map((v) => v.toJson()).toList();
    }
    data['is_active'] = isActive;
    if (carImages != null) {
      data['car_images'] = carImages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Features {
  String? feature;
  String? description;

  Features({this.feature, this.description});

  Features.fromJson(Map<String, dynamic> json) {
    feature = json['feature'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['feature'] = feature;
    data['description'] = description;
    return data;
  }
}

class CarImages {
  int? imageId;
  int? car;
  String? carName;
  String? image;
  bool? isActive;

  CarImages({this.imageId, this.car, this.carName, this.image, this.isActive});

  CarImages.fromJson(Map<String, dynamic> json) {
    imageId = json['image_id'];
    car = json['car'];
    carName = json['car_name'];
    image = json['image'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image_id'] = imageId;
    data['car'] = car;
    data['car_name'] = carName;
    data['image'] = image;
    data['is_active'] = isActive;
    return data;
  }
}
