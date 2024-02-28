class RegionModel {
  int? regionId;
  int? capitalCityId;
  String? code;
  String? nameAr;
  String? nameEn;
  int? population;

  RegionModel({
    this.regionId,
    this.capitalCityId,
    this.code,
    this.nameAr,
    this.nameEn,
    this.population,
  });

  factory RegionModel.fromJson(Map<String, dynamic> json) => RegionModel(
        regionId: json["region_id"],
        capitalCityId: json["capital_city_id"],
        code: json["code"],
        nameAr: json["name_ar"],
        nameEn: json["name_en"],
        population: json["population"],
      );

  Map<String, dynamic> toJson() => {
        "region_id": regionId,
        "capital_city_id": capitalCityId,
        "code": code,
        "name_ar": nameAr,
        "name_en": nameEn,
        "population": population,
      };
}
