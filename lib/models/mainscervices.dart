
class MainSericesModel {
  String? status;
  String? message;
  List<MainServices>? data;

  MainSericesModel({
    this.status,
    this.message,
    this.data,
  });

  factory MainSericesModel.fromJson(Map<String, dynamic> json) =>
      MainSericesModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<MainServices>.from(
                json["data"]!.map((x) => MainServices.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class MainServices {
  int? id;
  String? name;
  String? image;
  DateTime? createdAt;

  MainServices({
    this.id,
    this.name,
    this.image,
    this.createdAt,
  });

  factory MainServices.fromJson(Map<String, dynamic> json) => MainServices(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "created_at": createdAt?.toIso8601String(),
      };
}
