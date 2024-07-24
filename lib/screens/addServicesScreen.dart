import 'dart:io';

import 'package:app/dialogs/saveServiceDialog.dart';
import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/mainscervices.dart';
import 'package:app/models/serviceModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddServiceScreen extends BaseRoute {
  final Service? service;

  AddServiceScreen({a, o, this.service})
      : super(a: a, o: o, r: 'AddServiceScreen');
  @override
  _AddServiceScreenState createState() =>
      new _AddServiceScreenState(this.service);
}

class _AddServiceScreenState extends BaseRouteState {
  Service? service = new Service();
  File? _tImage;
  TextEditingController _cServiceName = new TextEditingController();
  Service _service = new Service();
  late GlobalKey<ScaffoldState> _scaffoldKey;
  var dropdownval;

  _AddServiceScreenState(this.service) : super();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: SafeArea(
          child: Container(
            margin: EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 8),
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: TextButton(
              onPressed: () {
                if (selectedValue == null) {
                  Fluttertoast.showToast(msg: 'من فضلك اختر التصنيف');
                } else {
                  FocusScope.of(context).unfocus();
                  _addService();
                }
              },
              child: Text(
                AppLocalizations.of(context)!.btn_save_service,
              ),
            ),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
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
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                              margin: EdgeInsets.only(top: 30, bottom: 10),
                              child: Text(
                                service != null
                                    ? AppLocalizations.of(context)!
                                        .lbl_edit_service
                                    : AppLocalizations.of(context)!
                                        .lbl_Add_service,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .displaySmall,
                              )),
                          Expanded(
                            child: SingleChildScrollView(
                              physics: AlwaysScrollableScrollPhysics(),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: 15,
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .lbl_service_name,
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .titleSmall,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: TextFormField(
                                        textCapitalization:
                                            TextCapitalization.words,
                                        controller: _cServiceName,
                                        decoration: InputDecoration(
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .hnt_service_name,
                                          contentPadding: EdgeInsets.only(
                                              top: 5, left: 10, right: 10),
                                        ),
                                      ),
                                    ),

                                    //!
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Text(
                                        'نوع الخدمة',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .titleSmall,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Center(
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton2<MainServices>(
                                            isExpanded: true,
                                            hint: Text(
                                              'اختر نوع الخدمه',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color:
                                                    Theme.of(context).hintColor,
                                              ),
                                            ),
                                            items: items
                                                .map((MainServices item) =>
                                                    DropdownMenuItem<
                                                        MainServices>(
                                                      value: item,
                                                      child: Text(
                                                        item.name ?? '',
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ))
                                                .toList(),
                                            value: selectedValue,
                                            onChanged: (MainServices? value) {
                                              setState(() {
                                                selectedValue = value;
                                              });
                                            },
                                            buttonStyleData: ButtonStyleData(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  // color: Colors.red,
                                                  border: Border.all(
                                                      color: Colors.grey,
                                                      width: 0.5)),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16),
                                              // height: 40,
                                              // width: 140,
                                            ),
                                            menuItemStyleData:
                                                const MenuItemStyleData(
                                                    // height: 40,
                                                    ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    //!
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .lbl_upload_image,
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .titleSmall,
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2,
                                            color: Theme.of(context)
                                                .inputDecorationTheme
                                                .enabledBorder!
                                                .borderSide
                                                .color),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      margin: EdgeInsets.only(top: 5),
                                      height: 300,
                                      width: MediaQuery.of(context).size.width,
                                      child: _tImage == null
                                          ? service == null
                                              ? GestureDetector(
                                                  onTap: () {
                                                    _showCupertinoModalSheet();
                                                    setState(() {});
                                                  },
                                                  child: Center(
                                                      child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.image,
                                                        size: 55,
                                                        color: Theme.of(context)
                                                            .primaryTextTheme
                                                            .displayLarge!
                                                            .color,
                                                      ),
                                                      Text(AppLocalizations.of(
                                                              context)!
                                                          .lbl_tap_to_add_image)
                                                    ],
                                                  )),
                                                )
                                              : GestureDetector(
                                                  onTap: () {
                                                    _showCupertinoModalSheet();
                                                  },
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    child: CachedNetworkImage(
                                                      imageUrl: global
                                                              .baseUrlForImage +
                                                          service!
                                                              .service_image!,
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          Container(
                                                        height: 90,
                                                        decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                                fit: BoxFit
                                                                    .contain,
                                                                image:
                                                                    imageProvider)),
                                                      ),
                                                      placeholder: (context,
                                                              url) =>
                                                          Center(
                                                              child:
                                                                  CircularProgressIndicator()),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(Icons.error),
                                                    ),
                                                  ),
                                                )
                                          : GestureDetector(
                                              onTap: () {
                                                _showCupertinoModalSheet();
                                              },
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: FileImage(
                                                              _tImage!),
                                                          fit: BoxFit.contain)),
                                                ),
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
        ),
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
    _init();
    _getMainServices();
  }

  _addService() async {
    try {
      _service.vendor_id = global.user.id;
      _service.service_name = _cServiceName.text.trim();

      if (_cServiceName.text.isNotEmpty) {
        bool isConnected = await br.checkConnectivity();
        if (isConnected) {
          showOnlyLoaderDialog();
          if (_service.service_id == null) {
            if (_tImage != null) {
              await apiHelper
                  ?.addService(_service.vendor_id!, _service.service_name!,
                      selectedValue!.id!, _tImage)
                  .then((result) {
                if (result.status == "1") {
                  hideLoader();
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => SaveServiceDialog(
                            a: widget.analytics,
                            o: widget.observer,
                          ));
                } else {
                  hideLoader();
                  showSnackBar(snackBarMessage: '${result.message}');
                }
              });
            } else {
              hideLoader();
              showSnackBar(
                  snackBarMessage:
                      AppLocalizations.of(context)!.txt_please_select_image);
            }
          } else //update
          {
            await apiHelper
                ?.editService(_service.vendor_id!, _service.service_name!,
                    _tImage, _service.service_id!)
                .then((result) {
              if (result.status == "1") {
                hideLoader();
                showDialog(
                    context: context,
                    builder: (BuildContext context) => SaveServiceDialog(
                          a: widget.analytics,
                          o: widget.observer,
                        ));
              } else {
                hideLoader();
                showSnackBar(snackBarMessage: '${result.message}');
              }
            });
          }
        } else {
          showNetworkErrorSnackBar(_scaffoldKey);
        }
      } else if (_cServiceName.text.isEmpty) {
        showSnackBar(
            snackBarMessage:
                AppLocalizations.of(context)!.txt_please_enter_name);
      }
    } catch (e) {
      print(
          "Exception - addServicesScreen.dart - _addService():" + e.toString());
    }
  }

  List<MainServices> items = [];
  MainServices? selectedValue;
  _getMainServices() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        showOnlyLoaderDialog();
        await apiHelper?.getMainServices().then((result) {
          if (result.status == "1") {
            items = result.recordList;
            setState(() {});
            hideLoader();
          } else {
            hideLoader();
            showSnackBar(snackBarMessage: '${result.message}');
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      hideLoader();
      print("Exception - _getMainServices.dart - _getMainServices():" +
          e.toString());
    }
  }

  _init() async {
    try {
      if (service != null) {
        if (service?.service_id != null) {
          _cServiceName.text = service!.service_name!;
          _service.service_id = service!.service_id!;
        }
      }
    } catch (e) {
      print("Exception - addServiceScreen.dart - init():" + e.toString());
    }
  }

  _showCupertinoModalSheet() {
    try {
      FocusScope.of(context).unfocus();
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          title: Text(AppLocalizations.of(context)!.lbl_action),
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
      print("Exception - addServicesScreen.dart - _showCupertinoModalSheet():" +
          e.toString());
    }
  }
}
