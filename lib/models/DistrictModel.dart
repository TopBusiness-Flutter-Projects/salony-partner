
class DistrictModel {
    int? districtId;
    int? cityId;
    int? regionId;
    String? nameAr;
    String? nameEn;

    DistrictModel({
        this.districtId,
        this.cityId,
        this.regionId,
        this.nameAr,
        this.nameEn,
    });

    factory DistrictModel.fromJson(Map<String, dynamic> json) => DistrictModel(
        districtId: json["district_id"],
        cityId: json["city_id"],
        regionId: json["region_id"],
        nameAr: json["name_ar"],
        nameEn: json["name_en"],
    );

    Map<String, dynamic> toJson() => {
        "district_id": districtId,
        "city_id": cityId,
        "region_id": regionId,
        "name_ar": nameAr,
        "name_en": nameEn,
    };
}
