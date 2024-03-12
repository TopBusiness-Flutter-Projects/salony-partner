class WorkingDays {
  String? status;
  String? message;
  WorkingDaysModel? data;

  WorkingDays({
    this.status,
    this.message,
    this.data,
  });

  factory WorkingDays.fromJson(Map<String, dynamic> json) => WorkingDays(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : WorkingDaysModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class WorkingDaysModel {
  int? timeSlotId;
  String? openHour;
  String? closeHour;
  String? days;
  int? vendorId;
  int? status;

  WorkingDaysModel({
    this.timeSlotId,
    this.openHour,
    this.closeHour,
    this.days,
    this.vendorId,
    this.status,
  });

  factory WorkingDaysModel.fromJson(Map<String, dynamic> json) =>
      WorkingDaysModel(
        timeSlotId: json["time_slot_id"],
        openHour: json["open_hour"],
        closeHour: json["close_hour"],
        days: json["days"],
        vendorId: json["vendor_id"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "time_slot_id": timeSlotId,
        "open_hour": openHour,
        "close_hour": closeHour,
        "days": days,
        "vendor_id": vendorId,
        "status": status,
      };
}
