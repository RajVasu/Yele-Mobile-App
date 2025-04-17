class GetFilterModel {
  List<Brand>? brand;
  List<Model>? model;
  List<ModelYear>? modelYear;
  List<Rto>? rto;
  List<BodyType>? bodyType;
  List<Transmission>? transmission;
  List<Owners>? owners;
  List<Seats>? seats;
  List<KmsDriven>? kmsDriven;
  List<Color>? color;
  List<FuelType>? fuelType;
  Budget? budget;

  GetFilterModel({
    this.brand,
    this.model,
    this.modelYear,
    this.rto,
    this.bodyType,
    this.transmission,
    this.owners,
    this.seats,
    this.kmsDriven,
    this.color,
    this.fuelType,
    this.budget,
  });

  GetFilterModel.fromJson(Map<String, dynamic> json) {
    if (json['brand'] != null) {
      brand = <Brand>[];
      json['brand'].forEach((v) {
        brand!.add(Brand.fromJson(v));
      });
    }
    if (json['model'] != null) {
      model = <Model>[];
      json['model'].forEach((v) {
        model!.add(Model.fromJson(v));
      });
    }
    if (json['model_year'] != null) {
      modelYear = <ModelYear>[];
      json['model_year'].forEach((v) {
        modelYear!.add(ModelYear.fromJson(v));
      });
    }
    if (json['rto'] != null) {
      rto = <Rto>[];
      json['rto'].forEach((v) {
        rto!.add(Rto.fromJson(v));
      });
    }
    if (json['body_type'] != null) {
      bodyType = <BodyType>[];
      json['body_type'].forEach((v) {
        bodyType!.add(BodyType.fromJson(v));
      });
    }
    if (json['transmission'] != null) {
      transmission = <Transmission>[];
      json['transmission'].forEach((v) {
        transmission!.add(Transmission.fromJson(v));
      });
    }
    if (json['owners'] != null) {
      owners = <Owners>[];
      json['owners'].forEach((v) {
        owners!.add(Owners.fromJson(v));
      });
    }
    if (json['seats'] != null) {
      seats = <Seats>[];
      json['seats'].forEach((v) {
        seats!.add(Seats.fromJson(v));
      });
    }
    if (json['kms_driven'] != null) {
      kmsDriven = <KmsDriven>[];
      json['kms_driven'].forEach((v) {
        kmsDriven!.add(KmsDriven.fromJson(v));
      });
    }
    if (json['color'] != null) {
      color = <Color>[];
      json['color'].forEach((v) {
        color!.add(Color.fromJson(v));
      });
    }
    if (json['fuel_type'] != null) {
      fuelType = <FuelType>[];
      json['fuel_type'].forEach((v) {
        fuelType!.add(FuelType.fromJson(v));
      });
    }
    budget = json['budget'] != null ? Budget.fromJson(json['budget']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (brand != null) {
      data['brand'] = brand!.map((v) => v.toJson()).toList();
    }
    if (model != null) {
      data['model'] = model!.map((v) => v.toJson()).toList();
    }
    if (modelYear != null) {
      data['model_year'] = modelYear!.map((v) => v.toJson()).toList();
    }
    if (rto != null) {
      data['rto'] = rto!.map((v) => v.toJson()).toList();
    }
    if (bodyType != null) {
      data['body_type'] = bodyType!.map((v) => v.toJson()).toList();
    }
    if (transmission != null) {
      data['transmission'] = transmission!.map((v) => v.toJson()).toList();
    }
    if (owners != null) {
      data['owners'] = owners!.map((v) => v.toJson()).toList();
    }
    if (seats != null) {
      data['seats'] = seats!.map((v) => v.toJson()).toList();
    }
    if (kmsDriven != null) {
      data['kms_driven'] = kmsDriven!.map((v) => v.toJson()).toList();
    }
    if (color != null) {
      data['color'] = color!.map((v) => v.toJson()).toList();
    }
    if (fuelType != null) {
      data['fuel_type'] = fuelType!.map((v) => v.toJson()).toList();
    }
    if (budget != null) {
      data['budget'] = budget!.toJson();
    }
    return data;
  }
}

class Brand {
  int? brandId;
  String? brandName;
  int? count;

  Brand({this.brandId, this.brandName, this.count});

  Brand.fromJson(Map<String, dynamic> json) {
    brandId = json['brand_id'];
    brandName = json['brand_name'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['brand_id'] = brandId;
    data['brand_name'] = brandName;
    data['count'] = count;
    return data;
  }
}

class Model {
  String? modelName;
  int? count;

  Model({this.modelName, this.count});

  Model.fromJson(Map<String, dynamic> json) {
    modelName = json['model_name'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['model_name'] = modelName;
    data['count'] = count;
    return data;
  }
}

class ModelYear {
  int? modelYear;
  int? count;

  ModelYear({this.modelYear, this.count});

  ModelYear.fromJson(Map<String, dynamic> json) {
    modelYear = json['model_year'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['model_year'] = modelYear;
    data['count'] = count;
    return data;
  }
}

class Rto {
  String? rtoName;
  int? count;

  Rto({this.rtoName, this.count});

  Rto.fromJson(Map<String, dynamic> json) {
    rtoName = json['rto_name'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rto_name'] = rtoName;
    data['count'] = count;
    return data;
  }
}

class BodyType {
  String? typeName;
  int? count;

  BodyType({this.typeName, this.count});

  BodyType.fromJson(Map<String, dynamic> json) {
    typeName = json['type_name'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type_name'] = typeName;
    data['count'] = count;
    return data;
  }
}

class Transmission {
  String? transmissionType;
  int? count;

  Transmission({this.transmissionType, this.count});

  Transmission.fromJson(Map<String, dynamic> json) {
    transmissionType = json['transmission_type'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['transmission_type'] = transmissionType;
    data['count'] = count;
    return data;
  }
}

class Owners {
  String? owner;
  int? count;

  Owners({this.owner, this.count});

  Owners.fromJson(Map<String, dynamic> json) {
    owner = json['owner'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['owner'] = owner;
    data['count'] = count;
    return data;
  }
}

class Seats {
  int? seatNumber;
  int? count;

  Seats({this.seatNumber, this.count});

  Seats.fromJson(Map<String, dynamic> json) {
    seatNumber = json['seat_number'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['seat_number'] = seatNumber;
    data['count'] = count;
    return data;
  }
}

class KmsDriven {
  String? kmsDriven;
  int? count;

  KmsDriven({this.kmsDriven, this.count});

  KmsDriven.fromJson(Map<String, dynamic> json) {
    kmsDriven = json['kms_driven'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kms_driven'] = kmsDriven;
    data['count'] = count;
    return data;
  }
}

class Color {
  String? colorName;
  int? count;

  Color({this.colorName, this.count});

  Color.fromJson(Map<String, dynamic> json) {
    colorName = json['color_name'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['color_name'] = colorName;
    data['count'] = count;
    return data;
  }
}

class FuelType {
  String? fuelTypeName;
  int? count;

  FuelType({this.fuelTypeName, this.count});

  FuelType.fromJson(Map<String, dynamic> json) {
    fuelTypeName = json['fuel_type_name'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fuel_type_name'] = fuelTypeName;
    data['count'] = count;
    return data;
  }
}

class Budget {
  String? minPrice;
  String? maxPrice;

  Budget({this.minPrice, this.maxPrice});

  Budget.fromJson(Map<String, dynamic> json) {
    minPrice = json['min_price'];
    maxPrice = json['max_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['min_price'] = minPrice;
    data['max_price'] = maxPrice;
    return data;
  }
}
