import 'package:app/utilities/JsonParsable.dart';

class Notifications with JsonParsable {
  int? not_id;
  String? not_title;
  String? not_message;
  int? vendor_id;
  int? read_by_vendor;
  String? image;

  Notifications();

  Map<String, dynamic> toJson() => {
        'vendor_id': vendor_id != null ? vendor_id : null,
        'not_title': not_title != null ? not_title : null,
        'not_message': not_message != null ? not_message : null,
      };

  Notifications.fromJson(Map<String, dynamic> json) {
    try {
      vendor_id = json['vendor_id'] != null ? parseField(json['vendor_id']) : null;
      not_title = json['not_title'] != null ? json['not_title'] : null;
      not_message = json['not_message'] != null ? json['not_message'] : null;
      read_by_vendor = json['read_by_vendor'] != null ? parseField(json['read_by_vendor']) : null;
      image = json['image'] != null ? json['image'] : null;
    } catch (e) {
      print("Exception - notificationModel.dart - Notifications.fromJson():" + e.toString());
    }
  }
}
