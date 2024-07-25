import 'dart:async';
import 'dart:io';

import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/partnerUserModel.dart';
import 'package:app/screens/chooseSignUpSignInScreen.dart';
import 'package:app/screens/signUpScreen.dart';
import 'package:app/screens/verifyOtpScreen.dart';
import 'package:app/widgets/bottomNavigationBar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../constants.dart';
import 'otpVerificationScreen.dart';

class SignInScreen extends BaseRoute {
  final int? screenId;

  SignInScreen({a, o, this.screenId}) : super(a: a, o: o, r: 'SignInScreen');

  @override
  _SignInScreenState createState() =>
      new _SignInScreenState(screenId: screenId);
}

class _SignInScreenState extends BaseRouteState {
  bool _isValidateEmail = false;
  bool _isValidate = false;
  var _fPassword = new FocusNode();

  TextEditingController _cPhone = new TextEditingController();
  TextEditingController _cPassword = new TextEditingController();
  TextEditingController _cForgotEmail = new TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int? screenId;
  CurrentUser user = new CurrentUser();
  bool _showPassword = true;
  bool _isRemember = false;

  _SignInScreenState({this.screenId}) : super();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        screenId == 1
            ? exitAppDialog()
            : Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ChooseSignUpSignInScreen(
                      a: widget.analytics,
                      o: widget.observer,
                    )));
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: SafeArea(
            child: Stack(
              children: [
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Colors.blueGrey.withOpacity(0.6),
                            BlendMode.screen,
                          ),
                          child: Image.asset(
                            'assets/banner.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 15, left: 10, top: 10),
                        child: GestureDetector(
                          onTap: () {
                            screenId == 1
                                ? exitAppDialog()
                                : Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ChooseSignUpSignInScreen(
                                              a: widget.analytics,
                                              o: widget.observer,
                                            )),
                                  );
                          },
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
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    ),
                    margin: EdgeInsets.only(top: Platform.isIOS ? 100 : 80),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.only(top: 30, bottom: 10),
                              child: Text(
                                AppLocalizations.of(context)!.lblSignIn,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .displaySmall,
                              )),
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'رقم الهاتف',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .titleSmall,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: TextFormField(
                                    keyboardType: TextInputType.phone,
                                    onEditingComplete: () {
                                      FocusScope.of(context)
                                          .requestFocus(_fPassword);
                                    },
                                    controller: _cPhone,
                                    onChanged: (val) {
                                      _isValidate = true;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'أدخل رقم الهاتف',
                                      prefixIcon: Icon(Icons.phone),
                                      contentPadding: EdgeInsets.only(top: 5),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(
                                    AppLocalizations.of(context)!.lblPassword,
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .titleSmall,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: TextFormField(
                                    focusNode: _fPassword,
                                    controller: _cPassword,
                                    obscureText: _showPassword,
                                    onFieldSubmitted: (val) {},
                                    decoration: InputDecoration(
                                      hintText: '******',
                                      prefixIcon: Icon(Icons.lock),
                                      suffixIcon: IconButton(
                                        icon: Icon(_showPassword
                                            ? Icons.visibility_off
                                            : Icons.visibility),
                                        onPressed: () {
                                          _showPassword = !_showPassword;
                                          setState(() {});
                                        },
                                      ),
                                      contentPadding: EdgeInsets.only(top: 5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 17,
                                      width: 17,
                                      child: Checkbox(
                                          value: _isRemember,
                                          onChanged: (val) {
                                            _isRemember = val!;
                                            setState(() {});
                                            if (!_isRemember) {
                                              global.sp
                                                  .remove('isRememberMeEmail');
                                            }
                                          }),
                                    ),
                                    Container(
                                        margin: global.isRTL
                                            ? EdgeInsets.only(right: 7)
                                            : EdgeInsets.only(left: 7),
                                        child: GestureDetector(
                                          onTap: () {
                                            _isRemember = !_isRemember;
                                            setState(() {});
                                            if (!_isRemember) {
                                              global.sp
                                                  .remove('isRememberMeEmail');
                                            }
                                          },
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .lblRememberMe,
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .titleSmall,
                                          ),
                                        )),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _forgotPassword();
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .lblForgotPassword,
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .displayLarge,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 50,
                            margin: EdgeInsets.only(top: 25),
                            width: MediaQuery.of(context).size.width,
                            child: TextButton(
                              onPressed: () {
                                _loginWithEmail();
                              },
                              child: Text(
                                AppLocalizations.of(context)!.btnSignIn,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 25, left: 30),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!
                                      .txt_if_you_have_no_account,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .titleSmall,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => SignUpScreen(
                                                  a: widget.analytics,
                                                  o: widget.observer,
                                                )));
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.btnSignUp,
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .displayLarge,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (global.sp.getString('isRememberMeEmail') != null) {
      _cPhone.text = global.sp.getString('isRememberMeEmail')!;
      _isRemember = true;
      _isValidate = true;
    }
  }

  Future _forgotPassword() async {
    try {
      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(
                  AppLocalizations.of(context)!.lbl_forgot_password,
                  textAlign: TextAlign.center,
                ),
                titleTextStyle: Theme.of(context).primaryTextTheme.displaySmall,
                content: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          'ادخل رقم الهاتف',
                          style: Theme.of(context).primaryTextTheme.titleSmall,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: TextFormField(
                          controller: _cForgotEmail,
                          decoration: InputDecoration(
                            hintText: 'رقم الهاتف',
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Theme.of(context).primaryColor,
                            ),
                            contentPadding: EdgeInsets.only(top: 5, left: 10),
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 17),
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: TextButton(
                          onPressed: () async {
                            bool isConnected = await br.checkConnectivity();
                            if (isConnected) {
                              _sendOTP(_cForgotEmail.text.trim());
                            }
                          },
                          child: Text(
                            AppLocalizations.of(context)!.btn_send_code,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )).then((paymentMode2) {});
    } catch (e) {
      print('Exception: signInScreen: _forgotPassword(): ${e.toString()}');
    }
  }

  _loginWithEmail() async {
    try {
      FocusScope.of(context).unfocus();
      user.vendor_phone = _cPhone.text.trim();
      user.vendor_password = _cPassword.text.trim();
      user.device_id = global.appDeviceId;

      if (_cPhone.text.isNotEmpty &&
          _cPassword.text.isNotEmpty &&
          _cPassword.text.trim().length >= 2 &&
          _isValidate) {
        bool isConnected = await br.checkConnectivity();
        if (isConnected) {
          showOnlyLoaderDialog();
          await apiHelper?.loginWithEmail(user).then((result) async {
            if (result != null) {
              if (result.status == "1") {
                global.user = result.recordList;
                br.saveUser(global.user);
                if (_isRemember) {
                  await global.sp
                      .setString('isRememberMeEmail', _cPhone.text.trim());
                }
                hideLoader();

                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => BottomNavigationWidget(
                            a: widget.analytics,
                            o: widget.observer,
                          )),
                );
              } else {
                hideLoader();
                showSnackBar(snackBarMessage: '${result.message}');
              }
            }
          });
        } else {
          showNetworkErrorSnackBar(_scaffoldKey);
        }
      } else if (_cPhone.text.isEmpty) {
        showSnackBar(snackBarMessage: 'Please enter valid Email Id');
      } else if (_cPassword.text.isEmpty || _cPassword.text.trim().length < 2) {
        showSnackBar(
            snackBarMessage: 'Password should be of minimun 2 characters');
      } else if (_cPhone.text.isEmpty || !_isValidate) {
        showSnackBar(snackBarMessage: 'Please enter valid email');
      }
    } catch (e) {
      print(
          "Exception - signInScreen.dart - _loginWithEmail():" + e.toString());
    }
  }

  _sendOTP(String phoneNumber) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '$phoneCode$phoneNumber',
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          hideLoader();
          showSnackBar(
              snackBarMessage: "الرجاء المحاولة مرة أخرى بعد فترة من الزمن");
        },
        codeSent: (String verificationId, int? resendToken) async {
          hideLoader();
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => OTPVerificationPhoneScreen(
                      a: widget.analytics,
                      o: widget.observer,
                      screenId: 1,
                      verificationId: verificationId,
                      phoneNumberOrEmail: phoneNumber,
                    )),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      print("Exception - addPhoneScreen.dart - _sendOTP():" + e.toString());
    }
  }
}
