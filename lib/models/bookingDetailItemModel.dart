

import 'package:app/utilities/JsonParsable.dart';

class BookingDetailItem with JsonParsable {
  int? vendor_id;
  String? service_name;
  String? varient;
  String? price;

  BookingDetailItem();

  Map<String, dynamic> toJson() => {'vendor_id': vendor_id != null ? vendor_id : null, 'service_name': service_name != null ? service_name : null, 'varient': varient != null ? varient : null, 'price': price != null ? price : null};

  BookingDetailItem.fromJson(Map<String, dynamic> json) {
    try {
      vendor_id = json['vendor_id'] != null ? parseField(json['vendor_id']) : null;
      service_name = json['service_name'] != null ? json['service_name'] : null;
      varient = json['varient'] != null ? json['varient'] : null;
      price = json['price'] != null ? json['price'] : null;
    } catch (e) {
      print("Exception - BookingDetailItemModel.dart - BookingDetailItem.fromJson():" + e.toString());
    }
  }
}
