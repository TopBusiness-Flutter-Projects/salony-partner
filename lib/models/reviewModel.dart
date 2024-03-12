import 'package:app/models/userModel.dart';

class Review {
  int? id;
  double? rating;
  String? descriptionForPartner;
  String? descriptionForExpert;
  int? user_id;
  int? vendor_id;
  int? product_id;
  int? active;
  String? name;
  String? image;
  DateTime? created_at;
  User? user;

  Review();

  Review.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'] != null ? json['id'] : null;
      user_id = json['user_id'] != null ? json['user_id'] : null;
      product_id = json['product_id'] != null ? json['product_id'] : null;
      descriptionForPartner =
          json['description'] != null ? json['description'] : null;
      descriptionForExpert = json['review_description'] != null
          ? json['review_description']
          : null;
      vendor_id = json['vendor_id'] != null ? json['vendor_id'] : null;
      rating =
          json['rating'] != null ? double.parse(json['rating'].toString()) : 0;
      active = json['active'] != null ? json['active'] : null;
      name = json['name'] != null ? json['name'] : null;
      image = json['image'] != null ? json['image'] : null;
      created_at = json['created_at'] != null
          ? DateTime.parse(json['created_at'].toString()).toLocal()
          : null;
      user = (json['user'] != null) ? User.fromJson(json['user']) : null;
    } catch (e) {
      print("Exception - reviewModel.dart - Review.fromJson():" + e.toString());
    }
  }
}
