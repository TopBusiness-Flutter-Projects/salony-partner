import 'dart:io';

import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/partnerUserModel.dart';
import 'package:app/screens/signInScreen.dart';
import 'package:app/widgets/bottomNavigationBar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/DistrictModel.dart';
import '../models/city_model.dart';
import '../models/region_model.dart';

class GeneralInformationScreen extends BaseRoute {
  final String email;
  final String password;

  GeneralInformationScreen(this.email, this.password, {a, o})
      : super(a: a, o: o, r: 'GeneralInformationScreen');

  @override
  _GeneralInformationScreenState createState() =>
      new _GeneralInformationScreenState(this.email, this.password);
}

class _GeneralInformationScreenState extends BaseRouteState {
  String email;
  String password;
  CurrentUser user = new CurrentUser();
  TextEditingController _cVenderName = new TextEditingController();
  TextEditingController _cOwnerName = new TextEditingController();
  TextEditingController _cChairCount = new TextEditingController();
  TextEditingController _cPhoneNumber = new TextEditingController();
  TextEditingController _cAddress = new TextEditingController();
  TextEditingController _cDescription = new TextEditingController();
  File? _tImage;
  var _fOwnerName = new FocusNode();
  var _fChairCount = new FocusNode();
  var _fPhoneNumber = new FocusNode();
  var _fAddress = new FocusNode();

  late GlobalKey<ScaffoldState> _scaffoldKey;
  int _saloonType = 2;

  var dropdownval;

