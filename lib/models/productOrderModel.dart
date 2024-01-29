import 'package:app/models/orderModel.dart';
import 'package:app/models/userModel.dart';
import 'package:app/utilities/JsonParsable.dart';

class ProductOrder with JsonParsable {
  int? vendor_id;
  int? store_order_id;
  String? productName;
  String? quantity;
  int? productId;
  String? order_cart_id;
  int? qty;
  String? price;
  String? total_price;
  String? service_date;
  String? service_time;
  String? order_date;
  String? product_image;
  int? status;
  String? description;
  String? statustext;
  String? productImage;
  User? user;
  Order? order;

  ProductOrder();

  Map<String, dynamic> toJson() => {
        'vendor_id': vendor_id != null ? vendor_id : null,
        'service_date': service_date != null ? service_date : null,
        'service_time': service_time != null ? service_time : null,
      };

  ProductOrder.fromJson(Map<String, dynamic> json) {
    try {
      vendor_id = json['vendor_id'] != null ? parseField(json['vendor_id']) : null;
      store_order_id = json['store_order_id'] != null ? parseField(json['store_order_id']) : null;
      service_date = json['service_date'] != null ? json['service_date'] : null;
      statustext = json['statustext'] != null ? json['statustext'] : null;
      user = (json['user'] != null) ? User.fromJson(json['user']) : null;
      order = (json['order'] != null) ? Order.fromJson(json['order']) : null;
      total_price = json['total_price'] != null ? json['total_price'] : null;
      service_time = json['service_time'] != null ? json['service_time'] : null;
      productName = json['product_name'] != null ? json['product_name'] : null;
      quantity = json['quantity'] != null ? json['quantity'] : null;
      productId = json['productId'] != null ? parseField(json['productId']) : null;
      qty = json['qty'] != null ? parseField(json['qty']) : null;
      price = json['price'] != null ? json['price'] : null;
      total_price = json['total_price'] != null ? json['total_price'] : null;
      order_date = json['order_date'] != null ? json['order_date'] : null;
      product_image = json['product_image'] != null ? json['product_image'] : null;
      description = json['description'] != null ? json['description'] : null;
      order_cart_id = json['order_cart_id'] != null ? json['order_cart_id'] : null;
      productImage = json['product_image'] != null ? json['product_image'] : null;
    } catch (e) {
      print("Exception - productOrderModel.dart - ProductOrder.fromJson():" + e.toString());
    }
  }
}
