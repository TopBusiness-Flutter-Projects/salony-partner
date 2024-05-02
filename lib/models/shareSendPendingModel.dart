class ShareSentPending {
  String? cart_id;
  int? vendor_id;
  String? total_price;
  String? service_date;
  String? mobile;
  String? statustext;
  String? paymentStatus;

  ShareSentPending();

  ShareSentPending.fromJson(Map<String, dynamic> json) {
    try {
      cart_id = json['cart_id'] != null ? json['cart_id'] : null;
      vendor_id = json['vendor_id'] != null ? json['vendor_id'] : null;
      total_price = json['total_price'] != null ? json['total_price'] : null;
      service_date = json['service_date'] != null ? json['service_date'] : null;
      mobile = json['mobile'] != null ? json['mobile'] : null;
      statustext = json['statustext'] != null ? json['statustext'] : null;
      paymentStatus =
          json['payment_status'] != null ? json['payment_status'] : null;
    } catch (e) {
      print(
          "Exception - shareSentPendingModel.dart - ShareSentPending.fromJson():" +
              e.toString());
    }
  }
}
