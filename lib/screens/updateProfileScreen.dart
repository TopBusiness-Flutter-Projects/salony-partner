import 'dart:io';

import 'package:app/dialogs/updateProfileSuccessDialog.dart';
import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/partnerUserModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpdateProfileScreen extends BaseRoute {
  final CurrentUser userFromProfile;

  UpdateProfileScreen(this.userFromProfile, {a, o}) : super(a: a, o: o, r: 'UpdateProfileScreen');
  @override
  _UpdateProfileScreenState createState() => new _UpdateProfileScreenState(this.userFromProfile);
}

class _UpdateProfileScreenState extends BaseRouteState {
  CurrentUser userFromProfile;
  bool _isValidate = false;

  TextEditingController _cVenderName = new TextEditingController();
  TextEditingController _cOwnerName = new TextEditingController();
  TextEditingController _cPhoneNumber = new TextEditingController();
  TextEditingController _cAddress = new TextEditingController();
  TextEditingController _cDescription = new TextEditingController();
  TextEditingController _cEmail = new TextEditingController();
  File? _tImage;
  var _fOwnerName = new FocusNode();
  var _fPhoneNumber = new FocusNode();
  var _fAddress = new FocusNode();
  var _fEmail = new FocusNode();

  late GlobalKey<ScaffoldState> _scaffoldKey;
  var dropdownval;

