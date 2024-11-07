class NearestSalonsResponseEntity {
  final List<SalonResponseEntity>? salons;

  NearestSalonsResponseEntity({
    required this.salons,
  });
}

class SalonResponseEntity {
  final int? id;
  final bool? visibility;
  final String? bgImage;
  final String? logo;
  final double? lat;
  final double? long;
  final int? reviewCount;
  final double? reviewTotalCount;
  final double? distance;
  final String? name;
  final String? desc;
  final String? address;

  SalonResponseEntity({
    required this.id,
    required this.visibility,
    required this.bgImage,
    required this.logo,
    required this.lat,
    required this.long,
    required this.reviewCount,
    required this.reviewTotalCount,
    required this.distance,
    required this.name,
    required this.desc,
    required this.address,
  });
}
