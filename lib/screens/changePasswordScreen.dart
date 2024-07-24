import 'package:app/dialogs/changePasswordSuccessDialog.dart';
import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangePasswordScreen extends BaseRoute {
  final bool isFromVarifyOtp;

  ChangePasswordScreen(this.isFromVarifyOtp, {a, o})
      : super(a: a, o: o, r: 'ChangePasswordScreen');

  @override
  _ChangePasswordScreenState createState() =>
      new _ChangePasswordScreenState(this.isFromVarifyOtp);
}

class _ChangePasswordScreenState extends BaseRouteState {
  bool isFromVarifyOtp;
  TextEditingController _cEmail = new TextEditingController();
  TextEditingController _cPassword = new TextEditingController();
  TextEditingController _cConfirmPassword = new TextEditingController();
  TextEditingController _cOldPassword = new TextEditingController();
  bool _showOldPassword = true;
  bool _showNewPassword = true;
  bool _showConfirmPassword = true;
  late GlobalKey<ScaffoldState> _scaffoldKey;
  var _fOldPassword = FocusNode();
  var _fPassword = FocusNode();

  var _fConfirmPassword = FocusNode();
  var _fDismiss = FocusNode();

  _ChangePasswordScreenState(this.isFromVarifyOtp) : super();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return false;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Container(
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
         Colors.blueGrey.withOpacity(0.6),                                BlendMode.screen,
                              ),
                              child: Image.asset(
                                'assets/banner.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(bottom: 15, left: 10, top: 10),
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
                                  AppLocalizations.of(context)!
                                      .lbl_change_password,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .displaySmall,
                                )),
                            Expanded(
                              child: SingleChildScrollView(
                                physics: AlwaysScrollableScrollPhysics(),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom,
                                    top: 15,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      !isFromVarifyOtp
                                          ? Text(
                                              AppLocalizations.of(context)!
                                                  .lbl_old_password,
                                              style: Theme.of(context)
                                                  .primaryTextTheme
                                                  .titleSmall,
                                            )
                                          : SizedBox(),
                                      !isFromVarifyOtp
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 5),
                                              child: TextFormField(
                                                controller: _cOldPassword,
                                                obscureText: _showOldPassword,
                                                focusNode: _fOldPassword,
                                                onFieldSubmitted: (val) {
                                                  FocusScope.of(context)
                                                      .requestFocus(_fPassword);
                                                },
                                                decoration: InputDecoration(
                                                  hintText: AppLocalizations.of(
                                                          context)!
                                                      .hnt_password,
                                                  prefixIcon: Icon(
                                                    Icons.lock,
                                                  ),
                                                  suffixIcon: IconButton(
                                                    onPressed: () {
                                                      _showOldPassword =
                                                          !_showOldPassword;
                                                      setState(() {});
                                                    },
                                                    icon: Icon(_showOldPassword
                                                        ? Icons.visibility_off
                                                        : Icons.visibility),
                                                    color: Colors.black,
                                                  ),
                                                  contentPadding:
                                                      EdgeInsets.only(top: 5),
                                                ),
                                              ),
                                            )
                                          : SizedBox(),
                                      isFromVarifyOtp
                                          ? Container(
                                              margin: EdgeInsets.only(top: 10),
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .lblEmail,
                                                style: Theme.of(context)
                                                    .primaryTextTheme
                                                    .titleSmall,
                                              ),
                                            )
                                          : SizedBox(),
                                      isFromVarifyOtp
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 5),
                                              child: TextFormField(
                                                controller: _cEmail,
                                                onFieldSubmitted: (val) {
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          _fConfirmPassword);
                                                },
                                                decoration: InputDecoration(
                                                  hintText: AppLocalizations.of(
                                                          context)!
                                                      .hnt_email,
                                                  prefixIcon: Icon(Icons.mail),
                                                  contentPadding:
                                                      EdgeInsets.only(top: 5),
                                                ),
                                              ),
                                            )
                                          : SizedBox(),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Text(
                                          isFromVarifyOtp
                                              ? AppLocalizations.of(context)!
                                                  .lblPassword
                                              : AppLocalizations.of(context)!
                                                  .lbl_new_password,
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .titleSmall,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: TextFormField(
                                          controller: _cPassword,
                                          obscureText: _showNewPassword,
                                          onFieldSubmitted: (val) {
                                            FocusScope.of(context).requestFocus(
                                                _fConfirmPassword);
                                          },
                                          decoration: InputDecoration(
                                            hintText:
                                                AppLocalizations.of(context)!
                                                    .hnt_password,
                                            prefixIcon: Icon(Icons.lock),
                                            suffixIcon: IconButton(
                                              icon: Icon(_showNewPassword
                                                  ? Icons.visibility_off
                                                  : Icons.visibility),
                                              color: Colors.black,
                                              onPressed: () {
                                                _showNewPassword =
                                                    !_showNewPassword;
                                                setState(() {});
                                              },
                                            ),
                                            contentPadding:
                                                EdgeInsets.only(top: 5),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .lbl_confirm_password,
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .titleSmall,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: TextFormField(
                                          obscureText: _showConfirmPassword,
                                          controller: _cConfirmPassword,
                                          onFieldSubmitted: (val) {
                                            FocusScope.of(context)
                                                .requestFocus(_fDismiss);
                                          },
                                          decoration: InputDecoration(
                                            hintText:
                                                AppLocalizations.of(context)!
                                                    .hnt_password,
                                            prefixIcon: Icon(
                                              Icons.lock,
                                            ),
                                            suffixIcon: IconButton(
                                              icon: Icon(_showConfirmPassword
                                                  ? Icons.visibility_off
                                                  : Icons.visibility),
                                              color: Colors.black,
                                              onPressed: () {
                                                _showConfirmPassword =
                                                    !_showConfirmPassword;
                                                setState(() {});
                                              },
                                            ),
                                            contentPadding:
                                                EdgeInsets.only(top: 5),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        margin: EdgeInsets.only(top: 25),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: TextButton(
                                          onPressed: () {
                                            _changePassword();
                                          },
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .btn_change_password,
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
            ),
          )),
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

  _changePassword() async {
    try {
      if (isFromVarifyOtp) // change password from otp...
      {
        if (_cPassword.text.isNotEmpty &&
            _cPassword.text == _cConfirmPassword.text) {
          bool isConnected = await br.checkConnectivity();
          if (isConnected) {
            showOnlyLoaderDialog();

            await apiHelper
                ?.changePasswordFromOtp(
                    _cEmail.text.trim(), _cPassword.text.trim())
                .then((result) {
              if (result.status == "1") {
                hideLoader();

                showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        ChangePasswordSuccessDialog(
                          a: widget.analytics,
                          o: widget.observer,
                        ));
              } else {
                hideLoader();
                showSnackBar(snackBarMessage: '${result.message}');
              }
            });
          } else {
            showNetworkErrorSnackBar(_scaffoldKey);
          }
        } else if (_cEmail.text.isEmpty) {
          showSnackBar(
              snackBarMessage:
                  AppLocalizations.of(context)!.txt_please_enter_email);
        } else if (_cPassword.text != _cConfirmPassword.text) {
          showSnackBar(
              snackBarMessage: AppLocalizations.of(context)!
                  .txt_password_and_confirm_password_do_not_match);
        }
      } else //simple change password
      {
        if (_cPassword.text.isNotEmpty &&
            _cPassword.text == _cConfirmPassword.text &&
            _cOldPassword.text.isNotEmpty) {
          bool isConnected = await br.checkConnectivity();
          if (isConnected) {
            showOnlyLoaderDialog();

            await apiHelper
                ?.changePassword(global.user.id!, _cOldPassword.text.trim(),
                    _cPassword.text.trim(), _cConfirmPassword.text.trim())
                .then((result) {
              if (result.status == "1") {
                hideLoader();

                showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        ChangePasswordSuccessDialog(
                          a: widget.analytics,
                          o: widget.observer,
                        ));
              } else {
                hideLoader();
                showSnackBar(snackBarMessage: '${result.message}');
              }
            });
          } else {
            showNetworkErrorSnackBar(_scaffoldKey);
          }
        } else if (_cOldPassword.text.isEmpty) {
          showSnackBar(
              snackBarMessage:
                  AppLocalizations.of(context)!.txt_please_enter_old_password);
        } else if (_cPassword.text != _cConfirmPassword.text) {
          showSnackBar(
              snackBarMessage: AppLocalizations.of(context)!
                  .txt_password_and_confirm_password_do_not_match);
        } else if (_cPassword.text.isEmpty) {
          showSnackBar(
              snackBarMessage:
                  AppLocalizations.of(context)!.txt_please_enter_new_password);
        }
      }
    } catch (e) {
      print("Exception - changePassword.dart - _changePassword():" +
          e.toString());
    }
  }
}
