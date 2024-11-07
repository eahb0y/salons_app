class CurrentLocationRequest {
  CurrentLocationRequest({
      this.lang, 
      this.locationType, 
      this.address5Blatitude5D, 
      this.address5Blongitude5D,});

  CurrentLocationRequest.fromJson(dynamic json) {
    lang = json['lang'];
    locationType = json['location_type'];
    address5Blatitude5D = json['address%5Blatitude%5D'];
    address5Blongitude5D = json['address%5Blongitude%5D'];
  }
  String? lang;
  String? locationType;
  String? address5Blatitude5D;
  String? address5Blongitude5D;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lang'] = lang;
    map['location_type'] = locationType;
    map['address%5Blatitude%5D'] = address5Blatitude5D;
    map['address%5Blongitude%5D'] = address5Blongitude5D;
    return map;
  }

}