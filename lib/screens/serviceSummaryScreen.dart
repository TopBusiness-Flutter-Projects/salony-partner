import 'dart:io';

import 'package:app/models/bookingDetailModel.dart';
import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/widgets/bottomNavigationBar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceSummaryScreen extends BaseRoute {
  final BookingDetail bookingDetail;
  ServiceSummaryScreen(this.bookingDetail, {a, o})
      : super(a: a, o: o, r: 'ServiceSummaryScreen');
  @override
  _ServiceSummaryScreenState createState() =>
      new _ServiceSummaryScreenState(this.bookingDetail);
}

class _ServiceSummaryScreenState extends BaseRouteState {
  late GlobalKey<ScaffoldState> _scaffoldKey;
  BookingDetail bookingDetail;

  _ServiceSummaryScreenState(this.bookingDetail) : super();

  @override
  Widget build(BuildContext context) {
    return sc(
      WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop();
          return false;
        },
        child: Scaffold(
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
                              Colors.blueGrey.withOpacity(0.6),
                          BlendMode.screen,
                        ),
                        child: Image.asset(
                          'assets/banner.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: Platform.isAndroid
                            ? EdgeInsets.only(bottom: 15, left: 10, top: 10)
                            : EdgeInsets.only(bottom: 15, left: 10, top: 20),
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
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 25, bottom: 10),
                          child: Text(
                              AppLocalizations.of(context)!.lbl_service_summary,
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .headline3)),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    bookingDetail.user != null
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.only(top: 15),
                                            child: CircleAvatar(
                                              radius: 38,
                                              child: bookingDetail
                                                          .user?.image ==
                                                      "N/A"
                                                  ? Image.asset(
                                                      'assets/userImage.png')
                                                  : CachedNetworkImage(
                                                      imageUrl: global
                                                              .baseUrlForImage +
                                                          bookingDetail
                                                              .user!.image!,
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          CircleAvatar(
                                                        radius: 38,
                                                        backgroundImage:
                                                            imageProvider,
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
                                        : SizedBox(),
                                    Container(
                                        margin: EdgeInsets.only(top: 5),
                                        child: Text(
                                            '${bookingDetail.user?.name}',
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .headline4)),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              _makingPhoneCall(
                                                  "${bookingDetail.mobile}");
                                            },
                                            child: CircleAvatar(
                                              radius: 13,
                                              backgroundColor: Theme.of(context)
                                                  .primaryColor,
                                              child: Icon(
                                                Icons.call,
                                                size: 15,
                                                color: Theme.of(context)
                                                    .primaryIconTheme
                                                    .color,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              _massages(
                                                  "${bookingDetail.mobile}");
                                            },
                                            child: Padding(
                                              padding: global.isRTL
                                                  ? EdgeInsets.only(right: 5)
                                                  : EdgeInsets.only(left: 5),
                                              child: CircleAvatar(
                                                radius: 13,
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .primaryColor,
                                                child: Icon(
                                                  Icons.message,
                                                  size: 15,
                                                  color: Theme.of(context)
                                                      .primaryIconTheme
                                                      .color,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, top: 15),
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .lbl_date_and_time,
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .headline4,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  AppLocalizations.of(context)!
                                                      .lbl_date,
                                                  style: Theme.of(context)
                                                      .primaryTextTheme
                                                      .subtitle1),
                                              Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 3),
                                                  child: Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .lbl_time,
                                                      style: Theme.of(context)
                                                          .primaryTextTheme
                                                          .subtitle1)),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                  '${bookingDetail.service_date}',
                                                  style: Theme.of(context)
                                                      .primaryTextTheme
                                                      .subtitle1),
                                              Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 3),
                                                  child: Text(
                                                      '${bookingDetail.service_time}',
                                                      style: Theme.of(context)
                                                          .primaryTextTheme
                                                          .subtitle1)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                          AppLocalizations.of(context)!
                                              .lbl_amount,
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .headline4),
                                    ),
                                    Padding(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              AppLocalizations.of(context)!
                                                  .lbl_service,
                                              style: Theme.of(context)
                                                  .primaryTextTheme
                                                  .subtitle2),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 5),
                                            child: Text(
                                                AppLocalizations.of(context)!
                                                    .lbl_price,
                                                style: Theme.of(context)
                                                    .primaryTextTheme
                                                    .subtitle2),
                                          )
                                        ],
                                      ),
                                      padding: EdgeInsets.only(top: 5),
                                    ),
                                    LimitedBox(
                                      maxHeight: 250,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: bookingDetail.items.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 3, bottom: 1),
                                                  child: Text(
                                                    '${bookingDetail.items[index].varient}',
                                                    style: Theme.of(context)
                                                        .primaryTextTheme
                                                        .subtitle1,
                                                  ),
                                                ),
                                                Text(
                                                  '${global.currency.currency_sign ?? 'SAR'}${bookingDetail.items[index].price}',
                                                  style: Theme.of(context)
                                                      .primaryTextTheme
                                                      .subtitle1,
                                                )
                                              ],
                                            );
                                          }),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Divider(),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  AppLocalizations.of(context)!
                                                      .lbl_subTotal,
                                                  style: Theme.of(context)
                                                      .primaryTextTheme
                                                      .subtitle2),
                                              Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 3),
                                                  child: Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .lbl_discount_by_coupon,
                                                      style: Theme.of(context)
                                                          .primaryTextTheme
                                                          .subtitle2)),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                  '${global.currency.currency_sign ?? 'SAR'}${bookingDetail.total_price}',
                                                  style: Theme.of(context)
                                                      .primaryTextTheme
                                                      .subtitle2),
                                              Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 3),
                                                  child: Text(
                                                      bookingDetail
                                                                  .coupon_discount !=
                                                              null
                                                          ? '-${global.currency.currency_sign ?? 'SAR'} ${bookingDetail.coupon_discount}'
                                                          : '-${global.currency.currency_sign ?? 'SAR'}0',
                                                      style: Theme.of(context)
                                                          .primaryTextTheme
                                                          .subtitle2)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Divider(),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              AppLocalizations.of(context)!
                                                  .lbl_total,
                                              style: Theme.of(context)
                                                  .primaryTextTheme
                                                  .subtitle2),
                                          Text(
                                              '${global.currency.currency_sign ?? 'SAR'}${bookingDetail.rem_price}',
                                              style: Theme.of(context)
                                                  .primaryTextTheme
                                                  .subtitle2)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
          bottomNavigationBar: Container(
            margin: EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: TextButton(
              onPressed: () {
                _confirmationDialog(bookingDetail.id,
                    int.parse(bookingDetail.in_door_val.toString() ?? "0"));
              },
              child: Text(
                AppLocalizations.of(context)!.btn_confirm,
              ),
            ),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(10))),
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
  }

  Future _confirmationDialog(orderId, int inDoorVal) async {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(
              AppLocalizations.of(context)!.lbl_confirm_service,
            ),
            content: Text(AppLocalizations.of(context)!
                .txt_confirmation_message_for_confirm_service),
            actions: [
              TextButton(
                child: Text(AppLocalizations.of(context)!.lbl_no),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: Text(AppLocalizations.of(context)!.lbl_yes),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await _confirmService(orderId, inDoorVal);
                },
              )
            ],
          );
        });
  }

  _confirmService(int orderId, int inDoorVal) async {
    showOnlyLoaderDialog();
    await apiHelper?.bookingConfirm(orderId, inDoorVal).then((result) {
      if (result.status == "1") {
        hideLoader();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => BottomNavigationWidget(
                  a: widget.analytics,
                  o: widget.observer,
                )));
      } else {
        hideLoader();
        showSnackBar(snackBarMessage: '${result.message}');
      }
    });
  }

  _makingPhoneCall(String number) async {
    try {
      String url = 'tel:' + '$number';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print(
          'Exception - serviceSummayScreen.dart - _makingPhoneCall(): ${e.toString()}');
    }
  }

  _massages(String number) async {
    try {
      String url = 'sms:' + '$number';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print(
          'Exception - serviceSummayScreen.dart - _massages(): ${e.toString()}');
    }
  }
}