  _GeneralInformationScreenState(this.email, this.password) : super();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop();
          return false;
        },
        child: sc(
          Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
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
                        padding: Platform.isAndroid
                            ? EdgeInsets.only(bottom: 15, left: 10, top: 10)
                            : EdgeInsets.only(bottom: 15, left: 10, top: 20),
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
                                AppLocalizations.of(context)!
                                    .lbl_generall_information,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .displaySmall,
                              )),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 15,
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .lbl_parlour_name,
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .titleSmall,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: TextFormField(
                                        textCapitalization:
                                            TextCapitalization.words,
                                        onEditingComplete: () {
                                          FocusScope.of(context)
                                              .requestFocus(_fOwnerName);
                                        },
                                        controller: _cVenderName,
                                        decoration: InputDecoration(
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .hnt_parlour_name,
                                          contentPadding:
                                              EdgeInsets.only(top: 5, left: 10),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!
                                          .lbl_owner_name,
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .titleSmall,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: TextFormField(
                                        textCapitalization:
                                            TextCapitalization.words,
                                        onEditingComplete: () {
                                          FocusScope.of(context)
                                              .requestFocus(_fPhoneNumber);
                                        },
                                        focusNode: _fOwnerName,
                                        controller: _cOwnerName,
                                        decoration: InputDecoration(
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .hnt_owner_name,
                                          contentPadding:
                                              EdgeInsets.only(top: 5, left: 10),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'عدد الكراسي',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .titleSmall,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        textCapitalization:
                                            TextCapitalization.none,
                                        onEditingComplete: () {
                                          FocusScope.of(context)
                                              .requestFocus(_fChairCount);
                                        },
                                        focusNode: _fChairCount,
                                        controller: _cChairCount,
                                        decoration: InputDecoration(
                                          hintText: 'ادخل عدد الكراسي',
                                          contentPadding:
                                              EdgeInsets.only(top: 5, left: 10),
                                        ),
                                      ),
                                    ),
                                    //!
                                    Text(
                                      AppLocalizations.of(context)!
                                          .lbl_phone_number,
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .titleSmall,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: TextFormField(
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                signed: true, decimal: true),
                                        onEditingComplete: () {
                                          FocusScope.of(context).unfocus();
                                        },
                                        focusNode: _fPhoneNumber,
                                        controller: _cPhoneNumber,
                                        decoration: InputDecoration(
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .hnt_phone_number,
                                          contentPadding:
                                              EdgeInsets.only(top: 5, left: 10),
                                        ),
                                      ),
                                    ),
                                    //!  address
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Text(
                                        'عنوان الصالون',
                                      ),
                                    ),

                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 15), // color: Colors.red,
                                      // height: 10,
                                      child:
                                          DropdownButtonFormField2<RegionModel>(
                                        isExpanded: true,
                                        decoration: InputDecoration(
                                          // Add Horizontal padding using menuItemStyleData.padding so it matches
                                          // the menu padding when button's width is not specified.
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 16),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          // Add more decoration..
                                        ),
                                        hint: const Text(
                                          'اختر منطقتك',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        items: regions
                                            .map((item) =>
                                                DropdownMenuItem<RegionModel>(
                                                  value: item,
                                                  child: Text(
                                                    item.nameAr ?? '',
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ))
                                            .toList(),
                                        validator: (value) {
                                          if (value == null) {
                                            return 'من فضلك اختر بلدك';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          cities = [];
                                          districts = [];
                                          regionModel = value;
                                          cityModel = null;
                                          districtModel = null;
                                          setState(() {});

                                          _getCities(id: value!.regionId ?? 1);

                                          //Do something when selected item is changed.
                                        },
                                        onSaved: (value) {
                                          regionModel = value;
                                        },
                                        buttonStyleData: const ButtonStyleData(
                                          padding: EdgeInsets.only(right: 8),
                                        ),
                                        iconStyleData: const IconStyleData(
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.black45,
                                          ),
                                          iconSize: 24,
                                        ),
                                        dropdownStyleData: DropdownStyleData(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        menuItemStyleData:
                                            const MenuItemStyleData(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16),
                                        ),
                                      ),
                                    ),
                                    // cities.isEmpty
                                    //     ? Container()
                                    //     :
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 15), // color: Colors.red,
                                      child:
                                          DropdownButtonFormField2<CityModel>(
                                        isExpanded: true,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 16),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          // Add more decoration..
                                        ),
                                        hint: const Text(
                                          'اختر مدينتك',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        value: cityModel ?? null,
                                        items: cities
                                            .map((item) =>
                                                DropdownMenuItem<CityModel>(
                                                  value: item,
                                                  child: Text(
                                                    item.nameAr ?? '',
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ))
                                            .toList(),
                                        validator: (value) {
                                          if (value == null) {
                                            return 'من فضلك اختر مدينتك';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          districts = [];
                                          cityModel = value;
                                          districtModel = null;

                                          setState(() {});

                                          (value!.cityId != null)
                                              ? _getDistrict(
                                                  cityId: value.cityId!)
                                              : districtModel = null;
                                          //Do something when selected item is changed.
                                        },
                                        onSaved: (value) {
                                          cityModel = value;
                                        },
                                        buttonStyleData: const ButtonStyleData(
                                          padding: EdgeInsets.only(right: 8),
                                        ),
                                        iconStyleData: const IconStyleData(
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.black45,
                                          ),
                                          iconSize: 24,
                                        ),
                                        dropdownStyleData: DropdownStyleData(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        menuItemStyleData:
                                            const MenuItemStyleData(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16),
                                        ),
                                      ),
                                    ),
                                    districts.isEmpty
                                        ? Container()
                                        : Container(
                                            margin: EdgeInsets.only(
                                                top: 15), // color: Colors.red,
                                            // height: 10,
                                            child: DropdownButtonFormField2<
                                                DistrictModel>(
                                              isExpanded: true,
                                              decoration: InputDecoration(
                                                // Add Horizontal padding using menuItemStyleData.padding so it matches
                                                // the menu padding when button's width is not specified.
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 16),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                // Add more decoration..
                                              ),
                                              hint: const Text(
                                                'اختر الحي',
                                                style: TextStyle(fontSize: 14),
                                              ),
                                              value: districtModel ?? null,
                                              items: districts
                                                  .map((item) =>
                                                      DropdownMenuItem<
                                                          DistrictModel>(
                                                        value: item,
                                                        child: Text(
                                                          item.nameAr ?? '',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ))
                                                  .toList(),
                                              validator: (value) {
                                                if (value == null) {
                                                  return 'من فضلك اختر الحي';
                                                }
                                                return null;
                                              },
                                              onChanged: (value) {
                                                //Do something when selected item is changed.
                                                districtModel = value;
                                              },
                                              onSaved: (value) {
                                                districtModel = value;
                                              },
                                              buttonStyleData:
                                                  const ButtonStyleData(
                                                padding:
                                                    EdgeInsets.only(right: 8),
                                              ),
                                              iconStyleData:
                                                  const IconStyleData(
                                                icon: Icon(
                                                  Icons.arrow_drop_down,
                                                  color: Colors.black45,
                                                ),
                                                iconSize: 24,
                                              ),
                                              dropdownStyleData:
                                                  DropdownStyleData(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                              ),
                                              menuItemStyleData:
                                                  const MenuItemStyleData(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16),
                                              ),
                                            ),
                                          ),

                                    Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Text(
                                          'عنوان الصالون بالتفاصيل',
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: TextFormField(
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        focusNode: _fAddress,
                                        controller: _cAddress,
                                        maxLines: 3,
                                        decoration: InputDecoration(
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .hnt_address,
                                          contentPadding: EdgeInsets.only(
                                              top: 10, left: 10),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .lbl_saloon_type,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 5),
                                      child: Row(
                                        children: [
                                          Row(
                                            children: [
                                              Radio(
                                                  value: 1,
                                                  groupValue: _saloonType,
                                                  onChanged: (val) {
                                                    setState(() {
                                                      _saloonType = val as int;
                                                    });
                                                  }),
                                              Text(AppLocalizations.of(context)!
                                                  .lbl_male)
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Radio(
                                                  value: 2,
                                                  groupValue: _saloonType,
                                                  onChanged: (val) {
                                                    setState(() {
                                                      _saloonType = val as int;
                                                    });
                                                  }),
                                              Text(AppLocalizations.of(context)!
                                                  .lbl_female)
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Radio(
                                                  value: 3,
                                                  groupValue: _saloonType,
                                                  onChanged: (val) {
                                                    setState(() {
                                                      _saloonType = val as int;
                                                    });
                                                  }),
                                              Text(AppLocalizations.of(context)!
                                                  .lbl_unisex)
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .lbl_description,
                                        /*style: Theme.of(context)
                                            .primaryTextTheme
                                            .titleSmall,*/
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: TextFormField(
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        controller: _cDescription,
                                        maxLines: 3,
                                        decoration: InputDecoration(
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .hnt_description,
                                          contentPadding: EdgeInsets.only(
                                              top: 10, left: 10),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .lbl_upload_image,
                                        /*style: Theme.of(context)
                                            .primaryTextTheme
                                            .titleSmall,*/
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Stack(
                                              alignment: AlignmentDirectional
                                                  .bottomEnd,
                                              children: [
                                                CircleAvatar(
                                                  radius: 50,
                                                  backgroundImage: _tImage !=
                                                          null
                                                      ? FileImage(_tImage!)
                                                          as ImageProvider
                                                      : AssetImage(
                                                          'assets/userImage.png'),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    FocusScope.of(context)
                                                        .unfocus();
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
                                    Container(
                                      height: 50,
                                      margin: EdgeInsets.only(top: 25),
                                      width: MediaQuery.of(context).size.width,
                                      child: TextButton(
                                        onPressed: () {
                                          FocusScope.of(context).unfocus();
                                          signUp();
                                        },
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .btn_create_account),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 25),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .txt_already_have_an_account,
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .titleSmall,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SignInScreen(
                                                            a: widget.analytics,
                                                            o: widget.observer,
                                                          )));
                                            },
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .btnSignIn,
                                              style: Theme.of(context)
                                                  .primaryTextTheme
                                                  .displayLarge,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ]))),
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _getRegions();

    super.initState();
  }

  signUp() async {
    try {
      user.vendor_email = email;
      user.vendor_password = password;
      user.vendor_address = _cAddress.text.trim();
      user.vendor_name = _cVenderName.text.trim();
      user.vendor_phone = _cPhoneNumber.text.trim();
      user.description = _cDescription.text.trim();
      user.owner_name = _cOwnerName.text.trim();
      user.chairCount = int.parse(_cChairCount.text.toString()).round();

      if (_saloonType != null) {
        user.type = _saloonType;
      }
      user.vendor_image = _tImage;

      user.device_id = global.appDeviceId;
      if (_cVenderName.text.isNotEmpty &&
          _cPhoneNumber.text.isNotEmpty &&
          _cOwnerName.text.isNotEmpty &&
          _cChairCount.text.isNotEmpty &&
          _cAddress.text.isNotEmpty &&
          _cDescription.text.isNotEmpty &&
          _tImage != null &&
          regionModel != null) {
        bool isConnected = await br.checkConnectivity();
        if (isConnected) {
          showOnlyLoaderDialog();
          await apiHelper
              ?.signUp(
                  user.chairCount ?? 1,
                  user.type!,
                  user.vendor_name!,
                  user.owner_name!,
                  user.vendor_email!,
                  user.vendor_password!,
                  user.device_id!,
                  user.vendor_phone!,
                  user.vendor_address!,
                  regionModel?.nameAr ?? '',
                  cityModel?.nameAr ?? '',
                  districtModel?.nameAr ?? '',
                  user.description!,
                  _tImage!)
              .then((result) {
            if (result.status == "1") {
              user = result.recordList;
              global.user = result.recordList;
              br.saveUser(user);
              hideLoader();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => BottomNavigationWidget(
                      a: widget.analytics, o: widget.observer),
                ),
              );
            } else {
              hideLoader();
              showSnackBar(snackBarMessage: '${result.message}');
            }
          });
        } else {
          showNetworkErrorSnackBar(_scaffoldKey);
        }
      } else if (_cVenderName.text.isEmpty) {
        showSnackBar(
            snackBarMessage:
                AppLocalizations.of(context)!.txt_please_enter_parlour_name);
      } else if (_cPhoneNumber.text.isEmpty) {
        showSnackBar(
            snackBarMessage:
                AppLocalizations.of(context)!.txt_please_enter_phone_number);
      }
      // else if (_cPhoneNumber.text.length != 10) {
      //   showSnackBar(
      //       snackBarMessage: AppLocalizations.of(context)!
      //           .txt_please_enter_valid_phone_number);
      // }
      else if (_cOwnerName.text.isEmpty) {
        showSnackBar(
            snackBarMessage:
                AppLocalizations.of(context)!.txt_please_enter_owner_name);
      } else if (_cAddress.text.isEmpty) {
        showSnackBar(
            snackBarMessage:
                AppLocalizations.of(context)!.txt_please_enter_address);
      } else if (_cChairCount.text.isEmpty) {
        showSnackBar(snackBarMessage: 'ادخل عدد الكراسي');
      } else if (_cDescription.text.isEmpty) {
        showSnackBar(
            snackBarMessage:
                AppLocalizations.of(context)!.txt_please_enter_description);
      } else if (_tImage == null) {
        showSnackBar(
            snackBarMessage:
                AppLocalizations.of(context)!.txt_please_select_image);
      }
    } catch (e) {
      print("Exception - generalInformationScreen.dart - _signUp():" +
          e.toString());
    }
  }

  _showCupertinoModalSheet() {
    try {
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          title: Text(
            AppLocalizations.of(context)!.lbl_action,
          ),
          actions: [
            CupertinoActionSheetAction(
              child: Text(AppLocalizations.of(context)!.lbl_take_picture,
                  style: TextStyle(color: Color(0xFF171D2C))),
              onPressed: () async {
                Navigator.pop(context);
                showOnlyLoaderDialog();
                _tImage = await br.openCamera();
                hideLoader();

                setState(() {});
              },
            ),
            CupertinoActionSheetAction(
              child: Text(AppLocalizations.of(context)!.lbl_choose_from_library,
                  style: TextStyle(color: Color(0xFF171D2C))),
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
            child: Text(AppLocalizations.of(context)!.lbl_cancel,
                style: TextStyle(color: Color(0xFFFA692C))),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      );
    } catch (e) {
      print(
          "Exception - generalInformationScreen.dart - _showCupertinoModalSheet():" +
              e.toString());
    }
  }

  RegionModel? regionModel;
  CityModel? cityModel;
  DistrictModel? districtModel;
  List<RegionModel> regions = [];
  List<CityModel> cities = [];
  List<DistrictModel> districts = [];
  bool _isRegionsLoaded = false;
  bool _isCitiesLoaded = false;
  bool _isDistrictsLoaded = false;

  _getRegions() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper!.getRegions().then((result) {
          if (result != null) {
            regions = result.map((e) => RegionModel.fromJson(e)).toList();
          }
          _isRegionsLoaded = true;
          setState(() {});
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - homeScreen.dart - _getProducts():" + e.toString());
    }
  }

  _getCities({required int id}) async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper!.getCities(id: id).then((result) {
          if (result != null) {
            cities = result.map((e) => CityModel.fromJson(e)).toList();
          }
          _isCitiesLoaded = true;
          setState(() {});
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - homeScreen.dart - _getProducts():" + e.toString());
    }
  }

  _getDistrict({required int cityId}) async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper!.getDistrict(cityId: cityId).then((result) {
          if (result != null) {
            districts = result.map((e) => DistrictModel.fromJson(e)).toList();
          }
          _isDistrictsLoaded = true;
          setState(() {});
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - getDistrict():" + e.toString());
    }
  }
}
