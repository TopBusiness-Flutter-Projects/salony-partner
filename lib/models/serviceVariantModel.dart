import 'dart:io';

class ServiceVariant {
  int? vendor_id;
  String? varient;
  int? price;
  int? time;
  int? service_id;
  int? varient_id;
  String? varient_image;

  ServiceVariant();

  Map<String, dynamic> toJson() => {
        'vendor_id': vendor_id != null ? vendor_id : null,
        'service_id': service_id != null ? service_id : null,
        'price': price != null ? price : null,
        'varient': varient != null ? varient : null,
        'time': time != null ? time : null,
        'varient_id': varient_id != null ? varient_id : null,
        "varient_image": varient_image ?? null
      };

  ServiceVariant.fromJson(Map<String, dynamic> json) {
    try {
      varient_image = json['varient_image'];
      vendor_id = json['vendor_id'] != null ? json['vendor_id'] : null;
      service_id = json['service_id'] != null ? json['service_id'] : null;
      price = json['price'] != null ? json['price'] : null;
      varient = json['varient'] != null ? json['varient'] : null;
      time = json['time'] != null ? json['time'] : null;
      varient_id = json['varient_id'] != null ? json['varient_id'] : null;
    } catch (e) {
      print("Exception - serviceVariantModel.dart - serviceModel.fromJson():" +
          e.toString());
    }
  }
}
