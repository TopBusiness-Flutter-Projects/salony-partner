import 'dart:io';
import 'dart:ui';

import 'package:app/dialogs/saveProductDialog.dart';
import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/productModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddProductScreen extends BaseRoute {
  final Product? product;
  AddProductScreen({a, o, this.product}) : super(a: a, o: o, r: 'AddProductScreen');
  @override
  _AddProductScreenState createState() => new _AddProductScreenState(this.product);
}

class _AddProductScreenState extends BaseRouteState {
  Product? product = new Product();
  Product? _product = new Product();
  TextEditingController _cProductName = new TextEditingController();
  TextEditingController _cPrice = new TextEditingController();
  TextEditingController _cQuantity = new TextEditingController();
  TextEditingController _cDescription = new TextEditingController();

  late GlobalKey<ScaffoldState> _scaffoldKey;
  File? _tImage;

  var _fPrice = FocusNode();
  var _fDescription = FocusNode();
  var _fQuantity = FocusNode();
  var dropdownval;

  _AddProductScreenState(this.product) : super();

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
                margin: EdgeInsets.only(top: 15, bottom: 8, left: 10, right: 10),
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: TextButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    _addProducts();
                  },
                  child: Text(
                    AppLocalizations.of(context)!.btn_save_product,
                  ),
                ),
                decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.all(Radius.circular(10))),
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
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(top: 30, bottom: 10),
                                  child: Text(
                                    product != null ? AppLocalizations.of(context)!.lbl_edit_product : AppLocalizations.of(context)!.lbl_add_product,
                                    style: Theme.of(context).primaryTextTheme.headline3,
                                  )),
                              Expanded(
                                child: SingleChildScrollView(
                                  physics: AlwaysScrollableScrollPhysics(),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: 15,
                                      bottom: MediaQuery.of(context).viewInsets.bottom,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!.lbl_product_name,
                                          style: Theme.of(context).primaryTextTheme.subtitle2,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 3, bottom: 3),
                                          child: TextFormField(
                                            textCapitalization: TextCapitalization.words,
                                            controller: _cProductName,
                                            onFieldSubmitted: (val) {
                                              FocusScope.of(context).requestFocus(_fPrice);
                                            },
                                            decoration: InputDecoration(
                                              hintText: AppLocalizations.of(context)!.hnt_product_name,
                                              contentPadding: EdgeInsets.only(top: 5, left: 10, right: 10),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!.lbl_price,
                                          style: Theme.of(context).primaryTextTheme.subtitle2,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 3, bottom: 3),
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            controller: _cPrice,
                                            focusNode: _fPrice,
                                            onFieldSubmitted: (val) {
                                              FocusScope.of(context).requestFocus(_fDescription);
                                            },
                                            decoration: InputDecoration(
                                              hintText: '${global.currency.currency_sign}' + AppLocalizations.of(context)!.hnt_price,
                                              contentPadding: EdgeInsets.only(top: 5, left: 10, right: 10),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!.lbl_description,
                                          style: Theme.of(context).primaryTextTheme.subtitle2,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 3, bottom: 3),
                                          child: TextFormField(
                                            focusNode: _fDescription,
                                            textCapitalization: TextCapitalization.sentences,
                                            controller: _cDescription,
                                            maxLines: 5,
                                            onFieldSubmitted: (val) {
                                              FocusScope.of(context).requestFocus(_fQuantity);
                                            },
                                            decoration: InputDecoration(
                                              hintText: AppLocalizations.of(context)!.hnt_description,
                                              contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!.lbl_quantity,
                                          style: Theme.of(context).primaryTextTheme.subtitle2,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 3, bottom: 3),
                                          child: TextFormField(
                                            focusNode: _fQuantity,
                                            controller: _cQuantity,
                                            onFieldSubmitted: (val) {
                                              FocusScope.of(context).unfocus();
                                            },
                                            decoration: InputDecoration(
                                              hintText: AppLocalizations.of(context)!.hnt_quantity,
                                              contentPadding: EdgeInsets.only(top: 5, left: 10, right: 10),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!.lbl_upload_image,
                                          style: Theme.of(context).primaryTextTheme.subtitle2,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(width: 1, color: Theme.of(context).inputDecorationTheme.enabledBorder!.borderSide.color),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          margin: EdgeInsets.only(top: 5),
                                          height: 300,
                                          width: MediaQuery.of(context).size.width,
                                          child: _tImage == null
                                              ? product == null
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        _showCupertinoModalSheet();
                                                        setState(() {});
                                                      },
                                                      child: Center(
                                                          child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Icon(
                                                            Icons.image,
                                                            size: 55,
                                                            color: Theme.of(context).primaryTextTheme.headline1!.color,
                                                          ),
                                                          Text(AppLocalizations.of(context)!.lbl_tap_to_add_image)
                                                        ],
                                                      )),
                                                    )
                                                  : GestureDetector(
                                                      onTap: () {
                                                        _showCupertinoModalSheet();
                                                      },
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                                        child: CachedNetworkImage(
                                                          imageUrl: global.baseUrlForImage + product!.product_image!,
                                                          imageBuilder: (context, imageProvider) => Container(
                                                            height: 90,
                                                            decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.contain, image: imageProvider)),
                                                          ),
                                                          placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                                          errorWidget: (context, url, error) => Icon(Icons.error),
                                                        ),
                                                      ),
                                                    )
                                              : GestureDetector(
                                                  onTap: () {
                                                    _showCupertinoModalSheet();
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), image: DecorationImage(image: FileImage(_tImage!), fit: BoxFit.contain)),
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

  init() async {
    if (product != null) {
      if (product?.id != null) {
        _cProductName.text = product!.product_name!;
        _cPrice.text = product!.price!;
        _cQuantity.text = product!.quantity!;
        _cDescription.text = product!.description!;

        _product?.id = product!.id!;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  _addProducts() async {
    try {
      _product?.vendor_id = global.user.id;
      _product?.product_name = _cProductName.text.trim();
      _product?.price = _cPrice.text.trim();
      _product?.quantity = _cQuantity.text.trim();
      _product?.description = _cDescription.text.trim();
      if (_cProductName.text.isNotEmpty && _cPrice.text.isNotEmpty && _cDescription.text.isNotEmpty && _cQuantity.text.isNotEmpty) {
        bool isConnected = await br.checkConnectivity();
        if (isConnected) {
          showOnlyLoaderDialog();

          if (_product?.id == null) {
            if (_tImage != null) {
              await apiHelper?.addProduct(_product!.vendor_id!, _product!.product_name!, _product!.price!, _product!.quantity!, _product!.description!, _tImage!).then((result) {
                if (result.status == "1") {
                  hideLoader();
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => SaveProductDialog(
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
              showSnackBar(snackBarMessage: AppLocalizations.of(context)!.txt_please_select_image);
            }
          } else //update
          {
            await apiHelper?.editProduct(_product!.id!, _product!.product_name!, _product!.price!, _product!.quantity!, _product!.description!, _product!.vendor_id!, _tImage!).then((result) {
              if (result.status == "1") {
                hideLoader();
                showDialog(
                    context: context,
                    builder: (BuildContext context) => SaveProductDialog(
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
      } else if (_cProductName.text.isEmpty) {
        showSnackBar(snackBarMessage: AppLocalizations.of(context)!.txt_please_enter_name);
      } else if (_cPrice.text.isEmpty) {
        showSnackBar(snackBarMessage: AppLocalizations.of(context)!.txt_please_enter_price);
      } else if (_cDescription.text.isEmpty) {
        showSnackBar(snackBarMessage: AppLocalizations.of(context)!.txt_please_enter_description);
      } else if (_cQuantity.text.isEmpty) {
        showSnackBar(snackBarMessage: AppLocalizations.of(context)!.txt_please_enter_quantity);
      }
    } catch (e) {
      print("Exception - addProductScreen.dart - _addProducts():" + e.toString());
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
      print("Exception - addProductScreen.dart - _showCupertinoModalSheet():" + e.toString());
    }
  }
}
