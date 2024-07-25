import 'dart:async';
import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/businessRule.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../constants.dart';
import 'changePasswordScreen.dart';

class OTPVerificationPhoneScreen extends BaseRoute {
  final int? screenId;
  final String? verificationId;
  final String? phoneNumberOrEmail;
  OTPVerificationPhoneScreen(
      {a, o, this.screenId, this.verificationId, this.phoneNumberOrEmail})
      : super(a: a, o: o, r: 'OTPVerificationScreen');
  @override
  _OTPVerificationScreenState createState() => new _OTPVerificationScreenState(
      screenId: screenId,
      verificationId: verificationId,
      phoneNumberOrEmail: this.phoneNumberOrEmail);
}

class _OTPVerificationScreenState extends BaseRouteState {
  GlobalKey<ScaffoldState>? _scaffoldKey;
  String? phoneNumberOrEmail;
  String? verificationId;
  int _seconds = 60;
  late Timer _countDown;
  var _cCode = new TextEditingController();
  String? status;
  int? screenId;
  late BusinessRule br;
  _OTPVerificationScreenState(
      {this.screenId, this.verificationId, this.phoneNumberOrEmail})
      : super();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return true;
      },
      child: sc(Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            automaticallyImplyLeading: false,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
              child: Column(
                children: [
                  Text(
                    "التحقق من كلمة المرور  (OTP)",
                    style: Theme.of(context).primaryTextTheme.caption,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "أدخل رمز التحقق من هاتفك الذي أرسلناه إليك للتو.",
                      style: Theme.of(context).primaryTextTheme.headline3,
                    ),
                  ),
                  PinFieldAutoFill(
                    key: Key("1"),
                    decoration: BoxLooseDecoration(
                        textStyle: TextStyle(fontSize: 20, color: Colors.black),
                        strokeColorBuilder:
                            FixedColorBuilder(Colors.transparent),
                        bgColorBuilder: FixedColorBuilder(Colors.grey[100]!),
                        hintText: '••••••',
                        hintTextStyle:
                            TextStyle(fontSize: 70, color: Colors.black)),
                    currentCode: _cCode.text,
                    controller: _cCode,
                    codeLength: 6,
                    keyboardType: TextInputType.number,
                    onCodeSubmitted: (code) {
                      setState(() {
                        _cCode.text = code;
                      });
                    },
                    onCodeChanged: (code) async {
                      if (code!.length == 6) {
                        _cCode.text = code;
                        setState(() {});
                        FocusScope.of(context).requestFocus(FocusNode());
                        // _verifyForgotPasswordOtp();
                        verifySmsCode(_cCode.text, context ,phoneNumberOrEmail??'' );
                      }
                    },
                  ),
                  Container(
                      height: 50,
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 10),
                      child: TextButton(
                          onPressed: () async {
                            verifySmsCode(
                                _cCode.text, context,phoneNumberOrEmail??'');
                          },
                          child: Text('التحقق من كود'))),
                  Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 30,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("بالنقر على رمز التحقق أعلاه، فإنك توافق",
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .titleMedium),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ))),
    );
  }

  @override
  void dispose() {
    super.dispose();
    SmsAutoFill().unregisterListener();
  }

  @override
  void initState() {
    super.initState();
    OTPInteractor()
        .getAppSignature()
        //ignore: avoid_print
        .then((value) => print('signature - $value'));
    _cCode = OTPTextEditController(
      codeLength: 6,
      //ignore: avoid_print
      onCodeReceive: (code) {
        setState(() {
          _cCode.text = code;
        });
      },
    )..startListenUserConsent(
        (code) {
          final exp = RegExp(r'(\d{6})');
          return exp.stringMatch(code ?? '') ?? '';
        },
        strategies: [],
      );
    _init();
    startTimer();
  }

  Future startTimer() async {
    try {
      setState(() {});
      const oneSec = const Duration(seconds: 1);
      _countDown = new Timer.periodic(
        oneSec,
        (timer) {
          if (_seconds == 0) {
            setState(() {
              _countDown.cancel();
              timer.cancel();
            });
          } else {
            setState(() {
              _seconds--;
            });
          }
        },
      );

      setState(() {});
    } catch (e) {
      print("Exception - otpVerificationScreen.dart - startTimer():" +
          e.toString());
    }
  }

  _init() async {
    try {
      SmsAutoFill().listenForCode;
    } catch (e) {
      print("Exception - otpVerificationScreen.dart - _init():" + e.toString());
    }
  }

  // _verifyForgotPasswordOtp() async {
  //   try {
  //     if (_cCode.text.length == 6) {
  //       showOnlyLoaderDialog();
  //       // if(){}
  //       await apiHelper!
  //           .verifyOtpForgotPassword(phoneNumberOrEmail, _cCode.text)
  //           .then((result) {
  //         if (result != null) {
  //           if (result.status == "1") {
  //             hideLoader();
  //             Navigator.of(context).push(MaterialPageRoute(
  //                 builder: (context) => ResetPasswordScreen(
  //                       phoneNumberOrEmail,
  //                       a: widget.analytics,
  //                       o: widget.observer,
  //                     )));
  //           } else {
  //             hideLoader();
  //             showSnackBar(
  //                 key: _scaffoldKey, snackBarMessage: '${result.message}');
  //             setState(() {});
  //           }
  //         }
  //       });
  //     } else {
  //       showSnackBar(
  //           key: _scaffoldKey, snackBarMessage: 'Please enter 6 digit OTP');
  //     }
  //   } catch (e) {
  //     print(
  //         "Exception - otpVerificationScreen.dart - _verifyForgotPasswordOtp():" +
  //             e.toString());
  //   }
  // }

  verifySmsCode(
      String smsCode, BuildContext context, String phoneNumberOrEmail) async {
    print(verificationId);
    showOnlyLoaderDialog();
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId!,
      smsCode: smsCode,
    );
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      setState(() {});
      hideLoader();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ChangePasswordScreen(
                phoneNumberOrEmail,
                a: widget.analytics,
                o: widget.observer,
              )));
    }).catchError((error) {
      hideLoader();
      Fluttertoast.showToast(msg: error.toString());
      setState(() {});
    });
  }
}
