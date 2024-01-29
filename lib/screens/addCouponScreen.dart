import 'package:app/dialogs/saveCouponDialog.dart';
import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/couponModel.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddCouponScreen extends BaseRoute {
  AddCouponScreen({a, o}) : super(a: a, o: o, r: 'AddCouponScreen');
  @override
  _AddCouponScreenState createState() => new _AddCouponScreenState();
}

class _AddCouponScreenState extends BaseRouteState {
  Coupon _coupon = new Coupon();
  TextEditingController _cStartDate = new TextEditingController();
  TextEditingController _cEndDate = new TextEditingController();
  TextEditingController _cUsesRestriction = new TextEditingController();
  TextEditingController _cCouponName = new TextEditingController();
  TextEditingController _cCouponCode = new TextEditingController();
  TextEditingController _cCouponDescription = new TextEditingController();
  TextEditingController _cAmount = new TextEditingController(); //offer price
  TextEditingController _cCartValue = new TextEditingController(); //Min service amount

  var _fStartDate = new FocusNode();
  late GlobalKey<ScaffoldState> _scaffoldKey;
  var _fEndDate = new FocusNode();
  var _fCouponCode = new FocusNode();
  var _fCouponDescription = new FocusNode();
  var _fAmount = new FocusNode();
  var _fCartValue = new FocusNode();
  var _fUsesRestriction = new FocusNode();
  var _fCouponType = new FocusNode();

  late DateTime _startdDate;
  late DateTime _endDate;
  var couponType;
  
