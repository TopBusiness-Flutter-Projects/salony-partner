import 'package:app/utilities/JsonParsable.dart';

class Faqs with JsonParsable {
  int? faq_id;
  String? question;
  String? answer;

  Faqs();

  Faqs.fromJson(Map<String, dynamic> json) {
    try {
      faq_id = json['faq_id'] != null ? parseField(json['faq_id']) : null;

      question = json['question'] != null ? json['question'] : null;
      answer = json['answer'] != null ? json['answer'] : null;
    } catch (e) {
      print("Exception - faqsModel.dart - Faqs.fromJson():" + e.toString());
    }
  }
}
