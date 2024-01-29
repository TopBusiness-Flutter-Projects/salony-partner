class Coupon {
  int? vendor_id;
  int? coupon_vendor_id;
  int? coupon_id;
  String? coupon_name;
  String? coupon_code;
  String? coupon_description;
  DateTime? start_date;
  DateTime? end_date;
  int? cart_value;
  String? amount;
  String? type;
  int? uses_restriction;
  int? added_by;

  Coupon();

  Map<String, dynamic> toJson() => {
        'vendor_id': vendor_id,
        'coupon_name': coupon_name != null ? coupon_name : null,
        'coupon_code': coupon_code != null ? coupon_code : null,
        'coupon_description': coupon_description != null ? coupon_description : null,
        'start_date': start_date != null ? start_date?.toIso8601String() : null,
        'end_date': end_date != null ? end_date?.toIso8601String() : null,
        'cart_value': cart_value != null ? cart_value : null,
        'amount': amount != null ? amount : null,
        'type': type != null ? type : null,
        'uses_restriction': uses_restriction != null ? uses_restriction : null,
      };

  Coupon.fromJson(Map<String, dynamic> json) {
    try {
      vendor_id = json['vendor_id'] != null ? json['vendor_id'] : null;
      coupon_id = json['coupon_id'] != null ? json['coupon_id'] : null;
      coupon_name = json['coupon_name'] != null ? json['coupon_name'] : null;
      coupon_code = json['coupon_code'] != null ? json['coupon_code'] : null;
      coupon_description = json['coupon_description'] != null ? json['coupon_description'] : null;
      cart_value = json['cart_value'] != null ? json['cart_value'] : null;
      amount = json['amount'] != null ? json['amount'] : null;
      type = json['type'] != null ? json['type'] : null;
      uses_restriction = json['uses_restriction'] != null ? json['uses_restriction'] : null;

      coupon_vendor_id = json['coupon_vendor_id'] != null ? json['coupon_vendor_id'] : null;
      start_date = json['start_date'] != null ? DateTime.parse(json['start_date'].toString()).toLocal() : null;
      end_date = json['end_date'] != null ? DateTime.parse(json['end_date'].toString()).toLocal() : null;
      added_by = json['added_by'] != null ? json['added_by'] : null;
    } catch (e) {
      print("Exception - couponModel.dart - couponModel.fromJson():" + e.toString());
    }
  }
}
