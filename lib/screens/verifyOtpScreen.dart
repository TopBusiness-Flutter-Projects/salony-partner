import 'dart:io';

import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/screens/changePasswordScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pinput/pin_put/pin_put.dart';

class VerifyOtpScreen extends BaseRoute {
  final String email;
  VerifyOtpScreen(this.email, {a, o}) : super(a: a, o: o, r: 'VerifyOtpScreen');
  @override
  _VerifyOtpScreenState createState() => new _VerifyOtpScreenState(this.email);
}

class _VerifyOtpScreenState extends BaseRouteState {
  String email;
  late GlobalKey<ScaffoldState> _scaffoldKey;
  final TextEditingController _pinPutController = TextEditingController();

  _VerifyOtpScreenState(this.email) : super();

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: Theme.of(context).primaryColor, width: 1));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return false;
      },
      child: sc(
        Scaffold(
            bottomNavigationBar: Container(
              margin: EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: TextButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  _verifyOtp();
                },
                child: Text(
                  AppLocalizations.of(context)!.btn_submit,
                ),
              ),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
            resizeToAvoidBottomInset: false,
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                Theme.of(context).primaryColor,
                                BlendMode.screen,
                              ),
                              child: Image.asset(
                                'assets/banner.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: Platform.isAndroid
                                ? EdgeInsets.only(bottom: 15, left: 10, top: 10)
                                : EdgeInsets.only(
                                    bottom: 15, left: 10, top: 20),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.keyboard_arrow_left_outlined,
                                  color: Colors.black,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.lbl_back,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 17.5),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                      ),
                      margin: EdgeInsets.only(top: 80),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          right: 10,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                                margin: EdgeInsets.only(top: 25),
                                child: Text(
                                  AppLocalizations.of(context)!.lbl_verify_otp,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .displaySmall,
                                )),
                            Container(
                              height: MediaQuery.of(context).size.height - 246,
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, bottom: 5),
                                        child: Column(
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .txt_enter_the_verification_code_from,
                                              style: Theme.of(context)
                                                  .primaryTextTheme
                                                  .headlineSmall,
                                            ),
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .txt_the_phone_we_just_sent_you,
                                              style: Theme.of(context)
                                                  .primaryTextTheme
                                                  .headlineSmall,
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: PinPut(
                                          textStyle:
                                              TextStyle(color: Colors.black),
                                          inputDecoration: InputDecoration(
                                              border: InputBorder.none,
                                              counterText: AppLocalizations.of(
                                                      context)!
                                                  .txt_check_your_mail_for_otp,
                                              enabledBorder: InputBorder.none,
                                              focusedBorder: InputBorder.none),
                                          autofocus: false,
                                          fieldsCount: 6,
                                          controller: _pinPutController,
                                          submittedFieldDecoration:
                                              _pinPutDecoration.copyWith(
                                            border: Border.all(
                                                width: 0,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          selectedFieldDecoration:
                                              _pinPutDecoration,
                                          followingFieldDecoration:
                                              _pinPutDecoration.copyWith(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            border: Border.all(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                width: 1),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            )),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  _verifyOtp() async {
    try {
      if (email.isNotEmpty && _pinPutController.text.isNotEmpty) {
        bool isConnected = await br.checkConnectivity();
        if (isConnected) {
          showOnlyLoaderDialog();

          await apiHelper
              ?.verifyOtp(email, _pinPutController.text.trim())
              .then((result) {
            if (result.status == "1") {
              hideLoader();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChangePasswordScreen(
                        true,
                        a: widget.analytics,
                        o: widget.observer,
                      )));
            } else {
              hideLoader();
              showSnackBar(snackBarMessage: '${result.message}');
            }
          });
        } else {
          showNetworkErrorSnackBar(_scaffoldKey);
        }
      } else if (email.isEmpty) {
        showSnackBar(
            snackBarMessage:
                AppLocalizations.of(context)!.txt_please_enter_email);
      } else if (_pinPutController.text.isEmpty) {
        showSnackBar(
            snackBarMessage:
                AppLocalizations.of(context)!.txt_please_enter_otp);
      }
    } catch (e) {
      print("Exception - verifyOtpScreen.dart - _verifyOtp():" + e.toString());
    }
  }
}
