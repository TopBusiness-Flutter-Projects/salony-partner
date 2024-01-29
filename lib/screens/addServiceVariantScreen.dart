import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/serviceVariantModel.dart';
import 'package:app/screens/serviceListScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddServiceVariantScreen extends BaseRoute {
  final ServiceVariant? serviceVariant;
  final int serviceId;

  AddServiceVariantScreen(this.serviceId, {a, o, this.serviceVariant}) : super(a: a, o: o, r: 'AddServiceVariantScreen');
  @override
  _AddServiceVariantVariantScreenState createState() => new _AddServiceVariantVariantScreenState(this.serviceVariant, this.serviceId);
}

class _AddServiceVariantVariantScreenState extends BaseRouteState {
  ServiceVariant? serviceVariant = new ServiceVariant();
  int serviceId;
  TextEditingController _cServiceName = new TextEditingController();
  TextEditingController _cServicePrice = new TextEditingController();
  TextEditingController _cServiceTime = new TextEditingController();

  late GlobalKey<ScaffoldState> _scaffoldKey;
  ServiceVariant _serviceVariant = new ServiceVariant();
  var dropdownval;

  _AddServiceVariantVariantScreenState(this.serviceVariant, this.serviceId) : super();

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
                    FocusScope.of(context).unfocus();
                    _addServiceVariant();
                  },
                  child: Text(
                    AppLocalizations.of(context)!.btn_save_service_variant,
                  ),
                ),
                decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
            resizeToAvoidBottomInset: false,
            body: GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: SafeArea(
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
                                      AppLocalizations.of(context)!.lbl_add_service_variant,
                                      style: Theme.of(context).primaryTextTheme.displaySmall,
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
                                          Container(
                                            margin: EdgeInsets.only(top: 10),
                                            child: Text(
                                              AppLocalizations.of(context)!.lbl_variant,
                                              style: Theme.of(context).primaryTextTheme.titleSmall,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 5),
                                            child: TextFormField(
                                              textCapitalization: TextCapitalization.words,
                                              controller: _cServiceName,
                                              decoration: InputDecoration(hintText: AppLocalizations.of(context)!.hnt_service_name, contentPadding: EdgeInsets.only(top: 5, left: 10, right: 10)),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 10),
                                            child: Text(
                                              AppLocalizations.of(context)!.lbl_price,
                                              style: Theme.of(context).primaryTextTheme.titleSmall,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 5),
                                            child: TextFormField(
                                              controller: _cServicePrice,
                                              keyboardType: TextInputType.number,
                                              decoration: InputDecoration(
                                                hintText: '${global.currency.currency_sign}' + AppLocalizations.of(context)!.hnt_price,
                                                contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 10),
                                            child: Text(
                                              AppLocalizations.of(context)!.lbl_time,
                                              style: Theme.of(context).primaryTextTheme.titleSmall,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 5),
                                            child: TextFormField(
                                              controller: _cServiceTime,
                                              keyboardType: TextInputType.number,
                                              decoration: InputDecoration(
                                                hintText: AppLocalizations.of(context)!.hnt_time,
                                                contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
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

  Future selectTime() async {
    try {
      final TimeOfDay? _picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.input,
      );
      return _picked;
    } catch (e) {
      print("Exception - addServiceVariantScreen.dart - selectTime(): " + e.toString());
      return null;
    }
  }

  _addServiceVariant() async {
    try {
      _serviceVariant.vendor_id = global.user.id;
      if (_cServicePrice.text != "") {
        _serviceVariant.price = int.parse(_cServicePrice.text);
      }
      if (_cServiceTime.text != "") {
        _serviceVariant.time = int.parse(_cServiceTime.text);
      }
      _serviceVariant.varient = _cServiceName.text.trim();
      _serviceVariant.service_id = serviceId;
      if (_cServiceName.text.isNotEmpty && _cServicePrice.text.isNotEmpty && _cServiceTime.text.isNotEmpty) {
        bool isConnected = await br.checkConnectivity();
        if (isConnected) {
          showOnlyLoaderDialog();

          if (_serviceVariant.varient_id == null) {
            await apiHelper?.addServiceVariant(_serviceVariant).then((result) {
              if (result != null) {
                if (result.status == "1") {
                  hideLoader();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ServiceListScreen(
                            a: widget.analytics,
                            o: widget.observer,
                            screenId: 1,
                          )));
                } else {
                  hideLoader();
                  showSnackBar(snackBarMessage: '${result.message}');
                }
              }
            });
          } else //update
          {
            await apiHelper?.editServiceVariant(_serviceVariant).then((result) {
              if (result != null) {
                if (result.status == "1") {
                  hideLoader();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ServiceListScreen(
                            a: widget.analytics,
                            o: widget.observer,
                            screenId: 1,
                          )));
                } else {
                  hideLoader();
                  showSnackBar(snackBarMessage: '${result.message}');
                }
              }
            });
          }
        } else {
          showNetworkErrorSnackBar(_scaffoldKey);
        }
      } else if (_cServiceName.text.isEmpty) {
        showSnackBar(snackBarMessage: AppLocalizations.of(context)!.txt_please_enter_name);
      } else if (_cServicePrice.text.isEmpty) {
        showSnackBar(snackBarMessage: AppLocalizations.of(context)!.txt_please_enter_price);
      } else if (_cServiceTime.text.isEmpty) {
        showSnackBar(snackBarMessage: AppLocalizations.of(context)!.txt_please_enter_time);
      }
    } catch (e) {
      print("Exception - addServiceVariantScreen.dart - _addServiceVariant():" + e.toString());
    }
  }

  _init() async {
    try {
      if (serviceVariant != null) {
        if (serviceVariant?.varient_id != null) {
          _cServiceName.text = serviceVariant!.varient!;
          _cServicePrice.text = serviceVariant!.price!.toString();
          _cServiceTime.text = serviceVariant!.time!.toString();
          _serviceVariant.varient_id = serviceVariant!.varient_id;
        }
      }
    } catch (e) {
      print("Exception - addSeviceVariantScreen.dart - init():" + e.toString());
    }
  }
}
