import 'package:app/models/serviceVariantModel.dart';
import 'package:app/utilities/JsonParsable.dart';

class Service with JsonParsable {
  int? vendor_id;
  String? service_name;
  String? service_image;
  int? service_id;
  String? createdAt;
  List<ServiceVariant> varients = [];

  Service();

  Map<String, dynamic> toJson() => {
        'vendor_id': vendor_id != null ? vendor_id : null,
        'service_id': service_id != null ? service_id : null,
        'service_name': service_name != null ? service_name : null,
        'service_image': service_image != null ? service_image : null,
      };

  Service.fromJson(Map<String, dynamic> json) {
    try {
      vendor_id = json['vendor_id'] != null ? parseField(json['vendor_id']) : null;
      service_id = json['service_id'] != null ? parseField(json['service_id']) : null;
      service_name = json['service_name'] != null ? json['service_name'] : null;
      service_image = json['service_image'] != null ? json['service_image'] : null;
      createdAt = json['created_at'] != null ? json['created_at'] : null;
      varients = (json['varients'] != null) ? List<ServiceVariant>.from(json['varients'].map((e) => ServiceVariant.fromJson(e))) : [];
    } catch (e) {
      print("Exception - serviceModel.dart - serviceModel.fromJson():" + e.toString());
    }
  }
}
