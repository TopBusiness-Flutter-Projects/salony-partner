import 'package:app/models/shareSendPendingModel.dart';

class MyWallet {
  double? admin_share;
  double? total_price;
  double? share_sent_amount;
  List<ShareSentPending> share_sent = [];
  double? share_sent_pending_amount;
  List<ShareSentPending> share_sent_pending = [];
  double? share_given_amount;
  List<ShareSentPending> share_given = [];
  double? share_given_pending_amount;
  List<ShareSentPending> share_given_pending = [];

  MyWallet();

  MyWallet.fromJson(Map<String, dynamic> json) {
    try {
      admin_share = json['admin_share'] != null ? double.parse(json['admin_share'].toString()) : null;
      total_price = json['total_price'] != null ? double.parse(json['total_price'].toString()) : null;
      share_sent_amount = json['share_sent_amount'] != null ? double.parse(json['share_sent_amount'].toString()) : null;
      share_sent_pending_amount = json['share_sent_pending_amount'] != null ? double.parse(json['share_sent_pending_amount'].toString()) : null;
      share_given_amount = json['share_given_amount'] != null ? double.parse(json['share_given_amount'].toString()) : null;
      share_given_pending_amount = json['share_given_pending_amount'] != null ? double.parse(json['share_given_pending_amount'].toString()) : null;
      share_sent = (json['share_sent'] != null) ? List<ShareSentPending>.from(json['share_sent'].map((e) => ShareSentPending.fromJson(e))) : [];
      share_sent_pending = (json['share_sent_pending'] != null) ? List<ShareSentPending>.from(json['share_sent_pending'].map((e) => ShareSentPending.fromJson(e))) : [];
      share_given = (json['share_given'] != null) ? List<ShareSentPending>.from(json['share_given'].map((e) => ShareSentPending.fromJson(e))) : [];
      share_given_pending = (json['share_given_pending'] != null) ? List<ShareSentPending>.from(json['share_given_pending'].map((e) => ShareSentPending.fromJson(e))) : [];
    } catch (e) {
      print("Exception - MyWalletModel.dart - MyWallet.fromJson():" + e.toString());
    }
  }
}
