import 'package:app/utilities/JsonParsable.dart';
import 'package:app/models/userModel.dart';

class UserRequest with JsonParsable {
  int? vendor_id;
  int? id;
  String? service_date;
  String? service_time;
  String? total_price;
  int? status;
  String? statustext;
  User? user;

  UserRequest();
  Map<String, dynamic> toJson() => {
        'vendor_id': vendor_id != null ? vendor_id : null,
        'service_date': service_date != null ? service_date : null,
        'service_time': service_time != null ? service_time : null,
      };

  UserRequest.fromJson(Map<String, dynamic> json) {
    try {
      vendor_id = json['vendor_id'] != null ? parseField(json['vendor_id']) : null;
      id = json['id'] != null ? parseField(json['id']) : null;
      service_date = json['service_date'] != null ? json['service_date'] : null;
      statustext = json['statustext'] != null ? json['statustext'] : null;
      user = (json['user'] != null) ? User.fromJson(json['user']) : null;
      total_price = json['total_price'] != null ? json['total_price'] : null;
      service_time = json['service_time'] != null ? json['service_time'] : null;
     
    } catch (e) {
      print("Exception - userRequestModel.dart - UserRequest.fromJson():" + e.toString());
    }
  }
}
