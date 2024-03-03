class CityModel {
  int? cityId;
  int? regionId;
  String? nameAr;
  String? nameEn;

  CityModel({
    this.cityId,
    this.regionId,
    this.nameAr,
    this.nameEn,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        cityId: json["city_id"],
        regionId: json["region_id"],
        nameAr: json["name_ar"],
        nameEn: json["name_en"],
      );

  Map<String, dynamic> toJson() => {
        "city_id": cityId,
        "region_id": regionId,
        "name_ar": nameAr,
        "name_en": nameEn,
      };
}
