import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/notificationModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';

class NotificationScreen extends BaseRoute {
  NotificationScreen({a, o}) : super(a: a, o: o, r: 'NotificationScreen');

  @override
  _NotificationScreenState createState() => new _NotificationScreenState();
}

class _NotificationScreenState extends BaseRouteState {
  late GlobalKey<ScaffoldState> _scaffoldKey;
  List<Notifications> _notificationList = [];
  bool _isDataLoaded = false;

  _NotificationScreenState() : super();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
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
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 30, bottom: 10),
                            child: Text(
                              AppLocalizations.of(context)!.lbl_notification,
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .displaySmall,
                            )),
                        _isDataLoaded
                            ? _notificationList.length > 0
                                ? Expanded(
                                    child: ListView.builder(
                                        itemCount: _notificationList.length,
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Container(
                                            padding: const EdgeInsets.only(
                                                bottom: 8),
                                            child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: global.isRTL
                                                        ? BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    20),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    20))
                                                        : BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    20),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    20))),
                                                child: ExpansionTile(
                                                  leading: Container(
                                                    padding: EdgeInsets.only(
                                                        top: 3, bottom: 3),
                                                    margin: global.isRTL
                                                        ? EdgeInsets.only(
                                                            right: 0)
                                                        : EdgeInsets.only(
                                                            left: 0),
                                                    child: CircleAvatar(
                                                      child: (_notificationList[
                                                                          index]
                                                                      .image !=
                                                                  null &&
                                                              _notificationList[
                                                                          index]
                                                                      .image !=
                                                                  '${global.baseUrlForImage}N/A')
                                                          ? CircleAvatar(
                                                              radius: 28,
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                _notificationList[
                                                                            index]
                                                                        .image ??
                                                                    '',
                                                              ),
                                                            )
                                                          : CachedNetworkImage(
                                                              imageUrl: global
                                                                      .baseUrlForImage +
                                                                  _notificationList[
                                                                          index]
                                                                      .image!,
                                                              imageBuilder: (context,
                                                                      imageProvider) =>
                                                                  CircleAvatar(
                                                                radius: 28,
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
                                                      radius: 28,
                                                    ),
                                                  ),
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      child: Text(
                                                        '${_notificationList[index].not_message}',
                                                        // style: Theme.of(context)
                                                        //     .primaryTextTheme
                                                        //     .subtitle1,
                                                      ),
                                                    ),
                                                  ],
                                                  title: Text(
                                                    '${_notificationList[index].not_title}',
                                                    // style: Theme.of(context)
                                                    //     .primaryTextTheme
                                                    //     .headlineSmall,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 3,
                                                  ),
                                                )),
                                          );
                                        }),
                                  )
                                : Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              3),
                                      child: Text(AppLocalizations.of(context)!
                                          .txt_notification_will_shown_here),
                                    ),
                                  )
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

  getNotification() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper?.getNotification(global.user.id!).then((result) {
          if (result != null) {
            if (result.status == "1") {
              _notificationList = result.recordList;
            } else {
              _notificationList = [];
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - notificationScreen.dart - _getNotification():" +
          e.toString());
    }
  }

  init() async {
    try {
      await getNotification();
      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("Exception - notificationScreen.dart - init():" + e.toString());
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
