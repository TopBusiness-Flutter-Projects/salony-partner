class ChartData {
  int? earning;
  String? date;
  String? day;

  ChartData();

  ChartData.fromJson(Map<String, dynamic> json) {
    try {
      earning = json['earning'] != null ? json['earning'] : null;
      date = json['date'] != null ? json['date'] : null;
      day = json['day'] != null ? json['day'] : null;
    } catch (e) {
      print("Exception - chartDataModel.dart - ChartDataModel.fromJson():" + e.toString());
    }
  }
}
