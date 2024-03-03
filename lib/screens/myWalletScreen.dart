import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/myWalletModel.dart';
import 'package:app/screens/walletDetailScreen.dart';
import 'package:app/widgets/bottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';

class MyWalletScreen extends BaseRoute {
  final int? screenId;
  MyWalletScreen({a, o, this.screenId})
      : super(a: a, o: o, r: 'MyWalletScreen');
  @override
  _MyWalletScreenState createState() =>
      new _MyWalletScreenState(screenId: screenId);
}

class _MyWalletScreenState extends BaseRouteState {
  MyWallet? _myWallet = new MyWallet();
  late GlobalKey<ScaffoldState> _scaffoldKey;
  bool _isDataLoaded = false;
  int? screenId;

  _MyWalletScreenState({this.screenId}) : super();

  @override
  Widget build(BuildContext context) {
    // final languageCode = Localizations.localeOf(context).languageCode;
    final double cellHeight = 75;
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
                            margin: EdgeInsets.only(top: 30, bottom: 5),
                            child: Text(
                              AppLocalizations.of(context)!.lbl_my_wallet,
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .displaySmall,
                            )),
                        _isDataLoaded
                            ? Expanded(
                                child: ListView(
                                shrinkWrap: true,
                                children: [
                                  Container(
                                      height: 75,
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      margin: EdgeInsets.only(
                                        bottom: 5,
                                      ),
                                      width: MediaQuery.of(context).size.width,
                                      child: Card(
                                        elevation: 5,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 0),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: global.isRTL
                                                        ? EdgeInsets.only(
                                                            right: 10, top: 10)
                                                        : EdgeInsets.only(
                                                            left: 10, top: 10),
                                                    child: Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .lbl_total_earning,
                                                      style: Theme.of(context)
                                                          .primaryTextTheme
                                                          .titleSmall,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: global.isRTL
                                                  ? EdgeInsets.only(left: 10)
                                                  : EdgeInsets.only(right: 10),
                                              height: 30,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      width: 1)),
                                              padding: EdgeInsets.only(
                                                  left: 5,
                                                  right: 2,
                                                  top: 2,
                                                  bottom: 2),
                                              child: Center(
                                                  child: Text(
                                                '${global.currency.currency_sign ?? 'SAR'} ${_myWallet?.total_price}',
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                            ),
                                          ],
                                        ),
                                      )),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  WalletDetailScreen(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .txt_total_admin_share_sent_by_vendor,
                                                    _myWallet!.share_sent,
                                                    a: widget.analytics,
                                                    o: widget.observer,
                                                  )));
                                    },
                                    child: Container(
                                        height: 75,
                                        margin: EdgeInsets.only(bottom: 5),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Card(
                                          elevation: 5,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: global.isRTL
                                                          ? EdgeInsets.only(
                                                              right: 10)
                                                          : EdgeInsets.only(
                                                              left: 10),
                                                      child: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .txt_total_admin_share_sent_by_vendor,
                                                        style: Theme.of(context)
                                                            .primaryTextTheme
                                                            .titleSmall,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: global.isRTL
                                                          ? EdgeInsets.only(
                                                              right: 10)
                                                          : EdgeInsets.only(
                                                              left: 10),
                                                      child: Text(
                                                        '${global.currency.currency_sign ?? 'SAR'}${_myWallet?.share_sent_amount}',
                                                        style: Theme.of(context)
                                                            .primaryTextTheme
                                                            .titleMedium,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                  padding: global.isRTL
                                                      ? EdgeInsets.only(left: 5)
                                                      : EdgeInsets.only(
                                                          right: 5),
                                                  child: Icon(Icons
                                                      .keyboard_arrow_right_rounded))
                                            ],
                                          ),
                                        )),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  WalletDetailScreen(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .txt_total_admin_share_pending_at_vendor,
                                                    _myWallet!
                                                        .share_sent_pending,
                                                    a: widget.analytics,
                                                    o: widget.observer,
                                                  )));
                                    },
                                    child: Container(
                                        height: cellHeight,
                                        margin: EdgeInsets.only(bottom: 5),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Card(
                                          elevation: 5,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding: global.isRTL
                                                            ? EdgeInsets.only(
                                                                right: 10)
                                                            : EdgeInsets.only(
                                                                left: 10),
                                                        child: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .txt_total_admin_share_pending_at_vendor,
                                                          style: Theme.of(
                                                                  context)
                                                              .primaryTextTheme
                                                              .titleSmall,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: global.isRTL
                                                            ? EdgeInsets.only(
                                                                right: 10)
                                                            : EdgeInsets.only(
                                                                left: 10),
                                                        child: Text(
                                                          '${global.currency.currency_sign ?? 'SAR'}${_myWallet?.share_sent_pending_amount}',
                                                          style: Theme.of(
                                                                  context)
                                                              .primaryTextTheme
                                                              .titleMedium,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                  padding: global.isRTL
                                                      ? EdgeInsets.only(left: 5)
                                                      : EdgeInsets.only(
                                                          right: 5),
                                                  child: Icon(Icons
                                                      .keyboard_arrow_right_rounded))
                                            ],
                                          ),
                                        )),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  WalletDetailScreen(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .txt_total_vendor_share_given_by_admin,
                                                    _myWallet!.share_given,
                                                    a: widget.analytics,
                                                    o: widget.observer,
                                                  )));
                                    },
                                    child: Container(
                                        height: cellHeight,
                                        margin: EdgeInsets.only(bottom: 5),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Card(
                                          elevation: 5,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding: global.isRTL
                                                            ? EdgeInsets.only(
                                                                right: 10)
                                                            : EdgeInsets.only(
                                                                left: 10),
                                                        child: Expanded(
                                                          child: Text(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .txt_total_vendor_share_given_by_admin,
                                                            style: Theme.of(
                                                                    context)
                                                                .primaryTextTheme
                                                                .titleSmall,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: global.isRTL
                                                            ? EdgeInsets.only(
                                                                right: 10)
                                                            : EdgeInsets.only(
                                                                left: 10),
                                                        child: Expanded(
                                                          child: Text(
                                                            "${global.currency.currency_sign ?? 'SAR'}${_myWallet?.share_given_amount}",
                                                            style: Theme.of(
                                                                    context)
                                                                .primaryTextTheme
                                                                .titleMedium,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                  padding: global.isRTL
                                                      ? EdgeInsets.only(left: 5)
                                                      : EdgeInsets.only(
                                                          right: 5),
                                                  child: Icon(Icons
                                                      .keyboard_arrow_right_rounded))
                                            ],
                                          ),
                                        )),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  WalletDetailScreen(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .txt_total_vendor_share_pending_at_admin,
                                                    _myWallet!
                                                        .share_given_pending,
                                                    a: widget.analytics,
                                                    o: widget.observer,
                                                  )));
                                    },
                                    child: Container(
                                        height: cellHeight,
                                        margin: EdgeInsets.only(bottom: 5),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Card(
                                          elevation: 5,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding: global.isRTL
                                                            ? EdgeInsets.only(
                                                                right: 10)
                                                            : EdgeInsets.only(
                                                                left: 10),
                                                        child: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .txt_total_vendor_share_pending_at_admin,
                                                          style: Theme.of(
                                                                  context)
                                                              .primaryTextTheme
                                                              .titleSmall,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: global.isRTL
                                                            ? EdgeInsets.only(
                                                                right: 10)
                                                            : EdgeInsets.only(
                                                                left: 10),
                                                        child: Expanded(
                                                          child: Text(
                                                            "${global.currency.currency_sign ?? 'SAR'}${_myWallet?.share_given_pending_amount}",
                                                            style: Theme.of(
                                                                    context)
                                                                .primaryTextTheme
                                                                .titleMedium,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                  padding: global.isRTL
                                                      ? EdgeInsets.only(left: 5)
                                                      : EdgeInsets.only(
                                                          right: 5),
                                                  child: Icon(Icons
                                                      .keyboard_arrow_right_rounded))
                                            ],
                                          ),
                                        )),
                                  )
                                ],
                              ))
                            : _shimmer()
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

  getMyWallet() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper?.getMyWallet(global.user.id!).then((result) {
          if (result != null) {
            if (result.status == "1") {
              _myWallet = result.recordList;
            } else {
              _myWallet = null;
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - myWalletScreen.dart - getMyWallet():" + e.toString());
    }
  }

  init() async {
    try {
      await getMyWallet();
      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("Exception - myWalletScreen.dart - init():" + e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  Widget _shimmer() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: 7,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 55,
                padding: const EdgeInsets.only(bottom: 8),
                child: Card(),
              );
            }),
      ),
    );
  }
}
