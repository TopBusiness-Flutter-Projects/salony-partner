import 'package:app/models/bookingDetailModel.dart';
import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/screens/serviceSummaryScreen.dart';
import 'package:app/widgets/bottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserRequestAcceptDialog extends BaseRoute {
  final int screenId;
  final bool isFromAppointmentHistory;
  final int orderId;
  UserRequestAcceptDialog(
      this.orderId, this.isFromAppointmentHistory, this.screenId,
      {a, o})
      : super(a: a, o: o, r: 'UserRequestAcceptDialog');
  @override
  _UserRequestAcceptDialogState createState() =>
      new _UserRequestAcceptDialogState(
          this.orderId, this.isFromAppointmentHistory, this.screenId);
}

class _UserRequestAcceptDialogState extends BaseRouteState {
  int screenId = 1;
  bool isFromAppointmentHistory;
  GlobalKey<ScaffoldState>? _scaffoldKey;
  BookingDetail? _bookingDetail = new BookingDetail();

  bool _isDataLoaded = false;
  int orderId;
  bool isloading = true;

  _UserRequestAcceptDialogState(
      this.orderId, this.isFromAppointmentHistory, this.screenId)
      : super();

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: AlertDialog(
        actions: [
          _isDataLoaded
              ? screenId == 1
                  ? !isFromAppointmentHistory
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          ServiceSummaryScreen(
                                            _bookingDetail ?? BookingDetail(),
                                            a: widget.analytics,
                                            o: widget.observer,
                                          )));
                                } else {
                                  //
                                }
                              },
                              child: Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(05))),
                                  child: Text(
                                    AppLocalizations.of(context)!.lbl_accept,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 13),
                                  )),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                  margin: global.isRTL
                                      ? EdgeInsets.only(right: 10)
                                      : EdgeInsets.only(left: 10),
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(05))),
                                  child: Text(
                                    AppLocalizations.of(context)!.lbl_cancel,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 13),
                                  )),
                            )
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                  padding: EdgeInsets.only(
                                      top: 5, bottom: 5, left: 10, right: 10),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(05))),
                                  child: Text(
                                    AppLocalizations.of(context)!.lbl_ok,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 13),
                                  )),
                            ),
                          ],
                        )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _completeRequest(orderId);
                          },
                          child: Container(
                              padding: EdgeInsets.only(
                                  top: 5, bottom: 5, left: 10, right: 10),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(05))),
                              child: Text('Complete',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13))),
                        ),
                      ],
                    )
              : SizedBox(),
        ],
        insetPadding: EdgeInsets.symmetric(horizontal: 15),
        contentPadding: EdgeInsets.only(top: 25, left: 10, right: 10),
        content: Container(
          // height: MediaQuery.of(context).size.height * 0.5,
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _isDataLoaded
                    ? [
                        ..._widgetList(),
                        isFromAppointmentHistory
                            ? Container()
                            : (_bookingDetail?.in_door == 1)
                                ? Container()
                                : Container(
                                    // height: 50,
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty)
                                          return 'أدخل قيمة الخدمة';
                                        return null;
                                      },
                                      controller: inDoorValCotroller,
                                      onChanged: (value) {
                                        _bookingDetail?.in_door_val = value;
                                      },
                                      // focusNode: FocusNode(),
                                      autofocus: true,
                                      //validate  + controller
                                      decoration: InputDecoration(
                                        hintText:
                                            "قيمة الخدمه خارج المنزل (10 SAR)",
                                        border: InputBorder.none,
                                        fillColor: Colors.white,
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                  )
                      ]
                    : [
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                      ]),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  TextEditingController inDoorValCotroller = TextEditingController();
  getBookingDetail() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper?.getBookingDetail(orderId).then((result) {
          if (result != null) {
            if (result.status == "1") {
              _bookingDetail = result.recordList;
            } else {
              _bookingDetail = null;
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey!);
      }
    } catch (e) {
      print("Exception - userRequestAcceptDialog.dart - getBookingDetail():" +
          e.toString());
    }
  }

  init() async {
    try {
      await getBookingDetail();
      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print(
          "Exception - userRequestAcceptDialog.dart - init():" + e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  _completeRequest(int orderId) async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        showOnlyLoaderDialog();
        await apiHelper?.completeRequest(orderId).then((result) {
          if (result.status == "1") {
            hideLoader();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BottomNavigationWidget(
                      a: widget.analytics,
                      o: widget.observer,
                    )));
          } else {
            Navigator.of(context).pop();
            showSnackBar(snackBarMessage: '${result.message}');
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey!);
      }
    } catch (e) {
      print("Exception - userRequestAcceptDialog.dart - _completeRequest():" +
          e.toString());
    }
  }

  List<Widget> _widgetList() {
    List<Widget> _widgetList = [];
    try {
      _widgetList.add(
        Text(AppLocalizations.of(context)!.lbl_date_and_time,
            style: Theme.of(context).primaryTextTheme.headline4),
      );

      _widgetList.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.lbl_date,
                    style: Theme.of(context).primaryTextTheme.subtitle1),
                Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Text(AppLocalizations.of(context)!.lbl_time,
                        style: Theme.of(context).primaryTextTheme.subtitle1)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('${_bookingDetail?.service_date}',
                    style: Theme.of(context).primaryTextTheme.subtitle1),
                Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Text('${_bookingDetail?.service_time}',
                        style: Theme.of(context).primaryTextTheme.subtitle1)),
              ],
            ),
          ),
        ],
      ));

      _widgetList.add(Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text(AppLocalizations.of(context)!.lbl_amount,
            style: Theme.of(context).primaryTextTheme.headline4),
      ));

      _widgetList.add(Padding(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppLocalizations.of(context)!.lbl_service,
                style: Theme.of(context).primaryTextTheme.subtitle2),
            Padding(
              padding: const EdgeInsets.only(),
              child: Text(AppLocalizations.of(context)!.lbl_price,
                  style: Theme.of(context).primaryTextTheme.subtitle2),
            )
          ],
        ),
        padding: EdgeInsets.only(top: 5),
      ));

      for (int i = 0; i < (_bookingDetail?.items.length ?? 0); i++) {
        _widgetList.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 3, bottom: 1),
              child: Text(
                '${_bookingDetail?.items[i].varient}',
                style: Theme.of(context).primaryTextTheme.subtitle1,
              ),
            ),
            Text(
              '${global.currency.currency_sign ?? 'SAR'} ${_bookingDetail?.items[i].price}',
              style: Theme.of(context).primaryTextTheme.subtitle1,
            )
          ],
        ));
      }

      _widgetList.add(Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Divider(),
      ));

      _widgetList.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.lbl_subTotal,
                    style: Theme.of(context).primaryTextTheme.subtitle2),
                Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Text(
                        AppLocalizations.of(context)!.lbl_discount_by_coupon,
                        style: Theme.of(context).primaryTextTheme.subtitle2)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                    '${global.currency.currency_sign ?? 'SAR'}${_bookingDetail?.total_price}',
                    style: Theme.of(context).primaryTextTheme.subtitle2),
                Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Text(
                        _bookingDetail?.coupon_discount != null
                            ? '-${global.currency.currency_sign ?? 'SAR'} ${_bookingDetail?.coupon_discount}'
                            : '-${global.currency.currency_sign ?? 'SAR'}0',
                        style: Theme.of(context).primaryTextTheme.subtitle2)),
              ],
            ),
          ),
        ],
      ));

      _widgetList.add(Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Divider(),
      ));

      _widgetList.add(Padding(
        padding: EdgeInsets.only(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppLocalizations.of(context)!.lbl_total,
                style: Theme.of(context).primaryTextTheme.subtitle2),
            Text(
                '${global.currency.currency_sign ?? 'SAR'} ${_bookingDetail?.rem_price}',
                style: Theme.of(context).primaryTextTheme.subtitle2)
          ],
        ),
      ));
      _widgetList.add(Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Divider(),
      ));
      _widgetList.add(Padding(
          padding: EdgeInsets.only(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('نوع الخدمه',
                  style: Theme.of(context).primaryTextTheme.subtitle2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (_bookingDetail?.in_door == 1)
                      ? Image.asset(
                          'assets/logo.png',
                          width: MediaQuery.of(context).size.width / 9,
                        )
                      : Image.asset(
                          'assets/salon_home.png',
                          width: MediaQuery.of(context).size.width / 10,
                        ),
                  Container(
                    color: Color(0xFFF36D86),
                    width: 2,
                    height: 15,
                    margin: EdgeInsets.all(5),
                  ),
                  Text(
                    (_bookingDetail?.in_door == 0) ? 'بالمنزل' : 'داخل الصالون',
                    style: TextStyle(color: Color(0xFFF36D86), fontSize: 12),
                  ),
                ],
              )
            ],
          )));

      return _widgetList;
    } catch (e) {
      print("Exception - userRequestAcceptDialog.dart - _widgetList():" +
          e.toString());
      return _widgetList;
    }
  }
}
