import 'package:salons_app/features/home/domain/entity/nearest_salons_response_entity.dart';

class CurrentLocationResponse {
  CurrentLocationResponse({
    this.data,
  });

  CurrentLocationResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }

  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  NearestSalonsResponseEntity toEntity() {
    List<SalonResponseEntity> salons = [];
    data?.forEach((salon) {
      salons.add(
        SalonResponseEntity(
          address: salon.translation?.address,
          desc: salon.translation?.description,
          name: salon.translation?.title,
          bgImage: salon.backgroundImg,
          distance: salon.distance,
          id: salon.id,
          lat: salon.latLong?.latitude,
          long: salon.latLong?.longitude,
          logo: salon.logoImg,
          reviewCount: 0,
          reviewTotalCount: 0,
          visibility: salon.visibility,
        ),
      );
    });
    return NearestSalonsResponseEntity(
      salons: salons,
    );
  }
}

class Data {
  Data({
    this.id,
    this.slug,
    this.uuid,
    this.open,
    this.visibility,
    this.verify,
    this.deliveryType,
    this.backgroundImg,
    this.logoImg,
    this.status,
    this.deliveryTime,
    this.latLong,
    this.minPrice,
    this.maxPrice,
    this.serviceMaxPrice,
    this.distance,
    this.productsCount,
    this.translation,
    this.services,
    this.shopWorkingDays,
    this.shopClosedDate,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    slug = json['slug'];
    uuid = json['uuid'];
    open = json['open'];
    visibility = json['visibility'];
    verify = json['verify'];
    deliveryType = json['delivery_type'];
    backgroundImg = json['background_img'];
    logoImg = json['logo_img'];
    status = json['status'];
    deliveryTime = json['delivery_time'] != null
        ? DeliveryTime.fromJson(json['delivery_time'])
        : null;
    latLong =
        json['lat_long'] != null ? LatLong.fromJson(json['lat_long']) : null;
    minPrice = json['min_price'];
    maxPrice = json['max_price'];
    serviceMaxPrice = json['service_max_price'];
    distance = double.tryParse(json['distance'].toString());
    productsCount = json['products_count'];
    translation = json['translation'] != null
        ? Translation.fromJson(json['translation'])
        : null;
    // if (json['services'] != null) {
    //   services = [];
    //   json['services'].forEach((v) {
    //     services?.add(Dynamic.fromJson(v));
    //   });
    // }
    if (json['shop_working_days'] != null) {
      shopWorkingDays = [];
      json['shop_working_days'].forEach((v) {
        shopWorkingDays?.add(ShopWorkingDays.fromJson(v));
      });
    }
    // if (json['shop_closed_date'] != null) {
    //   shopClosedDate = [];
    //   json['shop_closed_date'].forEach((v) {
    //     shopClosedDate?.add(Dynamic.fromJson(v));
    //   });
    // }
  }

  int? id;
  String? slug;
  String? uuid;
  bool? open;
  bool? visibility;
  bool? verify;
  int? deliveryType;
  String? backgroundImg;
  String? logoImg;
  String? status;
  DeliveryTime? deliveryTime;
  LatLong? latLong;
  int? minPrice;
  int? maxPrice;
  int? serviceMaxPrice;
  double? distance;
  int? productsCount;
  Translation? translation;
  List<dynamic>? services;
  List<ShopWorkingDays>? shopWorkingDays;
  List<dynamic>? shopClosedDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['slug'] = slug;
    map['uuid'] = uuid;
    map['open'] = open;
    map['visibility'] = visibility;
    map['verify'] = verify;
    map['delivery_type'] = deliveryType;
    map['background_img'] = backgroundImg;
    map['logo_img'] = logoImg;
    map['status'] = status;
    if (deliveryTime != null) {
      map['delivery_time'] = deliveryTime?.toJson();
    }
    if (latLong != null) {
      map['lat_long'] = latLong?.toJson();
    }
    map['min_price'] = minPrice;
    map['max_price'] = maxPrice;
    map['service_max_price'] = serviceMaxPrice;
    map['distance'] = distance;
    map['products_count'] = productsCount;
    if (translation != null) {
      map['translation'] = translation?.toJson();
    }
    if (services != null) {
      map['services'] = services?.map((v) => v.toJson()).toList();
    }
    if (shopWorkingDays != null) {
      map['shop_working_days'] =
          shopWorkingDays?.map((v) => v.toJson()).toList();
    }
    if (shopClosedDate != null) {
      map['shop_closed_date'] = shopClosedDate?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ShopWorkingDays {
  ShopWorkingDays({
    this.id,
    this.day,
    this.from,
    this.to,
    this.disabled,
    this.createdAt,
    this.updatedAt,
  });

  ShopWorkingDays.fromJson(dynamic json) {
    id = json['id'];
    day = json['day'];
    from = json['from'];
    to = json['to'];
    disabled = json['disabled'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  int? id;
  String? day;
  String? from;
  String? to;
  bool? disabled;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['day'] = day;
    map['from'] = from;
    map['to'] = to;
    map['disabled'] = disabled;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}

class Translation {
  Translation({
    this.id,
    this.locale,
    this.title,
    this.description,
    this.address,
  });

  Translation.fromJson(dynamic json) {
    id = json['id'];
    locale = json['locale'];
    title = json['title'];
    description = json['description'];
    address = json['address'];
  }

  int? id;
  String? locale;
  String? title;
  String? description;
  String? address;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['locale'] = locale;
    map['title'] = title;
    map['description'] = description;
    map['address'] = address;
    return map;
  }
}

class LatLong {
  LatLong({
    this.latitude,
    this.longitude,
  });

  LatLong.fromJson(dynamic json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  double? latitude;
  double? longitude;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    return map;
  }
}

class DeliveryTime {
  DeliveryTime({
    this.to,
    this.from,
    this.type,
  });

  DeliveryTime.fromJson(dynamic json) {
    to = json['to'];
    from = json['from'];
    type = json['type'];
  }

  String? to;
  String? from;
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['to'] = to;
    map['from'] = from;
    map['type'] = type;
    return map;
  }
}
