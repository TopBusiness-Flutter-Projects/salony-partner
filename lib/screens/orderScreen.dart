import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/expertModel.dart';
import 'package:app/models/productOrderModel.dart';
import 'package:app/widgets/bottomNavigationBar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';

class OrderScreen extends BaseRoute {
  final int? screenId;
  OrderScreen({a, o, this.screenId}) : super(a: a, o: o, r: 'OrderScreen');
  @override
  _OrderScreenState createState() => new _OrderScreenState(screenId: screenId);
}

class _OrderScreenState extends BaseRouteState {
  bool _isDataLoaded = false;
  late GlobalKey<ScaffoldState> _scaffoldKey;
  List<ProductOrder> _orderList = [];
  int? screenId;
  Expert experts = new Expert();

  _OrderScreenState({this.screenId}) : super();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        screenId == 1
            ? Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => BottomNavigationWidget(
                          a: widget.analytics,
                          o: widget.observer,
                        )),
              )
            : Navigator.of(context).pop();
        return false;
      },
      child: Scaffold(
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
                      padding: EdgeInsets.only(bottom: 15, left: 10, top: 10),
                      child: GestureDetector(
                        onTap: () {
                          screenId == 1
                              ? Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          BottomNavigationWidget(
                                            a: widget.analytics,
                                            o: widget.observer,
                                          )),
                                )
                              : Navigator.of(context).pop();
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
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 30, bottom: 10),
                            child: Text(
                              AppLocalizations.of(context)!.lbl_orders,
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .displaySmall,
                            )),
                        _isDataLoaded
                            ? _orderList.length > 0
                                ? Expanded(
                                    child: ListView.builder(
                                        itemCount: _orderList.length,
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Container(
                                            // height: 123,
                                            padding: const EdgeInsets.only(
                                                bottom: 8),
                                            child: Card(
                                                child: Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                      padding: global.isRTL
                                                          ? EdgeInsets.only(
                                                              top: 5, right: 5)
                                                          : EdgeInsets.only(
                                                              top: 5, left: 5),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .only(),
                                                            child: Text(
                                                              _orderList[index]
                                                                          .user !=
                                                                      null
                                                                  ? '${_orderList[index].order_cart_id}-${_orderList[index].user?.name}'
                                                                  : '${_orderList[index].order_cart_id}-No name',
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .black),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 1,
                                                            ),
                                                          ),
                                                          _orderList[index]
                                                                      .user !=
                                                                  null
                                                              ? Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(),
                                                                  child: Text(
                                                                    _orderList[index].user !=
                                                                            null
                                                                        ? '${_orderList[index].user?.user_phone}'
                                                                        : '',
                                                                    style: TextStyle(
                                                                        color: Colors.grey[
                                                                            600],
                                                                        fontSize:
                                                                            13),
                                                                  ),
                                                                )
                                                              : SizedBox(),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                height: 60,
                                                                width: 60,
                                                                child: _orderList[index]
                                                                            .productImage ==
                                                                        ""
                                                                    ? ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(5)),
                                                                        child: Image
                                                                            .asset(
                                                                          'assets/sample_image.jpg',
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      )
                                                                    : ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(5)),
                                                                        child:
                                                                            CachedNetworkImage(
                                                                          imageUrl:
                                                                              global.baseUrlForImage + _orderList[index].productImage!,
                                                                          imageBuilder: (context, imageProvider) =>
                                                                              Container(
                                                                            height:
                                                                                60,
                                                                            decoration:
                                                                                BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: imageProvider)),
                                                                          ),
                                                                          placeholder: (context, url) =>
                                                                              Center(child: CircularProgressIndicator()),
                                                                          errorWidget: (context, url, error) =>
                                                                              Icon(Icons.error),
                                                                        ),
                                                                      ),
                                                              ),
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  margin: global
                                                                          .isRTL
                                                                      ? EdgeInsets.only(
                                                                          right:
                                                                              5)
                                                                      : EdgeInsets.only(
                                                                          left:
                                                                              5),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(),
                                                                        child:
                                                                            Text(
                                                                          '${_orderList[index].productName}',
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          maxLines:
                                                                              2,
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: 14),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(),
                                                                        child:
                                                                            Text(
                                                                          '${_orderList[index].quantity}',
                                                                          style: TextStyle(
                                                                              color: Colors.grey[600],
                                                                              fontSize: 13),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      )),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: 5),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            if (_orderList[
                                                                        index]
                                                                    .statustext ==
                                                                "Pending") {
                                                              _orderConfirmationDialog(
                                                                  _orderList[
                                                                          index]
                                                                      .store_order_id);
                                                            }
                                                          },
                                                          child: Container(
                                                            height: 30,
                                                            width: 130,
                                                            decoration: BoxDecoration(
                                                                color: _orderList[index].statustext == "Pending"
                                                                    ? Colors.amber
                                                                    : _orderList[index].statustext == "Completed"
                                                                        ? Colors.green[600]
                                                                        : _orderList[index].statustext == "Cancelled"
                                                                            ? Colors.grey
                                                                            : _orderList[index].statustext == "Payment Failed"
                                                                                ? Colors.red
                                                                                : _orderList[index].statustext == "Confirmed"
                                                                                    ? Colors.blue[600]
                                                                                    : Colors.red,
                                                                borderRadius: BorderRadius.all(Radius.circular(5))),
                                                            padding:
                                                                EdgeInsets.all(
                                                                    4),
                                                            child: Center(
                                                              child: Text(
                                                                '${_orderList[index].statustext == "Pending" ? 'معلق' : _orderList[index].statustext == "Completed" ? 'مكتمل' : _orderList[index].statustext == "Cancelled" ? 'ملغي' : _orderList[index].statustext == "Payment Failed" ? 'فشل الدفع' : _orderList[index].statustext == "Confirmed" ? 'تم التأكيد' : ''}',
                                                                style: Theme.of(
                                                                        context)
                                                                    .primaryTextTheme
                                                                    .headlineSmall,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: global.isRTL
                                                              ? EdgeInsets.only(
                                                                  top: 3,
                                                                  left: 5)
                                                              : EdgeInsets.only(
                                                                  top: 3,
                                                                  right: 5),
                                                          child: Text(
                                                            '${_orderList[index].order_date}',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey[600],
                                                                fontSize: 13),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: global.isRTL
                                                              ? EdgeInsets.only(
                                                                  top: 2,
                                                                  bottom: 2,
                                                                  left: 5)
                                                              : EdgeInsets.only(
                                                                  top: 2,
                                                                  bottom: 2,
                                                                  right: 5),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              SizedBox(
                                                                child:
                                                                    Container(
                                                                  width: 40,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius: global
                                                                            .isRTL
                                                                        ? BorderRadius
                                                                            .only(
                                                                            topRight:
                                                                                new Radius.circular(5.0),
                                                                            bottomRight:
                                                                                new Radius.circular(5.0),
                                                                          )
                                                                        : BorderRadius
                                                                            .only(
                                                                            topLeft:
                                                                                new Radius.circular(5.0),
                                                                            bottomLeft:
                                                                                new Radius.circular(5.0),
                                                                          ),
                                                                    color: Colors
                                                                            .grey[
                                                                        350],
                                                                    border:
                                                                        new Border
                                                                            .all(
                                                                      color: Colors
                                                                              .grey[
                                                                          350]!,
                                                                    ),
                                                                  ),
                                                                  height: 25,
                                                                  child: Center(
                                                                    child: Text(
                                                                      AppLocalizations.of(
                                                                              context)!
                                                                          .lbl_qty,
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              13),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 25,
                                                                width: 40,
                                                                child: Center(
                                                                  child: Text(
                                                                    "${_orderList[index].qty}",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontSize:
                                                                            13),
                                                                  ),
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius: global
                                                                          .isRTL
                                                                      ? BorderRadius
                                                                          .only(
                                                                          topLeft: new Radius
                                                                              .circular(
                                                                              5.0),
                                                                          bottomLeft: new Radius
                                                                              .circular(
                                                                              5.0),
                                                                        )
                                                                      : BorderRadius
                                                                          .only(
                                                                          topRight: new Radius
                                                                              .circular(
                                                                              5.0),
                                                                          bottomRight: new Radius
                                                                              .circular(
                                                                              5.0),
                                                                        ),
                                                                  border:
                                                                      new Border
                                                                          .all(
                                                                    color: Colors
                                                                            .grey[
                                                                        350]!,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        _orderList[index]
                                                                    .order !=
                                                                null
                                                            ? Padding(
                                                                padding: global
                                                                        .isRTL
                                                                    ? EdgeInsets.only(
                                                                        top: 2,
                                                                        bottom:
                                                                            2,
                                                                        left: 5)
                                                                    : EdgeInsets.only(
                                                                        top: 2,
                                                                        bottom:
                                                                            2,
                                                                        right:
                                                                            5),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: <Widget>[
                                                                    SizedBox(
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            70,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius: global.isRTL
                                                                              ? BorderRadius.only(
                                                                                  topRight: new Radius.circular(5.0),
                                                                                  bottomRight: new Radius.circular(5.0),
                                                                                )
                                                                              : BorderRadius.only(
                                                                                  topLeft: new Radius.circular(5.0),
                                                                                  bottomLeft: new Radius.circular(5.0),
                                                                                ),
                                                                          color:
                                                                              Colors.grey[350],
                                                                          border:
                                                                              new Border.all(
                                                                            color:
                                                                                Colors.grey[350]!,
                                                                          ),
                                                                        ),
                                                                        height:
                                                                            25,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            '${_orderList[index].order?.payment_status}',
                                                                            style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.w500,
                                                                                fontSize: 13),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      height:
                                                                          25,
                                                                      width: 70,
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          "${global.currency.currency_sign}${_orderList[index].total_price}",
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: 13),
                                                                        ),
                                                                      ),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius: global.isRTL
                                                                            ? BorderRadius.only(
                                                                                topLeft: new Radius.circular(5.0),
                                                                                bottomLeft: new Radius.circular(5.0),
                                                                              )
                                                                            : BorderRadius.only(
                                                                                topRight: new Radius.circular(5.0),
                                                                                bottomRight: new Radius.circular(5.0),
                                                                              ),
                                                                        border:
                                                                            new Border.all(
                                                                          color:
                                                                              Colors.grey[350]!,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              )
                                                            : SizedBox(),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )),
                                          );
                                        }),
                                  )
                                : Container(
                                    padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height /
                                                3),
                                    child: Text(AppLocalizations.of(context)!
                                        .txt_orders_will_shown_here))
                            : Expanded(child: _shimmer())
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
    _init();
  }

  _cancelOrder(int storeOrderId) async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        showOnlyLoaderDialog();
        await apiHelper?.cancelOrder(storeOrderId).then((result) {
          if (result.status == "1") {
            Navigator.of(context).pop();
            _init();
          } else {
            Navigator.of(context).pop();
            showSnackBar(snackBarMessage: '${result.message}');
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - orderScreen.dart - _cancelOrder():" + e.toString());
    }
  }

  _completeOrder(int storeOrderId) async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        showOnlyLoaderDialog();
        await apiHelper?.completeOrder(storeOrderId).then((result) {
          if (result.status == "1") {
            Navigator.of(context).pop();
            _init();
          } else {
            Navigator.of(context).pop();
            showSnackBar(snackBarMessage: '${result.message}');
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - orderScreen.dart - _completeOrder():" + e.toString());
    }
  }

  _init() async {
    try {
      await _orders();

      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("Exception - orderScreen.dart - _init():" + e.toString());
    }
  }

  Future _orderConfirmationDialog(storeOrderId) async {
    try {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text(
                'طلب معلق',
              ),
              content: Text('هل تريد تغيير حالة الطلب؟'),
              actions: [
                TextButton(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 2, bottom: 2),
                    child: Text('إكمال الطلب'),
                  ),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await _completeOrder(storeOrderId);
                  },
                ),
                TextButton(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 2, bottom: 2),
                    child: Text('إلغاء الطلب'),
                  ),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await _cancelOrder(storeOrderId);
                  },
                )
              ],
            );
          });
    } catch (e) {
      print("Exception - orderScreen.dart - _orderConfirmationDialog():" +
          e.toString());
    }
  }

  _orders() async {
    try {
      setState(() {
        _isDataLoaded = false;
      });
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper?.productOrders(global.user.id!).then((result) {
          if (result != null) {
            if (result.status == "1") {
              _orderList = result.recordList;
            } else {
              _orderList = [];
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - orderScreen.dart - _orders():" + e.toString());
    }
  }

  Widget _shimmer() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 85,
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      child: Card(),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15.0, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 30,
                              child: Card(
                                margin:
                                    EdgeInsets.only(bottom: 5, left: 5, top: 5),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 30,
                              child: Card(
                                  margin: EdgeInsets.only(
                                      bottom: 5, left: 5, top: 5)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
