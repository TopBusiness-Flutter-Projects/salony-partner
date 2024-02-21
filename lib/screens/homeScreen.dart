import 'dart:async';
import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/homePageModel.dart';
import 'package:app/screens/notificationScreen.dart';
import 'package:app/widgets/drawerWidget.dart';
import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends BaseRoute {
  HomeScreen({a, o}) : super(a: a, o: o, r: 'HomeScreen');
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends BaseRouteState {
  HomePage? _homeData = HomePage();
  bool _isDataLoaded = false;

  bool isloading = true;
  List<String> _days = [];

  double y1 = 0.0;

  double y2 = 0.0;
  double y3 = 0.0;

  double y4 = 0.0;

  double y5 = 0.0;

  double y6 = 1000;

  double y7 = 0.0;

  _HomeScreenState() : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(
        a: widget.analytics,
        o: widget.observer,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          _isDataLoaded
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.33,
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.33,
                        child: CachedNetworkImage(
                          imageUrl: global.baseUrlForImage +
                              (global.user.vendor_logo ?? ''),
                          imageBuilder: (context, imageProvider) => Container(
                            height: 70,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover, image: imageProvider)),
                          ),
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.33,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.black, Colors.transparent],
                            begin: Alignment.bottomCenter,
                            end: Alignment.center,
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        // margin: const EdgeInsets.only(top: 13),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: IconButton(
                                  onPressed: () {
                                    Scaffold.of(context).openDrawer();
                                  },
                                  icon: Icon(
                                    Icons.menu,
                                    // color: Colors.white,
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 15, top: 10, left: 15),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => NotificationScreen(
                                            a: widget.analytics,
                                            o: widget.observer,
                                          )));
                                },
                                child: badges.Badge(
                                  showBadge: _isDataLoaded
                                      ? _homeData!.unread_notification_count! >
                                              0
                                          ? true
                                          : false
                                      : false,
                                  badgeStyle: badges.BadgeStyle(
                                    badgeColor: Theme.of(context).primaryColor,
                                  ),
                                  badgeContent: Text(
                                    '${_homeData?.unread_notification_count}',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 09),
                                  ),
                                  child: CircleAvatar(
                                    radius: 17,
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.notifications_none,
                                      size: 22,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      global.isRTL
                          ? Positioned(
                              bottom: 15,
                              right: 15,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: global.isRTL
                                    ? CrossAxisAlignment.start
                                    : CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${global.user.vendor_name?.toUpperCase()}',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .displayMedium,
                                  ),
                                  Text(
                                    '${global.user.owner_name?.toUpperCase()}',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .headlineSmall,
                                  ),
                                ],
                              ),
                            )
                          : Positioned(
                              bottom: 15,
                              left: 15,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: global.isRTL
                                    ? CrossAxisAlignment.start
                                    : CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${global.user.vendor_name?.toUpperCase()}',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .displayMedium,
                                  ),
                                  Text(
                                    '${global.user.owner_name?.toUpperCase()}',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .headlineSmall,
                                  ),
                                ],
                              ),
                            )
                    ],
                  ),
                )
              : _shimmer1(),
          _isDataLoaded
              ? Card(
                  elevation: 5,
                  margin: EdgeInsets.only(left: 12, right: 10, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: global.isRTL
                            ? EdgeInsets.only(right: 10, top: 10)
                            : EdgeInsets.only(left: 10, top: 10),
                        child: Text(
                          AppLocalizations.of(context)!.lbl_weekly_earn,
                          style: Theme.of(context).primaryTextTheme.bodySmall,
                        ),
                      ),
                      _homeData?.day1Details?.earning == 0 &&
                              _homeData?.day2Details?.earning == 0 &&
                              _homeData?.day3Details?.earning == 0 &&
                              _homeData?.day4Details?.earning == 0 &&
                              _homeData?.day5Details?.earning == 0 &&
                              _homeData?.day6Details?.earning == 0 &&
                              _homeData?.day7Details?.earning == 0
                          ? Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height -
                                  ((MediaQuery.of(context).size.height * 0.33) +
                                      50 +
                                      220),
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .txt_weekly_earn_will_shown_here,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .titleSmall,
                                ),
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.only(
                                  top: 5, left: 55, right: 30, bottom: 5),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height -
                                  ((MediaQuery.of(context).size.height * 0.33) +
                                      50 +
                                      220),
                              child: _isDataLoaded
                                  ? _charts()
                                  : Center(
                                      child: CircularProgressIndicator(),
                                    ))
                    ],
                  ))
              : _shimmer4(),
          Padding(
            padding:
                const EdgeInsets.only(top: 25, left: 10, right: 10, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _isDataLoaded
                    ? Container(
                        margin: EdgeInsets.only(left: 5, right: 5),
                        height: 172,
                        width: (MediaQuery.of(context).size.width / 3) - 10,
                        child: Card(
                            elevation: 5,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Text(
                                    AppLocalizations.of(context)!.lbl_total,
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .titleSmall,
                                  ),
                                ),
                                Text(AppLocalizations.of(context)!.lbl_services,
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .titleSmall),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: _isDataLoaded
                                      ? Text(
                                          _homeData != null
                                              ? '${_homeData?.allOrders}'
                                              : '0',
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .labelSmall
                                              ?.copyWith(color: Colors.blue),
                                        )
                                      : Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                ),
                              ],
                            )),
                      )
                    : _shimmer2(),
                _isDataLoaded
                    ? Container(
                        margin: EdgeInsets.only(left: 5, right: 5),
                        height: 172,
                        width: (MediaQuery.of(context).size.width / 3) - 20,
                        child: Card(
                            elevation: 5,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Text(
                                    AppLocalizations.of(context)!.lbl_pending,
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .titleSmall,
                                  ),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.lbl_services,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .titleSmall,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: _isDataLoaded
                                      ? Text(
                                          _homeData != null
                                              ? '${_homeData?.pendingOrders}'
                                              : '0',
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .labelSmall
                                              ?.copyWith(
                                                  color: Color(0xFFFBD18B)),
                                        )
                                      : Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                ),
                              ],
                            )),
                      )
                    : _shimmer2(),
                _isDataLoaded
                    ? Container(
                        margin: EdgeInsets.only(left: 5, right: 5),
                        height: 172,
                        width: (MediaQuery.of(context).size.width / 3) - 20,
                        child: Card(
                            elevation: 5,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Text(
                                    AppLocalizations.of(context)!.lbl_completed,
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .titleSmall,
                                  ),
                                ),
                                Text(AppLocalizations.of(context)!.lbl_services,
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .titleSmall),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: _isDataLoaded
                                      ? Text(
                                          _homeData != null
                                              ? '${_homeData?.completedOrders}'
                                              : '0',
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .labelSmall
                                              ?.copyWith(
                                                  color: Color(0xFF49EC97)),
                                        )
                                      : Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                ),
                              ],
                            )),
                      )
                    : _shimmer2()
              ],
            ),
          ),
          _isDataLoaded
              ? Container(
                  margin: EdgeInsets.all(15),
                  // height: MediaQuery.of(context).size.height * 0.30,
                  width: MediaQuery.of(context).size.width - 25,
                  padding: EdgeInsets.all(10),
                  child: Card(
                    elevation: 15,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: Text(
                              AppLocalizations.of(context)!
                                  .lbl_complete_our_goals,
                              style:
                                  Theme.of(context).primaryTextTheme.bodySmall,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: _isDataLoaded
                                ? CircularPercentIndicator(
                                    radius: 85.0,
                                    lineWidth: 12.0,
                                    percent: double.parse(_homeData!
                                            .completedGloals!
                                            .toStringAsFixed(2)) /
                                        100,
                                    center: Text(
                                        "${double.parse(_homeData!.completedGloals!.toStringAsFixed(2))}%"),
                                    progressColor:
                                        Theme.of(context).primaryColor,
                                  )
                                : Center(
                                    child: CircularProgressIndicator(),
                                  ),
                          ),
                          SizedBox(height: 10)
                        ],
                      ),
                    ),
                  ),
                )
              : _shimmer3(),
        ],
      )),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  getHomePage() async {
    try {
      await apiHelper?.getHomePage(global.user.id!).then((result) {
        if (result != null) {
          if (result.status == "1") {
            _homeData = result.recordList;
          } else {
            _homeData = null;
          }
        }
      });
    } catch (e) {
      print("Exception - homeScreen.dart - getHomePage():" + e.toString());
    }
  }

  init() async {
    try {
      await getHomePage();
      _isDataLoaded = true;
      setState(() {});
      timetsamp();
      if (_homeData != null) {
        _days.add(_homeData!.day1Details!.day!);
        _days.add(_homeData!.day2Details!.day!);
        _days.add(_homeData!.day3Details!.day!);
        _days.add(_homeData!.day4Details!.day!);
        _days.add(_homeData!.day5Details!.day!);
        _days.add(_homeData!.day6Details!.day!);
        _days.add(_homeData!.day7Details!.day!);
      } else {
        _days = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];
      }
    } catch (e) {
      print("Exception - homeScreen.dart - init():" + e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  void timetsamp() {
    try {
      var duration = Duration(milliseconds: 500);
      Timer(duration, () {
        setState(() {
          if (_homeData?.day1Details?.earning == 0 &&
              _homeData?.day2Details?.earning == 0 &&
              _homeData?.day3Details?.earning == 0 &&
              _homeData?.day4Details?.earning == 0 &&
              _homeData?.day5Details?.earning == 0 &&
              _homeData?.day6Details?.earning == 0 &&
              _homeData?.day7Details?.earning == 0) {
            y1 = 10;
            y2 = 10;
            y3 = 10;
            y4 = 10;
            y5 = 10;
            y6 = 10;
            y7 = 10;
          } else {
            y1 = double.parse(_homeData!.day1Details!.earning.toString());
            y2 = double.parse(_homeData!.day2Details!.earning.toString());
            y3 = double.parse(_homeData!.day3Details!.earning.toString());
            y4 = double.parse(_homeData!.day4Details!.earning.toString());
            y5 = double.parse(_homeData!.day5Details!.earning.toString());
            y6 = double.parse(_homeData!.day6Details!.earning.toString());
            y7 = double.parse(_homeData!.day7Details!.earning.toString());
          }
        });
      });
    } catch (e) {
      print("Exception - homeScreen.dart - timetsamp():" + e.toString());
    }
  }

  void timetsamp2() {
    try {
      var duration = Duration(milliseconds: 800);
      Timer(duration, () {
        setState(() {
          y7 = 1500.00;
        });
      });
    } catch (e) {
      print("Exception - homeScreen.dart - timetsamp2():" + e.toString());
    }
  }

  _charts() {
    final barGroups = <BarChartGroupData>[
      BarChartGroupData(
        x: 15,
        barRods: [
          BarChartRodData(
              y: y1,
              colors: [Color(0xFF47505F)],
              width: 22,
              borderRadius: BorderRadius.zero),
        ],
      ),
      BarChartGroupData(
        x: 15,
        barRods: [
          BarChartRodData(
              y: y2,
              colors: [Color(0xFFF44336)],
              width: 22,
              borderRadius: BorderRadius.zero),
        ],
      ),
      BarChartGroupData(
        x: 15,
        barRods: [
          BarChartRodData(
              y: y3,
              colors: [Color(0xFF4CAF50)],
              width: 22,
              borderRadius: BorderRadius.zero),
        ],
      ),
      BarChartGroupData(
        x: 15,
        barRods: [
          BarChartRodData(
              y: y4,
              colors: [Color(0xFFFDEB3B)],
              width: 22,
              borderRadius: BorderRadius.zero),
        ],
      ),
      BarChartGroupData(
        x: 15,
        barRods: [
          BarChartRodData(
              y: y5,
              colors: [Color(0xFf40C4FF)],
              width: 22,
              borderRadius: BorderRadius.zero),
        ],
      ),
      BarChartGroupData(
        x: 15,
        barRods: [
          BarChartRodData(
              y: y6,
              colors: [Color(0xFFE91E64)],
              width: 22,
              borderRadius: BorderRadius.zero),
        ],
      ),
      BarChartGroupData(
        x: 15,
        barRods: [
          BarChartRodData(
              y: y7,
              colors: [Color(0xFF9C27B0)],
              width: 22,
              borderRadius: BorderRadius.zero),
        ],
      )
    ];

    final barChartData = BarChartData(
      barGroups: barGroups,
      barTouchData: BarTouchData(
        allowTouchBarBackDraw: false,
        enabled: false,
      ),
      borderData: FlBorderData(
        show: false,
      ),
      gridData: FlGridData(show: false),
      axisTitleData: FlAxisTitleData(
        show: true,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
            showTitles: true, getTitles: (double val) => _days[(val.toInt())]),
        leftTitles: SideTitles(
          showTitles: false,
          getTitles: (double val) {
            if (val.toInt() % 5 != 0) return '';
            return '${val.toInt() * 10}';
          },
        ),
      ),
    );

    return BarChart(
      barChartData,
      swapAnimationDuration: Duration(milliseconds: 500),
    );
  }

  Widget _shimmer1() {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
            height: MediaQuery.of(context).size.height * 0.33,
            width: MediaQuery.of(context).size.width,
            child: Card()));
  }

  Widget _shimmer2() {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          margin: EdgeInsets.only(left: 5, right: 5),
          height: 165,
          width: (MediaQuery.of(context).size.width / 3) - 20,
          child: Card(),
        ));
  }

  Widget _shimmer3() {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          margin: EdgeInsets.only(bottom: 15, top: 5),
          height: MediaQuery.of(context).size.height * 0.27,
          width: MediaQuery.of(context).size.width - 25,
          child: Card(),
        ));
  }

  Widget _shimmer4() {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
            margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height -
                ((MediaQuery.of(context).size.height * 0.33) + 50 + 220),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 5, right: 5),
                  height: MediaQuery.of(context).size.height -
                      ((MediaQuery.of(context).size.height * 0.33) + 50 + 220),
                  width: 20,
                  child: Card(),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5, right: 5),
                  height: 155,
                  width: 20,
                  child: Card(),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5, right: 5),
                  height: 200,
                  width: 20,
                  child: Card(),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5, right: 5),
                  height: MediaQuery.of(context).size.height -
                      ((MediaQuery.of(context).size.height * 0.33) + 50 + 50),
                  width: 20,
                  child: Card(),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5, right: 5),
                  height: 125,
                  width: 20,
                  child: Card(),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5, right: 5),
                  height: 100,
                  width: 20,
                  child: Card(),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5, right: 5),
                  height: MediaQuery.of(context).size.height -
                      ((MediaQuery.of(context).size.height * 0.33) + 50 + 100),
                  width: 20,
                  child: Card(),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5, right: 5),
                  height: MediaQuery.of(context).size.height -
                      ((MediaQuery.of(context).size.height * 0.33) + 50 + 100),
                  width: 20,
                  child: Card(),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5, right: 5),
                  height: 150,
                  width: 20,
                  child: Card(),
                ),
              ],
            )));
  }
}
