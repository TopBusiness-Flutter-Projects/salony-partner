import 'package:app/models/chartDataModel.dart';

class HomePage {
  int? vendor_id;
  int? allOrders;
  int? pendingOrders;
  int? completedOrders;
  ChartData? day1Details;
  ChartData? day2Details;
  ChartData? day3Details;
  ChartData? day4Details;
  ChartData? day5Details;
  ChartData? day6Details;
  ChartData? day7Details;
  int? unread_notification_count;
  int? read_notification_count;
  double? completedGloals;

  HomePage();

  Map<String, dynamic> toJson() => {
        'vendor_id': vendor_id != null ? vendor_id : null,
      };

  HomePage.fromJson(Map<String, dynamic> json) {
    try {
      vendor_id = json['vendor_id'] != null ? json['vendor_id'] : null;
      allOrders = json['all_orders_count'] != null ? json['all_orders_count'] : null;
      pendingOrders = json['pending_orders'] != null ? json['pending_orders'] : null;
      completedOrders = json['complted_order_count'] != null ? json['complted_order_count'] : null;
      day1Details = (json['day1_details'] != null) ? ChartData.fromJson(json['day1_details']) : null;
      day2Details = (json['day2_details'] != null) ? ChartData.fromJson(json['day2_details']) : null;
      day3Details = (json['day3_details'] != null) ? ChartData.fromJson(json['day3_details']) : null;
      day4Details = (json['day4_details'] != null) ? ChartData.fromJson(json['day4_details']) : null;
      day5Details = (json['day5_details'] != null) ? ChartData.fromJson(json['day5_details']) : null;
      day6Details = (json['day6_details'] != null) ? ChartData.fromJson(json['day6_details']) : null;
      day7Details = (json['day7_details'] != null) ? ChartData.fromJson(json['day7_details']) : null;
      unread_notification_count = json['unread_notification_count'] != null ? json['unread_notification_count'] : null;
      read_notification_count = json['read_notification_count'] != null ? json['read_notification_count'] : null;
      completedGloals = allOrders != 0 ? (completedOrders! * 100) / allOrders! : 0;
    } catch (e) {
      print("Exception - HomePageModel.dart - HomePageModel.fromJson():" + e.toString());
    }
  }
}