  _UpdateProfileScreenState(
    this.userFromProfile,
  ) : super();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop();
          return false;
        },
        child: Scaffold(
            bottomNavigationBar: Container(
              margin: EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: TextButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  updateProfile();
                },
                child: Text(
                  AppLocalizations.of(context)!.btn_update_profile,
                ),
              ),
              decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
            resizeToAvoidBottomInset: false,
            body: SafeArea(
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
                          padding: Platform.isAndroid ? EdgeInsets.only(bottom: 15, left: 10, top: 10) : EdgeInsets.only(bottom: 15, left: 10, top: 50),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.keyboard_arrow_left_outlined,
                                  color: Colors.black,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.lbl_back,
                                  style: TextStyle(color: Colors.black, fontSize: 17.5),
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
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                      ),
                      margin: EdgeInsets.only(top: 80),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          width: MediaQuery.of(context).size.width,
                          child: Column(children: [
                            Container(
                                margin: EdgeInsets.only(top: 30, bottom: 10),
                                child: Text(
                                  AppLocalizations.of(context)!.lbl_update_profile,
                                  style: Theme.of(context).primaryTextTheme.displaySmall,
                                )),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 15, bottom: MediaQuery.of(context).viewInsets.bottom),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.lbl_parlour_name,
                                        style: Theme.of(context).primaryTextTheme.titleSmall,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 3, bottom: 3),
                                        child: TextFormField(
                                          textCapitalization: TextCapitalization.words,
                                          onEditingComplete: () {
                                            FocusScope.of(context).requestFocus(_fEmail);
                                          },
                                          controller: _cVenderName,
                                          decoration: InputDecoration(
                                            hintText: AppLocalizations.of(context)!.hnt_parlour_name,
                                            contentPadding: EdgeInsets.only(top: 5, left: 10, right: 10),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!.lblEmail,
                                        style: Theme.of(context).primaryTextTheme.titleSmall,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 3, bottom: 3),
                                        child: TextFormField(
                                          focusNode: _fEmail,
                                          onEditingComplete: () {
                                            FocusScope.of(context).requestFocus(_fOwnerName);
                                          },
                                          onChanged: (val) {
                                            _isValidate = EmailValidator.validate(val);
                                          },
                                          textCapitalization: TextCapitalization.words,
                                          controller: _cEmail,
                                          decoration: InputDecoration(
                                            hintText: AppLocalizations.of(context)!.hnt_email,
                                            contentPadding: EdgeInsets.only(top: 5, left: 10, right: 10),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!.lbl_owner_name,
                                        style: Theme.of(context).primaryTextTheme.titleSmall,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 3, bottom: 3),
                                        child: TextFormField(
                                          textCapitalization: TextCapitalization.words,
                                          onEditingComplete: () {
                                            FocusScope.of(context).requestFocus(_fPhoneNumber);
                                          },
                                          focusNode: _fOwnerName,
                                          controller: _cOwnerName,
                                          decoration: InputDecoration(
                                            hintText: AppLocalizations.of(context)!.hnt_owner_name,
                                            contentPadding: EdgeInsets.only(top: 5, left: 10, right: 10),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!.lbl_phone_number,
                                        style: Theme.of(context).primaryTextTheme.titleSmall,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 3, bottom: 3),
                                        child: TextFormField(
                                          keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                                          onEditingComplete: () {
                                            FocusScope.of(context).unfocus();
                                          },
                                          focusNode: _fPhoneNumber,
                                          controller: _cPhoneNumber,
                                          decoration: InputDecoration(
                                            hintText: AppLocalizations.of(context)!.hnt_phone_number,
                                            contentPadding: EdgeInsets.only(top: 5, left: 10, right: 10),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!.lbl_address,
                                        style: Theme.of(context).primaryTextTheme.titleSmall,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 3, bottom: 3),
                                        child: TextFormField(
                                          textCapitalization: TextCapitalization.words,
                                          focusNode: _fAddress,
                                          controller: _cAddress,
                                          maxLines: 3,
                                          decoration: InputDecoration(
                                            hintText: AppLocalizations.of(context)!.hnt_address,
                                            contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Text(
                                          AppLocalizations.of(context)!.lbl_description,
                                          style: Theme.of(context).primaryTextTheme.titleSmall,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 3, bottom: 3),
                                        child: TextFormField(
                                          textCapitalization: TextCapitalization.sentences,
                                          controller: _cDescription,
                                          maxLines: 3,
                                          decoration: InputDecoration(
                                            hintText: AppLocalizations.of(context)!.hnt_address,
                                            contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!.lbl_upload_image,
                                        style: Theme.of(context).primaryTextTheme.titleSmall,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Stack(alignment: AlignmentDirectional.bottomEnd, children: [
                                              CircleAvatar(
                                                radius: 50,
                                                child: _generateVendorLogoWidget(),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  FocusScope.of(context).unfocus();
                                                  _showCupertinoModalSheet();
                                                },
                                                child: CircleAvatar(
                                                  radius: 20,
                                                  child: Icon(Icons.image),
                                                ),
                                              )
                                            ]),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ]))),
                ],
              ),
            ),
          ),
        );
  }

  Widget? _generateVendorLogoWidget() {
    if (_tImage != null) {
      return CircleAvatar(radius: 50, backgroundImage: FileImage(_tImage!));
    } else {
        if (userFromProfile.vendor_logo != "N/A") {
          return CachedNetworkImage(
            imageUrl: global.baseUrlForImage + userFromProfile.vendor_logo!,
            imageBuilder: (context, imageProvider) => CircleAvatar(
              radius: 50,
              backgroundImage: imageProvider,
            ),
            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Icon(Icons.error),
          );
      } else {
        return Image.asset('assets/userImage.png');
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  updateProfile() async {
    try {
      if (_cVenderName.text.isNotEmpty && _cPhoneNumber.text.isNotEmpty && _cPhoneNumber.text.length == 10 && _isValidate) {
        bool isConnected = await br.checkConnectivity();
        if (isConnected) {
          showOnlyLoaderDialog();
          await apiHelper?.updateProfile(global.user.id!, _cVenderName.text.trim(), _cOwnerName.text.trim(), _cPhoneNumber.text.trim(), _cAddress.text.trim(), _cDescription.text.trim(), _cEmail.text.trim(), _tImage!).then((result) async {
            if (result.status == "1") {
              global.user = result.recordList;
              br.saveUser(global.user);
              if (global.sp.getString('isRememberMeEmail') != null) {
                await global.sp.setString('isRememberMeEmail', _cEmail.text.trim());
              }

              hideLoader();
              showDialog(
                  context: context,
                  builder: (BuildContext context) => UpdateProfileSuccessDialog(
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
      } else if (_cVenderName.text.isEmpty) {
        showSnackBar(snackBarMessage: AppLocalizations.of(context)!.txt_please_enter_parlour_name);
      } else if (_cPhoneNumber.text.isEmpty) {
        showSnackBar(snackBarMessage: AppLocalizations.of(context)!.txt_please_enter_phone_number);
      } else if (_cPhoneNumber.text.length != 10) {
        showSnackBar(snackBarMessage: AppLocalizations.of(context)!.txt_please_enter_valid_phone_number);
      } else if (!_isValidate || _cEmail.text.isEmpty) {
        showSnackBar(snackBarMessage: AppLocalizations.of(context)!.txt_please_enter_valid_email);
      }
    } catch (e) {
      print("Exception - updateProfileScreen.dart - _updateProfile():" + e.toString());
    }
  }

  _init() {
    try {
      setState(() {
        _cVenderName.text = userFromProfile.salon_name!;
        _cOwnerName.text = userFromProfile.owner_name!;
        _cPhoneNumber.text = global.user.vendor_phone!;
        _cAddress.text = userFromProfile.vendor_address!;
        _cDescription.text = userFromProfile.description!;
        _cEmail.text = global.user.vendor_email!;
        _isValidate = EmailValidator.validate(global.user.vendor_email!);
      });
    } catch (e) {
      print("Exception - updateProfileScreen.dart - _init():" + e.toString());
    }
  }

  _showCupertinoModalSheet() {
    try {
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          title: Text(AppLocalizations.of(context)!.lbl_action),
          actions: [
            CupertinoActionSheetAction(
              child: Text(AppLocalizations.of(context)!.lbl_take_picture, style: TextStyle(color: Color(0xFF171D2C))),
              onPressed: () async {
                Navigator.pop(context);
                showOnlyLoaderDialog();
                _tImage = await br.openCamera();
                hideLoader();

                
                setState(() {});
              },
            ),
            CupertinoActionSheetAction(
              child: Text(AppLocalizations.of(context)!.lbl_choose_from_library, style: TextStyle(color: Color(0xFF171D2C))),
              onPressed: () async {
                Navigator.pop(context);
                showOnlyLoaderDialog();
                _tImage = await br.selectImageFromGallery();
                hideLoader();
                
                setState(() {});
              },
            )
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text(AppLocalizations.of(context)!.lbl_cancel, style: TextStyle(color: Color(0xFFFA692C))),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      );
    } catch (e) {
      print("Exception - updateProfileScreen.dart - _showCupertinoModalSheet():" + e.toString());
    }
  }
}
