import 'dart:convert';
import 'dart:io';

import 'package:app/models/appointmentHistoryModel.dart';
import 'package:app/models/bookingConfirmModel.dart';
import 'package:app/models/bookingDetailModel.dart';
import 'package:app/models/businessLayer/apiResult.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/couponModel.dart';
import 'package:app/models/currencyModel.dart';
import 'package:app/models/expertModel.dart';
import 'package:app/models/faqModel.dart';
import 'package:app/models/galleryModel.dart';
import 'package:app/models/homePageModel.dart';
import 'package:app/models/myWalletModel.dart';
import 'package:app/models/notificationModel.dart';
import 'package:app/models/partnerUserModel.dart';
import 'package:app/models/privacyAndPolicyModel.dart';
import 'package:app/models/productModel.dart';
import 'package:app/models/productOrderModel.dart';
import 'package:app/models/reviewModel.dart';
import 'package:app/models/serviceModel.dart';
import 'package:app/models/serviceVariantModel.dart';
import 'package:app/models/userRequestModel.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../mainscervices.dart';

class APIHelper {
  Future<dynamic> addCoupon(Coupon coupon) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}add_coupon"),
        headers: await global.getApiHeaders(false),
        body: json.encode(coupon),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body) != null &&
          json.decode(response.body)["data"] != null) {
        recordList = Coupon.fromJson(json.decode(response.body)["data"]);
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - addCoupon(): " + e.toString());
    }
  }

  Future<dynamic> addExpert(
      int id, String staffName, String staffDescription, File? _Image) async {
    try {
      Response response;
      var dio = Dio();
      var formData = FormData.fromMap({
        'vendor_id': id,
        'staff_name': staffName,
        'staff_description': staffDescription,
        'staff_image': _Image != null
            ? await MultipartFile.fromFile(_Image.path.toString())
            : null,
      });
      response = await dio.post('${global.baseUrl}add_expert',
          data: formData,
          options: Options(
            headers: await global.getApiHeaders(false),
          ));
      dynamic recordList;
      if (response.statusCode == 200 && response.data["status"] == "1") {
        recordList = Expert.fromJson(response.data['data']);
      } else {
        recordList = null;
      }
      return getAPIResultDio(response, recordList);
    } catch (e) {
      print("Exception - addExpert(): " + e.toString());
    }
  }

  Future<dynamic> addGallery(int id, File? _Image) async {
    try {
      Response response;
      var dio = Dio();
      var formData = FormData.fromMap({
        'vendor_id': id,
        'image[]': _Image != null
            ? await MultipartFile.fromFile(_Image.path.toString())
            : null,
      });

      response = await dio.post('${global.baseUrl}add_gallery',
          data: formData,
          options: Options(
            headers: await global.getApiHeaders(false),
          ));
      dynamic recordList;
      if (response.statusCode == 200 && response.data["status"] == "1") {
        recordList = null;
      } else {
        recordList = null;
      }
      return getAPIResultDio(response, recordList);
    } catch (e) {
      print("Exception - addGallery(): " + e.toString());
    }
  }

  Future<dynamic> addProduct(int id, String productName, String price,
      String quantity, String description, File? product_image,
      {required int mainProductId}) async {
    try {
      Response response;
      var dio = Dio();
      var formData = FormData.fromMap({
        'vendor_id': id,
        'product_name': productName,
        'price': price,
        'quantity': quantity,
        'description': description,
        "m_product_id": mainProductId,
        'product_image': product_image != null
            ? await MultipartFile.fromFile(product_image.path.toString())
            : null,
      });

      response = await dio.post('${global.baseUrl}product_add',
          data: formData,
          options: Options(
            headers: await global.getApiHeaders(false),
          ));
      dynamic recordList;
      if (response.statusCode == 200 && response.data["status"] == "1") {
        recordList = Product.fromJson(response.data['data']);
      } else {
        recordList = null;
      }
      return getAPIResultDio(response, recordList);
    } catch (e) {
      print("Exception - addProduct(): " + e.toString());
    }
  }

  Future<dynamic> addService(
      int id, String serviceName, int m_service_id, File? _Image) async {
    try {
      Response response;
      var dio = Dio();
      print('vendor_id: $id');

      var formData = FormData.fromMap({
        'vendor_id': id,
        'service_name': serviceName,
        "m_service_id": m_service_id,
        'service_image': _Image != null
            ? await MultipartFile.fromFile(_Image.path.toString())
            : null
      });

      response = await dio.post('${global.baseUrl}add_service',
          data: formData,
          options: Options(
            headers: await global.getApiHeaders(false),
          ));
      dynamic recordList;
      if (response.statusCode == 200 && response.data["status"] == "1") {
        recordList = Service.fromJson(response.data['data']);
      } else {
        recordList = null;
      }
      return getAPIResultDio(response, recordList);
    } catch (e) {
      print("Exception - addService(): " + e.toString());
    }
  }

  Future<dynamic> addServiceVariant(ServiceVariant serviceVariant) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}add_servicevariant"),
        headers: await global.getApiHeaders(false),
        body: json.encode(serviceVariant),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body) != null &&
          json.decode(response.body)["data"] != null) {
        recordList =
            ServiceVariant.fromJson(json.decode(response.body)["data"]);
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - addServiceVariant(): " + e.toString());
    }
  }

  Future<dynamic> bookingConfirm(int id, int inDoorVal) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}booking_confirm"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"order_id": id, "in_door_val": inDoorVal}),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        if (json.decode(response.body)["data"] != null) {
          recordList =
              BookingConfirm.fromJson(json.decode(response.body)["data"]);
        }
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - bookingConfirm(): " + e.toString());
    }
  }

  Future<dynamic> cancelOrder(int id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}product_orders_cancel"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"store_order_id": id}),
      );
      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        if (json.decode(response.body)["data"] != null) {
          recordList =
              ProductOrder.fromJson(json.decode(response.body)["data"]);
        }
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - cancelOrder(): " + e.toString());
    }
  }

  Future<dynamic> cancelRequest(int id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}booking_cancel"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"order_id": id}),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        if (json.decode(response.body)["data"] != null) {
          recordList = null;
        }
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - cancelRequest(): " + e.toString());
    }
  }

  Future<dynamic> changePassword(int vendorId, String currentPassword,
      String password, String confirmPassword) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}profile_change_password"),
        headers: await global.getApiHeaders(false),
        body: json.encode({
          "vendor_id": vendorId,
          "current_password": currentPassword,
          "password": password,
          "password_confirmation": confirmPassword
        }),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body) != null &&
          json.decode(response.body)["data"] != null) {
        recordList = Coupon.fromJson(json.decode(response.body)["data"]);
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - changePassword(): " + e.toString());
    }
  }

  Future<dynamic> changePasswordFromOtp(
      String vendorEmail, String password) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}change_password"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"vendor_email": vendorEmail, "password": password}),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body) != null &&
          json.decode(response.body)["data"] != null) {
        recordList = Coupon.fromJson(json.decode(response.body)["data"]);
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - changePasswordFromOtp(): " + e.toString());
    }
  }

  Future<dynamic> completeOrder(int id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}product_orders_complete"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"store_order_id": id}),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        if (json.decode(response.body)["data"] != null) {
          recordList =
              ProductOrder.fromJson(json.decode(response.body)["data"]);
        }
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - completeOrders(): " + e.toString());
    }
  }

  Future<dynamic> completeRequest(int id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}booking_complete"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"order_id": id}),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        if (json.decode(response.body)["data"] != null) {
          recordList = null;
        }
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - completeRequest(): " + e.toString());
    }
  }

  Future<dynamic> confirmWallet(int id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}paid_to_admin"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"vendor_id": id}),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = response.body;
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - confirmWallet(): " + e.toString());
    }
  }

  Future<dynamic> deleteCoupon(int id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}delete_coupon"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"coupon_id": id}),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        recordList = response.body;
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - deleteCoupon(): " + e.toString());
    }
  }

  Future<dynamic> deleteExpert(int id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}delete_expert"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"staff_id": id}),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        recordList = response.body;
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - deleteExpert(): " + e.toString());
    }
  }

  Future<dynamic> deleteGallery(int id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}delete_gallery"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"gallery_id": id}),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = response.body;
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - deleteGallery(): " + e.toString());
    }
  }

  Future<dynamic> deleteProduct(int id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}product_delete"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"product_id": id}),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        recordList = response.body;
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - deleteProduct(): " + e.toString());
    }
  }

  Future<dynamic> deleteService(int id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}delete_service"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"service_id": id}),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        recordList = response.body;
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - deleteService(): " + e.toString());
    }
  }

  Future<dynamic> deleteServiceVariant(int id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}delete_servicevariant"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"varient_id": id}),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        recordList = response.body;
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - deleteServiceVariant(): " + e.toString());
    }
  }

  Future<dynamic> editExpert(int vendorId, String staffName,
      String staffDescription, File? _Image, int staffId) async {
    try {
      Response response;
      var dio = Dio();
      var formData = FormData.fromMap({
        'vendor_id': vendorId,
        'staff_name': staffName,
        'staff_description': staffDescription,
        'staff_id': staffId,
        'staff_image': _Image != null
            ? await MultipartFile.fromFile(_Image.path.toString())
            : null,
      });

      response = await dio.post('${global.baseUrl}edit_expert',
          data: formData,
          options: Options(
            headers: await global.getApiHeaders(false),
          ));
      dynamic recordList;
      if (response.statusCode == 200 && response.data["status"] == "1") {
        recordList = Expert.fromJson(response.data['data']);
      } else {
        recordList = null;
      }

      return getAPIResultDio(response, recordList);
    } catch (e) {
      print("Exception - editExpert(): " + e.toString());
    }
  }

  Future<dynamic> editProduct(
      int productId,
      String productName,
      String price,
      String quantity,
      String description,
      int vendorId,
      File? productImage) async {
    try {
      Response response;
      var dio = Dio();
      var formData = FormData.fromMap({
        'vendor_id': vendorId,
        'product_name': productName,
        'description': description,
        'price': price,
        'quantity': quantity,
        'product_id': productId,
        'product_image': productImage != null
            ? await MultipartFile.fromFile(productImage.path.toString())
            : null,
      });

      response = await dio.post('${global.baseUrl}product_edit',
          data: formData,
          options: Options(
            headers: await global.getApiHeaders(false),
          ));
      dynamic recordList;
      if (response.statusCode == 200 && response.data["status"] == "1") {
        recordList = Product.fromJson(response.data['data']);
      } else {
        recordList = null;
      }

      return getAPIResultDio(response, recordList);
    } catch (e) {
      print("Exception - editProduct(): " + e.toString());
    }
  }

  Future<dynamic> editService(
      int vendorId, String serviceName, File? _Image, int serviceId) async {
    try {
      Response response;
      var dio = Dio();
      var formData = FormData.fromMap({
        'vendor_id': vendorId,
        'service_name': serviceName,
        'service_id': serviceId,
        'service_image': _Image != null
            ? await MultipartFile.fromFile(_Image.path.toString())
            : null,
      });

      response = await dio.post('${global.baseUrl}edit_service',
          data: formData,
          options: Options(
            headers: await global.getApiHeaders(false),
          ));
      dynamic recordList;
      if (response.statusCode == 200 && response.data["status"] == "1") {
        recordList = Service.fromJson(response.data['data']);
      } else {
        recordList = null;
      }
      return getAPIResultDio(response, recordList);
    } catch (e) {
      print("Exception - editService(): " + e.toString());
    }
  }

  Future<dynamic> editServiceVariant(ServiceVariant serviceVariant) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}edit_servicevariant"),
        headers: await global.getApiHeaders(false),
        body: json.encode(serviceVariant),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body) != null &&
          json.decode(response.body)["data"] != null) {
        recordList =
            ServiceVariant.fromJson(json.decode(response.body)["data"]);
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - editServiceVariant(): " + e.toString());
    }
  }

  Future<dynamic> forGotPassword(String email) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}forget_password"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"vendor_email": email}),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        recordList = CurrentUser.fromJson(json.decode(response.body)["data"]);
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - fotGetPassword(): " + e.toString());
    }
  }

  dynamic getAPIResult<T>(final response, T recordList) {
    try {
      dynamic result;
      result = APIResult.fromJson(json.decode(response.body), recordList);
      return result;
    } catch (e) {
      print("Exception - getAPIResult():" + e.toString());
    }
  }

  dynamic getAPIResultDio<T>(final response, T recordList) {
    try {
      dynamic result;
      result = APIResult.fromJson(response.data, recordList);
      return result;
    } catch (e) {
      print("Exception - getAPIResultDio():" + e.toString());
    }
  }

  Future<dynamic> getAppointmentHistory(int id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}appointment_history"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"vendor_id": id}),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        if (json.decode(response.body)["data"] != null) {
          recordList = List<AppointmentHistory>.from(json
              .decode(response.body)["data"]
              .map((x) => AppointmentHistory.fromJson(x)));
        } else {
          recordList = null;
        }
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getAppointmentHistory(): " + e.toString());
    }
  }

  Future<dynamic> getBookingDetail(int id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}booking_details"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"order_id": id}),
      );
      print('order_id : $id');
      dynamic recordList;
      if (response.statusCode == 200) {
        if (json.decode(response.body)["data"] != null) {
          recordList =
              BookingDetail.fromJson(json.decode(response.body)["data"]);
        }
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getBookingDetail(): " + e.toString());
    }
  }

  Future<dynamic> getCoupon(int id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}list_coupon"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"vendor_id": id}),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        if (json.decode(response.body)["data"] != null) {
          recordList = List<Coupon>.from(json
              .decode(response.body)["data"]
              .map((x) => Coupon.fromJson(x)));
        } else {
          recordList = null;
        }
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getCoupon(): " + e.toString());
    }
  }

  Future<dynamic> getCurrency() async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}currency"),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        recordList = Currency.fromJson(json.decode(response.body)["data"]);
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getCurrency(): " + e.toString());
    }
  }

  Future<dynamic> getExpertReview(int staffId) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}expert_reviews"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"staff_id": staffId}),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        if (json.decode(response.body)["data"] != null) {
          recordList = List<Review>.from(json
              .decode(response.body)["data"]
              .map((x) => Review.fromJson(x)));
        } else {
          recordList = null;
        }
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getExpertReview(): " + e.toString());
    }
  }

  Future<dynamic> getExperts(int id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}list_expert"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"vendor_id": id}),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        if (json.decode(response.body)["data"] != null) {
          recordList = List<Expert>.from(json
              .decode(response.body)["data"]
              .map((x) => Expert.fromJson(x)));
        } else {
          recordList = null;
        }
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getExperts(): " + e.toString());
    }
  }

  Future<dynamic> getFaqs() async {
    try {
      final response = await http.post(Uri.parse("${global.baseUrl}faqs"),
          headers: await global.getApiHeaders(false),
          body: json.encode({"lang": global.languageCode}));

      dynamic recordList;
      if (response.statusCode == 200) {
        if (json.decode(response.body)["data"] != null) {
          recordList = List<Faqs>.from(
              json.decode(response.body)["data"].map((x) => Faqs.fromJson(x)));
        } else {
          recordList = null;
        }
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getFaqs(): " + e.toString());
    }
  }

  Future<dynamic> getGallery(int id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}list_gallery"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"vendor_id": id}),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        if (json.decode(response.body)["data"] != null) {
          recordList = List<Gallery>.from(json
              .decode(response.body)["data"]
              .map((x) => Gallery.fromJson(x)));
        } else {
          recordList = null;
        }
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getGallery(): " + e.toString());
    }
  }

  Future<dynamic> getHomePage(int id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}home_page"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"vendor_id": id}),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        if (json.decode(response.body)["data"] != null) {
          recordList = HomePage.fromJson(json.decode(response.body)["data"]);
        }
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getHomePage(): " + e.toString());
    }
  }

  Future<dynamic> getMyWallet(int id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}earnings"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"vendor_id": id}),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        if (json.decode(response.body)["data"] != null) {
          recordList = MyWallet.fromJson(json.decode(response.body)["data"]);
        }
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getMyWallet(): " + e.toString());
    }
  }

  Future<dynamic> getNotification(int id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}notifications"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"vendor_id": id}),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        if (json.decode(response.body)["data"] != null) {
          recordList = List<Notifications>.from(json
              .decode(response.body)["data"]
              .map((x) => Notifications.fromJson(x)));
        } else {
          recordList = null;
        }
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getNotification(): " + e.toString());
    }
  }

  Future<dynamic> getPartnerReview(int vendorId) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}partner_reviews"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"vendor_id": vendorId}),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        if (json.decode(response.body)["data"] != null) {
          recordList = List<Review>.from(json
              .decode(response.body)["data"]
              .map((x) => Review.fromJson(x)));
        } else {
          recordList = null;
        }
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getExpertReview(): " + e.toString());
    }
  }

  Future<dynamic> getPrivacyAndPolicy() async {
    try {
      final response = await http.post(
          Uri.parse("${global.baseUrl}privacy_policy"),
          headers: await global.getApiHeaders(false),
          body: json.encode({"lang": global.languageCode}));

      dynamic recordList;
      if (response.statusCode == 200) {
        if (json.decode(response.body)["data"] != null) {
          recordList =
              PrivacyAndPolicy.fromJson(json.decode(response.body)["data"]);
        } else {
          recordList = null;
        }
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getPrivacyAndPolicy(): " + e.toString());
    }
  }

  Future<dynamic> getProducts(int id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}product_list"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"vendor_id": id}),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        if (json.decode(response.body)["data"] != null) {
          recordList = List<Product>.from(json
              .decode(response.body)["data"]
              .map((x) => Product.fromJson(x)));
        } else {
          recordList = null;
        }
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getProducts(): " + e.toString());
    }
  }

  Future<dynamic> getService(int id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}list_service"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"vendor_id": id}),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        if (json.decode(response.body)["data"] != null) {
          recordList = List<Service>.from(json
              .decode(response.body)["data"]
              .map((x) => Service.fromJson(x)));
        }
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getServices(): " + e.toString());
    }
  }

  Future<dynamic> getUserProfile(int id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}partner_profile"),
        headers: await global.getApiHeaders(false),
        body: json.encode({
          "vendor_id": id,
          // "lang": global.languageCode,
        }),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = CurrentUser.fromJson(json.decode(response.body)["data"]);
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getUserProfile(): " + e.toString());
    }
  }

  Future<dynamic> getUserRequest(int id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}pending_orders"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"vendor_id": id}),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        if (json.decode(response.body)["data"] != null) {
          recordList = List<UserRequest>.from(json
              .decode(response.body)["data"]
              .map((x) => UserRequest.fromJson(x)));
        } else {
          recordList = null;
        }
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getUserRequest(): " + e.toString());
    }
  }

  Future<dynamic> loginWithEmail(CurrentUser user) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}partner_login"),
        headers: await global.getApiHeaders(false),
        body: json.encode(user),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body) != null &&
          json.decode(response.body)["data"] != null) {
        recordList = CurrentUser.fromJson(json.decode(response.body)["data"]);
        recordList.token = json.decode(response.body)["token"];
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - loginWithEmail(): " + e.toString());
    }
  }

  Future<dynamic> paidToAdmin(int id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}paid_to_admin"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"vendor_id": id}),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        if (json.decode(response.body)["data"] != null) {
          recordList = null;
        }
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - paidToAdmin(): " + e.toString());
    }
  }

  Future<dynamic> productOrders(int id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}product_orders"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"vendor_id": id, "lang": global.languageCode}),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        if (json.decode(response.body)["data"] != null) {
          recordList = List<ProductOrder>.from(json
              .decode(response.body)["data"]
              .map((x) => ProductOrder.fromJson(x)));
        }
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - productOrders(): " + e.toString());
    }
  }

  Future<dynamic> setting(int vendorId, String onlineStatus) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}shop_setting"),
        headers: await global.getApiHeaders(false),
        body:
            json.encode({"vendor_id": vendorId, "online_status": onlineStatus}),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body) != null &&
          json.decode(response.body)["data"] != null) {
        recordList = CurrentUser.fromJson(json.decode(response.body)["data"]);
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - setting(): " + e.toString());
    }
  }

  Future<dynamic> signUp(
      int type,
      String vendor_name,
      String owner_name,
      String vendor_email,
      String vendor_password,
      String device_id,
      String vendor_phone,
      String vendor_address,
      String description,
      File vendor_image) async {
    try {
      Response response;
      var dio = Dio();
      var formData = FormData.fromMap({
        'type': type,
        'vendor_name': vendor_name,
        'owner_name': owner_name,
        'vendor_email': vendor_email,
        'vendor_password': vendor_password,
        'device_id': device_id,
        'vendor_phone': vendor_phone,
        'vendor_address': vendor_address,
        'description': description,
        'vendor_image': vendor_image != null
            ? await MultipartFile.fromFile(vendor_image.path.toString())
            : null,
      });

      response = await dio.post('${global.baseUrl}partner_register',
          data: formData,
          options: Options(
            headers: await global.getApiHeaders(false),
          ));
      dynamic recordList;

      if (response.statusCode == 200 && response.data["status"] == "1") {
        recordList = CurrentUser.fromJson(response.data["data"]);
      } else {
        recordList = null;
      }

      return getAPIResultDio(response, recordList);
    } catch (e) {
      print("Exception - signUp(): " + e.toString());
    }
  }

  Future<dynamic> updateProfile(
    int vendor_id,
    String vendorName,
    String owner,
    String vendorPhone,
    String vendorLoc,
    String description,
    String vendorEmail,
    File? image,
  ) async {
    try {
      Response response;
      var dio = Dio();
      var formData = FormData.fromMap({
        'vendor_id': vendor_id,
        'vendor_name': vendorName,
        'owner': owner,
        'vendor_phone': vendorPhone,
        'vendor_loc': vendorLoc,
        'description': description,
        'vendor_email': vendorEmail,
        'vendor_logo': image != null
            ? await MultipartFile.fromFile(image.path.toString())
            : null,
      });

      response = await dio.post('${global.baseUrl}update_profile',
          data: formData,
          options: Options(
            headers: await global.getApiHeaders(false),
          ));
      dynamic recordList;

      if (response.statusCode == 200 && response.data["status"] == "1") {
        recordList = CurrentUser.fromJson(response.data["data"]);
      } else {
        recordList = null;
      }
      print(response.data.toString());
      return getAPIResultDio(response, recordList);
    } catch (e) {
      print("Exception - updateProfile(): " + e.toString());
    }
  }

  Future<dynamic> verifyOtp(String email, String otp) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}verifyOtp"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"vendor_email": email, "otp": otp}),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = CurrentUser.fromJson(json.decode(response.body)["data"]);
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - verifyOtp(): " + e.toString());
    }
  }

//!
  Future<dynamic> getMainServices({String type = 'service'}) async {
    try {
      final response = await http.get(
        Uri.parse(
            "https://salon.motaweron.com/api/get_main_services?type=$type"),
        headers: await global.getApiHeaders(false),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        if (json.decode(response.body)["data"] != null) {
          recordList = List<MainServices>.from(json
              .decode(response.body)["data"]
              .map((x) => MainServices.fromJson(x)));
        } else {
          recordList = null;
        }
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - MainServices(): " + e.toString());
    }
  }
}
