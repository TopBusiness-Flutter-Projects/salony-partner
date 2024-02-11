import 'dart:io';

import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/galleryModel.dart';
import 'package:app/models/serviceModel.dart';
import 'package:app/screens/galleryListScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddGalleryScreen extends BaseRoute {
  final Service? service;

  AddGalleryScreen({a, o, this.service})
      : super(a: a, o: o, r: 'AddGalleryScreen');
  @override
  _AddGalleryScreenState createState() =>
      new _AddGalleryScreenState(this.service);
}

class _AddGalleryScreenState extends BaseRouteState {
  Service? service = new Service();
  File? _tImage;
  Gallery _gallery = new Gallery();
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: 'AddGalleryScreen');
  var dropdownval;

  _AddGalleryScreenState(this.service) : super();

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
            margin: EdgeInsets.only(top: 15, left: 10, right: 10),
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: TextButton(
              onPressed: () {
                _addGallery();
              },
              child: Text(AppLocalizations.of(context)!.btn_save_gallery),
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
                                AppLocalizations.of(context)!.lbl_Add_gallery,
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
  }

  _addGallery() async {
    try {
      _gallery.vendor_id = global.user.id;

      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        showOnlyLoaderDialog();

        if (_tImage != null) {
          await apiHelper
              ?.addGallery(_gallery.vendor_id!, _tImage)
              .then((result) {
            if (result.status == "1") {
              hideLoader();

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => GalleryListScreen(
                        a: widget.analytics,
                        o: widget.observer,
                        screenId: 1,
                      )));
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
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print(
          "Exception - addgalleryScreen.dart - _addGallery():" + e.toString());
    }
  }

  _init() async {}

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
      print("Exception - addGalleryScreen.dart - _showCupertinoModalSheet():" +
          e.toString());
    }
  }
}
