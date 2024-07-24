import 'package:app/dialogs/userRequestAcceptDialog.dart';
import 'package:app/models/appointmentHistoryModel.dart';
import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';

class AppointmentHistoryScreen extends BaseRoute {
  AppointmentHistoryScreen({a, o})
      : super(a: a, o: o, r: 'AppointmentHistoryScreen');
  @override
  _AppointmentHistoryScreenState createState() =>
      new _AppointmentHistoryScreenState();
}

class _AppointmentHistoryScreenState extends BaseRouteState {
  late GlobalKey<ScaffoldState> _scaffoldKey;
  List<AppointmentHistory> _appointmentHistoryList = [];
  bool _isDataLoaded = false;

  _AppointmentHistoryScreenState() : super();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: sc(
        Scaffold(
            body: Stack(
          children: [
            Container(
              height: 100,
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
                            AppLocalizations.of(context)!
                                .lbl_appointment_history,
                            style: Theme.of(context)
                                .primaryTextTheme
                                .displaySmall),
                      ),
                      _isDataLoaded
                          ? _appointmentHistoryList.length > 0
                              ? Expanded(
                                  child: ListView.builder(
                                      itemCount: _appointmentHistoryList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return GestureDetector(
                                          onTap: () {
                                            _detailDialog(index);
                                          },
                                          child: Card(
                                            margin: EdgeInsets.only(top: 8),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: global.isRTL
                                                      ? EdgeInsets.only(
                                                          right: 5)
                                                      : EdgeInsets.only(
                                                          left: 5),
                                                  child: CircleAvatar(
                                                    child: _appointmentHistoryList[
                                                                    index]
                                                                .user ==
                                                            null
                                                        ? CircleAvatar(
                                                            radius: 25,
                                                            backgroundImage:
                                                                AssetImage(
                                                                    'assets/userImage.png'))
                                                        : _appointmentHistoryList[
                                                                        index]
                                                                    .user
                                                                    ?.image ==
                                                                'N/A'
                                                            ? CircleAvatar(
                                                                radius: 25,
                                                                backgroundImage:
                                                                    AssetImage(
                                                                        'assets/userImage.png'))
                                                            : CachedNetworkImage(
                                                                imageUrl: global
                                                                        .baseUrlForImage +
                                                                    _appointmentHistoryList[
                                                                            index]
                                                                        .user!
                                                                        .image!,
                                                                imageBuilder: (context,
                                                                        imageProvider) =>
                                                                    CircleAvatar(
                                                                  radius: 25,
                                                                  backgroundImage:
                                                                      imageProvider,
                                                                ),
                                                                placeholder: (context,
                                                                        url) =>
                                                                    Center(
                                                                        child:
                                                                            CircularProgressIndicator()),
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    Icon(Icons
                                                                        .error),
                                                              ),
                                                    radius: 25,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding: global.isRTL
                                                        ? EdgeInsets.only(
                                                            right: 10.0, top: 5)
                                                        : EdgeInsets.only(
                                                            left: 10.0, top: 5),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                            child: Text(
                                                          _appointmentHistoryList[
                                                                          index]
                                                                      .user !=
                                                                  null
                                                              ? '${_appointmentHistoryList[index].user?.name}'
                                                              : 'No Name',
                                                        )),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(top: 2),
                                                          child: Text(
                                                            '${_appointmentHistoryList[index].serviceDate} \n${_appointmentHistoryList[index].serviceTime}',
                                                            style: Theme.of(
                                                                    context)
                                                                .primaryTextTheme
                                                                .subtitle1,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 80,
                                                  margin:
                                                      EdgeInsets.only(right: 5),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        '${global.currency.currency_sign ?? 'SAR'}${_appointmentHistoryList[index].totalPrice}',
                                                      ),
                                                      Container(
                                                        height: 40,
                                                        width: 118,
                                                        child: Text(
                                                          '${_appointmentHistoryList[index].statustext}',
                                                          style: Theme.of(
                                                                  context)
                                                              .primaryTextTheme
                                                              .subtitle1,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                )
                              : Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height /
                                                3),
                                    child: Text(AppLocalizations.of(context)!
                                        .txt_appointment_history_will_be_shown_here),
                                  ),
                                )
                          : Expanded(child: _shimmer())
                    ],
                  ),
                ))
          ],
        )),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  getAppointmentHistory() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper?.getAppointmentHistory(global.user.id!).then((result) {
          if (result != null) {
            if (result.status == "1") {
              _appointmentHistoryList = result.recordList;
            } else {
              _appointmentHistoryList = [];
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print(
          "Exception - appointmentHistoryScreen.dart - getAppointmentHistory():" +
              e.toString());
    }
  }

  init() async {
    try {
      await getAppointmentHistory();
      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print(
          "Exception - appointmentHistoryScreen.dart - init():" + e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  _detailDialog(int _index) {
    try {
      showDialog(
          context: context,
          builder: (context) => UserRequestAcceptDialog(
                _appointmentHistoryList[_index].id!,
                true,
                1,
                a: widget.analytics,
                o: widget.observer,
              ));
    } catch (e) {
      print(
          'Exception: appointmentHistoryScreen: _detailDialog(): ${e.toString()}');
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
            itemCount: 8,
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