  _AddCouponScreenState() : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          bottomNavigationBar: SafeArea(
            child: Container(
              margin: EdgeInsets.only(top: 15, left: 10, right: 10),
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: TextButton(
                onPressed: () {
                  _addCoupon();
                },
                child: Text(
                  AppLocalizations.of(context)!.btn_save_coupon,
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
                                margin: EdgeInsets.only(
                                  top: 30,
                                  bottom: 10,
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!.lbl_Add_coupon,
                                  style: Theme.of(context).primaryTextTheme.displaySmall,
                                )),
                            Expanded(
                              child: SingleChildScrollView(
                                physics: AlwaysScrollableScrollPhysics(),
                                child: Padding(
                                  padding: EdgeInsets.only(top: 15.0, bottom: MediaQuery.of(context).viewInsets.bottom),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.lbl_coupon_name,
                                        style: Theme.of(context).primaryTextTheme.titleSmall,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: TextFormField(
                                          textCapitalization: TextCapitalization.words,
                                          onEditingComplete: () {
                                            FocusScope.of(context).requestFocus(_fCouponCode);
                                          },
                                          controller: _cCouponName,
                                          decoration: InputDecoration(
                                            hintText: AppLocalizations.of(context)!.hnt_coupon_name,
                                            contentPadding: EdgeInsets.only(top: 5, left: 10, right: 10),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!.lbl_coupon_number,
                                        style: Theme.of(context).primaryTextTheme.titleSmall,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: TextFormField(
                                          focusNode: _fCouponCode,
                                          onEditingComplete: () {
                                            FocusScope.of(context).requestFocus(_fCouponDescription);
                                          },
                                          controller: _cCouponCode,
                                          decoration: InputDecoration(
                                            hintText: AppLocalizations.of(context)!.hnt_coupon_number,
                                            contentPadding: EdgeInsets.only(top: 5, left: 10, right: 10),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!.lbl_coupon_description,
                                        style: Theme.of(context).primaryTextTheme.titleSmall,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: TextFormField(
                                          textCapitalization: TextCapitalization.words,
                                          focusNode: _fCouponDescription,
                                          onEditingComplete: () {
                                            FocusScope.of(context).requestFocus(_fAmount);
                                          },
                                          controller: _cCouponDescription,
                                          maxLines: 3,
                                          decoration: InputDecoration(
                                            hintText: AppLocalizations.of(context)!.hnt_description,
                                            contentPadding: EdgeInsets.only(top: 5, left: 10, right: 10),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Text(
                                          AppLocalizations.of(context)!.lbl_select_coupon_type,
                                          style: Theme.of(context).primaryTextTheme.titleSmall,
                                        ),
                                      ),
                                      DropdownButtonFormField(
                                        items: <String>[
                                          AppLocalizations.of(context)!.lbl_percentage,
                                          AppLocalizations.of(context)!.lbl_price,
                                        ].map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value, style: Theme.of(context).primaryTextTheme.titleSmall),
                                          );
                                        }).toList(),
                                        hint: Text(
                                          AppLocalizations.of(context)!.hnt_coupon_type,
                                          style: Theme.of(context).inputDecorationTheme.hintStyle,
                                        ),
                                        onChanged: (val) {
                                          setState(() {
                                            couponType = val;
                                          });
                                        },
                                        value: couponType,
                                        isExpanded: true,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Text(
                                          AppLocalizations.of(context)!.lbl_offer_price,
                                          style: Theme.of(context).primaryTextTheme.titleSmall,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: TextFormField(
                                          focusNode: _fAmount,
                                          onEditingComplete: () {
                                            FocusScope.of(context).requestFocus(_fCartValue);
                                          },
                                          controller: _cAmount,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            hintText: AppLocalizations.of(context)!.hnt_offer_price,
                                            contentPadding: EdgeInsets.only(top: 5, left: 10, right: 10),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Text(
                                          AppLocalizations.of(context)!.lbl_min_service_amount,
                                          style: Theme.of(context).primaryTextTheme.titleSmall,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: TextFormField(
                                          focusNode: _fCartValue,
                                          onEditingComplete: () {
                                            FocusScope.of(context).requestFocus(_fUsesRestriction);
                                          },
                                          controller: _cCartValue,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            hintText: '${global.currency.currency_sign}' + AppLocalizations.of(context)!.hnt_min_service_amount,
                                            contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Text(
                                          AppLocalizations.of(context)!.lbl_select_usesRestriction,
                                          style: Theme.of(context).primaryTextTheme.titleSmall,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: TextFormField(
                                          focusNode: _fUsesRestriction,
                                          onEditingComplete: () {
                                            FocusScope.of(context).requestFocus(_fCouponType);
                                          },
                                          keyboardType: TextInputType.number,
                                          controller: _cUsesRestriction,
                                          decoration: InputDecoration(
                                            hintText: AppLocalizations.of(context)!.hnt_usesRestriction,
                                            contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Text(
                                          AppLocalizations.of(context)!.lbl_select_start_date,
                                          style: Theme.of(context).primaryTextTheme.titleSmall,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: TextFormField(
                                          focusNode: _fStartDate,
                                          controller: _cStartDate,
                                          onTap: () {
                                            _selectStartDate();
                                          },
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            hintText: AppLocalizations.of(context)!.hnt_select_start_date,
                                            contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Text(
                                          AppLocalizations.of(context)!.lbl_select__end_date,
                                          style: Theme.of(context).primaryTextTheme.titleSmall,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: TextFormField(
                                          focusNode: _fEndDate,
                                          controller: _cEndDate,
                                          onTap: () {
                                            _seletEndDate();
                                          },
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            hintText: AppLocalizations.of(context)!.hnt_select_end_date,
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
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    setState(() {});
  }

  _addCoupon() async {
    try {
      _coupon.vendor_id = global.user.id;
      _coupon.coupon_name = _cCouponName.text.trim();
      _coupon.coupon_code = _cCouponCode.text.trim();
      _coupon.amount = _cAmount.text.trim();
      _coupon.coupon_description = _cCouponDescription.text.trim();
      if (_cCartValue.text != "") {
        _coupon.cart_value = int.parse(_cCartValue.text.trim());
      }
      _coupon.start_date = _startdDate;
      _coupon.end_date = _endDate;
      if (_cUsesRestriction.text != "") {
        _coupon.uses_restriction = int.parse(_cUsesRestriction.text.trim());
      }

      _coupon.type = couponType;

      if (_coupon.coupon_name!.isNotEmpty && _coupon.amount!.isNotEmpty && _coupon.cart_value != null && _coupon.coupon_code!.isNotEmpty && _coupon.coupon_description!.isNotEmpty && _coupon.uses_restriction != null && _coupon.type != null && _coupon.start_date != null && _coupon.end_date != null) {
        bool isConnected = await br.checkConnectivity();
        if (isConnected) {
          showOnlyLoaderDialog();

          if (_coupon.coupon_id == null) {
            await apiHelper?.addCoupon(_coupon).then((result) {
              if (result != null) {
                if (result.status == "1") {
                  hideLoader();
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => SaveCouponDialog(
                            a: widget.analytics,
                            o: widget.observer,
                          ));
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
      } else if (_coupon.coupon_name!.isEmpty) {
        showSnackBar(snackBarMessage: AppLocalizations.of(context)!.txt_please_enter_name);
      } else if (_coupon.amount!.isEmpty) {
        showSnackBar(snackBarMessage: AppLocalizations.of(context)!.txt_please_enter_offer_price);
      } else if (_coupon.cart_value == null) {
        showSnackBar(snackBarMessage: AppLocalizations.of(context)!.txt_pleae_enter_min_service_price);
      } else if (_coupon.coupon_code!.isEmpty) {
        showSnackBar(snackBarMessage: AppLocalizations.of(context)!.txt_please_enter_coupon_number);
      } else if (_coupon.coupon_description!.isEmpty) {
        showSnackBar(snackBarMessage: AppLocalizations.of(context)!.txt_please_enter_description);
      } else if (_coupon.uses_restriction == null) {
        showSnackBar(snackBarMessage: AppLocalizations.of(context)!.txt_please_enter_usesRestriction);
      } else if (_coupon.type == null) {
        showSnackBar(snackBarMessage: AppLocalizations.of(context)!.txt_please_select_coupon_type);
      } else if (_coupon.start_date == null) {
        showSnackBar(snackBarMessage: AppLocalizations.of(context)!.txt_please_select_start_date);
      } else if (_coupon.end_date == null) {
        showSnackBar(snackBarMessage: AppLocalizations.of(context)!.txt_please_select_end_date);
      }
    } catch (e) {
      print("Exception - addCouponScreen.dart - addCoupon():" + e.toString());
    }
  }

  Future _selectStartDate() async {
    try {
      final DateTime? picked = await showDatePicker(
        lastDate: DateTime(2022),
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1940),
      );
      if (picked != null && picked != DateTime(2000)) {
        setState(() {
          _startdDate = picked;
          _cStartDate.text = formatDate(_startdDate, [yyyy, '-', mm, '-', dd]);
        });
      }
      FocusScope.of(context).requestFocus(_fStartDate);
    } catch (e) {
      print('Exception - addCouponScreen.dart - _selectStartDate(): ' + e.toString());
    }
  }

  Future _seletEndDate() async {
    try {
      final DateTime? picked = await showDatePicker(
        lastDate: DateTime(2022),
        context: context,
        initialDate: _startdDate,
        firstDate: _startdDate,
      );
      if (picked != null && picked != DateTime(2000)) {
        setState(() {
          _endDate = picked;
          _cEndDate.text = formatDate(_endDate, [yyyy, '-', mm, '-', dd]);
        });
      }
      FocusScope.of(context).requestFocus(_fEndDate);
    } catch (e) {
      print('Exception - addCouponScreen.dart - _selectStartDate(): ' + e.toString());
    }
  }
}
