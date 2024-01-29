import 'package:app/utilities/JsonParsable.dart';

class Product with JsonParsable {
  int? id;
  int? vendor_id;
  String? product_name;
  String? product_image;
  String? price;
  String? quantity;
  String? description;

  Product();

  Map<String, dynamic> toJson() => {
        'id': id != null ? id : null,
        'vendor_id': vendor_id != null ? vendor_id : null,
        'product_name': product_name != null ? product_name : null,
        'product_image': product_image != null ? product_image : null,
        'price': price != null ? price : null,
        'quantity': quantity != null ? quantity : null,
        'description': description != null ? description : null,
      };

  Product.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'] != null ? parseField(json['id']) : null;
      vendor_id = json['vendor_id'] != null ? parseField(json['vendor_id']) : null;
      product_name = json['product_name'] != null ? json['product_name'] : null;
      product_image = json['product_image'] != null ? json['product_image'] : null;
      price = json['price'] != null ? json['price'] : null;
      quantity = json['quantity'] != null ? json['quantity'] : null;
      description = json['description'] != null ? json['description'] : null;
    } catch (e) {
      print("Exception - productModel.dart - Product.fromJson():" + e.toString());
    }
  }
}
