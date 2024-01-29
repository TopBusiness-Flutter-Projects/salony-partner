class PrivacyAndPolicy {
  int? id;
  String? privacyAndPolicy;

  PrivacyAndPolicy();

  PrivacyAndPolicy.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'] != null ? json['id'] : null;
      privacyAndPolicy = json['privacy_policy'] != null ? json['privacy_policy'] : null;
    } catch (e) {
      print("Exception - PrivacyAndPolicyModel.dart - PrivacyAndPolicy.fromJson():" + e.toString());
    }
  }
}
