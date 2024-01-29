import 'package:app/models/reviewModel.dart';
import 'package:app/utilities/JsonParsable.dart';

class Expert with JsonParsable {
  int? vendor_id;
  String? staff_name;
  String? staff_image;
  String? staff_description;
  int? staff_id;
  List<Review>? review = [];

  Expert();

  Map<String, dynamic> toJson() => {
        'vendor_id': vendor_id != null ? vendor_id : null,
        'staff_name': staff_name != null ? staff_name : null,
        'staff_image': staff_image != null ? staff_image : null,
        'staff_description': staff_description != null ? staff_description : null,
        'staff_id': staff_id != null ? staff_id : null,
      };

  Expert.fromJson(Map<String, dynamic> json) {
    try {
      vendor_id = json['vendor_id'] != null ? parseField(json['vendor_id']) : null;
      staff_name = json['staff_name'] != null ? json['staff_name'] : null;
      staff_image = json['staff_image'] != null ? json['staff_image'] : null;
      staff_description = json['staff_description'] != null ? json['staff_description'] : null;
      staff_id = json['staff_id'] != null ? parseField(json['staff_id']) : null;
    } catch (e) {
      print("Exception - expertModel.dart - Expert.fromJson():" + e.toString());
    }
  }
}
