import 'package:app/models/bookingDetailItemModel.dart';
import 'package:app/utilities/JsonParsable.dart';
import 'package:app/models/userModel.dart';

class BookingDetail with JsonParsable {
  int? vendor_id;
  int? id;
  String? service_date;
  int? in_door;
  dynamic in_door_val;
  String? service_time;
  String? total_price;
  int? status;
  String? statustext;
  String? rem_price;
  String? coupon_discount;
  String? mobile;
  User? user;
  List<BookingDetailItem> items = [];

  BookingDetail();

  Map<String, dynamic> toJson() => {
        'vendor_id': vendor_id != null ? vendor_id : null,
        'service_date': service_date != null ? service_date : null,
        'service_time': service_time != null ? service_time : null,
        "in_door_val": in_door_val,
        "in_door": in_door
      };

  BookingDetail.fromJson(Map<String, dynamic> json) {
    try {
      in_door = json['in_door'];
      in_door_val = json['in_door_val'];
      vendor_id =
          json['vendor_id'] != null ? parseField(json['vendor_id']) : null;
      id = json['id'] != null ? parseField(json['id']) : null;
      service_date = json['service_date'] != null ? json['service_date'] : null;
      statustext = json['statustext'] != null ? json['statustext'] : null;
      user = (json['user'] != null) ? User.fromJson(json['user']) : null;
      total_price = json['total_price'] != null ? json['total_price'] : null;
      rem_price = json['rem_price'] != null ? json['rem_price'] : null;
      coupon_discount =
          json['coupon_discount'] != null ? json['coupon_discount'] : null;
      mobile = json['mobile'] != null ? json['mobile'] : null;

      service_time = json['service_time'] != null ? json['service_time'] : null;
      items = (json['items'] != null)
          ? List<BookingDetailItem>.from(
              json['items'].map((e) => BookingDetailItem.fromJson(e)))
          : [];
    } catch (e) {
      print("Exception - BookingDetailModel.dart - BookingDetail.fromJson():" +
          e.toString());
    }
  }
}
