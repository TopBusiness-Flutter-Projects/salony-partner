import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/partnerUserModel.dart';
import 'package:app/screens/reviewScreen.dart';
import 'package:app/screens/updateProfileScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shimmer/shimmer.dart';

class ProfileScreen extends BaseRoute {
  ProfileScreen({a, o}) : super(a: a, o: o, r: 'ProfileScreen');
  @override
  _ProfileScreenState createState() => new _ProfileScreenState();
}

class _ProfileScreenState extends BaseRouteState {
  late GlobalKey<ScaffoldState> _scaffoldKey;
  List<String> _openHourList = [];
  List<String> _closeHourList = [];
  List<String> _days = [];
  CurrentUser? _user = new CurrentUser();
  bool _isDataLoaded = false;

  _ProfileScreenState() : super();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: sc(
        Scaffold(
            bottomNavigationBar: _isDataLoaded
                ? Container(
                    margin: EdgeInsets.only(
                        top: 15, bottom: 15, left: 10, right: 10),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: TextButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => UpdateProfileScreen(
                                  _user!,
                                  a: widget.analytics,
                                  o: widget.observer,
                                )));
                      },
                      child: Text(
                          AppLocalizations.of(context)!.btn_update_profile),
                    ),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  )
                : SizedBox(),
            body: Stack(
              children: [
                Container(
                  height: 100,
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
                    child: _isDataLoaded
                        ? _user != null
                            ? SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 10, right: 10),
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        children: [
                                          Container(
                                              margin: EdgeInsets.only(
                                                  top: 30, bottom: 10),
                                              child: Text(
                                                '${_user?.owner_name}',
                                                style: Theme.of(context)
                                                    .primaryTextTheme
                                                    .displaySmall,
                                              )),
                                          Container(
                                            padding:
                                                const EdgeInsets.only(top: 05),
                                            child: CircleAvatar(
                                              radius: 38,
                                              child: _user?.vendor_logo == ""
                                                  ? Image.asset(
                                                      'assets/userImage.png')
                                                  : CachedNetworkImage(
                                                      imageUrl: global
                                                              .baseUrlForImage +
                                                          _user!.vendor_logo!,
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
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 10),
                                            child: Text(
                                              '${_user?.salon_name}',
                                              style: Theme.of(context)
                                                  .primaryTextTheme
                                                  .titleSmall,
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                RatingBar.builder(
                                                  initialRating:
                                                      _user?.rating != null
                                                          ? _user!.rating!
                                                          : 0,
                                                  minRating: 1,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemSize: 23,
                                                  glowColor: Theme.of(context)
                                                      .primaryColor,
                                                  itemBuilder: (context, _) =>
                                                      Icon(
                                                    Icons.star,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                  ignoreGestures: true,
                                                  updateOnDrag: false,
                                                  onRatingUpdate: (rating) {},
                                                ),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 3),
                                                  child: Text(
                                                    _user?.rating != null
                                                        ? '${_user?.rating}'
                                                        : '0',
                                                    style: Theme.of(context)
                                                        .primaryTextTheme
                                                        .titleMedium,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 10, right: 10, top: 17),
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .lbl_about,
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .titleSmall,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: Text(
                                              '${_user?.description}',
                                              style: Theme.of(context)
                                                  .primaryTextTheme
                                                  .titleMedium,
                                            ),
                                          ),
                                          _user!.weekly_time.length > 0
                                              ? Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 10),
                                                  child: Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .lbl_opening_hours,
                                                    style: Theme.of(context)
                                                        .primaryTextTheme
                                                        .titleSmall,
                                                  ),
                                                )
                                              : SizedBox(),
                                          _user!.weekly_time.length > 0
                                              ? Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.75,
                                                  child: ListView.builder(
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount: _user!
                                                          .weekly_time.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int i) {
                                                        return Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(top: 4),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                '${_days[i]}',
                                                                style: Theme.of(
                                                                        context)
                                                                    .primaryTextTheme
                                                                    .titleMedium,
                                                              ),
                                                              Text(
                                                                '${_openHourList[i]} - ${_closeHourList[i]}',
                                                                style: Theme.of(
                                                                        context)
                                                                    .primaryTextTheme
                                                                    .titleMedium,
                                                              )
                                                            ],
                                                          ),
                                                        );
                                                      }),
                                                )
                                              : SizedBox(),
                                          Padding(
                                            padding: EdgeInsets.only(top: 10),
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .lbl_address,
                                              style: Theme.of(context)
                                                  .primaryTextTheme
                                                  .titleSmall,
                                            ),
                                          ),
                                          ListTile(
                                            leading: Icon(
                                              Icons.location_on,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            title: Text(
                                              '${_user?.vendor_address}',
                                              style: Theme.of(context)
                                                  .primaryTextTheme
                                                  .titleMedium,
                                            ),
                                          ),
                                          _user?.review != null
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .lbl_reviews,
                                                      style: Theme.of(context)
                                                          .primaryTextTheme
                                                          .titleSmall,
                                                    ),
                                                    GestureDetector(
                                                        onTap: () {
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          ReviewScreen(
                                                                            _user!.review!,
                                                                            false,
                                                                            a: widget.analytics,
                                                                            o: widget.observer,
                                                                          )));
                                                        },
                                                        child: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .lbl_view_all,
                                                          style: Theme.of(
                                                                  context)
                                                              .primaryTextTheme
                                                              .titleSmall,
                                                        ))
                                                  ],
                                                )
                                              : SizedBox(),
                                          _user?.review != null
                                              ? Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 20.0,
                                                      left: 10,
                                                      top: 10),
                                                  child: SizedBox(
                                                      height: 130,
                                                      child: Align(
                                                          alignment: global
                                                                  .isRTL
                                                              ? Alignment
                                                                  .centerRight
                                                              : Alignment
                                                                  .centerLeft,
                                                          child: _review())),
                                                )
                                              : SizedBox(),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Center(
                                child: Text(AppLocalizations.of(context)!
                                    .txt_profile_will_be_shown_here),
                              )
                        : _shimmer())
              ],
            )),
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

  _getReview(int vendorId) async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper?.getPartnerReview(vendorId).then((result) {
          if (result != null) {
            if (result.status == "1") {
              _user?.review?.addAll(result.recordList);
            } else {
              _user?.review = null;
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print(
          "Exception - expertListScreen.dart - _getExperts():" + e.toString());
    }
  }

  _getUserProfile() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper!.getUserProfile(global.user.id!).then((result) {
          if (result != null) {
            if (result.status == "1") {
              _user = result.recordList;
            } else {
              _user = null;
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print(
          "Exception - profileScreen.dart - _getUserProfile():" + e.toString());
    }
  }

  _init() async {
    try {
      await _getUserProfile();
      await _getReview(global.user.id!);

      _isDataLoaded = true;
      final localizations = MaterialLocalizations.of(context);
      if (_user?.weekly_time != null) {
        for (var i = 0; i < _user!.weekly_time.length; i++) {
          _openHourList.add(localizations
              .formatTimeOfDay(_user!.weekly_time[i].open_hour!)
              .toString());
          _closeHourList.add(localizations
              .formatTimeOfDay(_user!.weekly_time[i].close_hour!)
              .toString());
          _days.add(_user!.weekly_time[i].days!);
        }
      }
      setState(() {});
    } catch (e) {
      print("Exception - profileScreen.dart - init():" + e.toString());
    }
  }

  Widget _review() {
    return _user!.review!.length > 0
        ? Padding(
            padding: EdgeInsets.only(left: 7, right: 7),
            child: ListView.builder(
                itemCount: _user!.review!.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: SizedBox(
                        width: 85,
                        height: 50,
                        child: _user?.review?[index].user != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  _user?.review?[index].user?.image != 'N/A'
                                      ? CachedNetworkImage(
                                          imageUrl: global.baseUrlForImage +
                                              _user!
                                                  .review![index].user!.image!,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  CircleAvatar(
                                                      radius: 35,
                                                      backgroundImage:
                                                          imageProvider),
                                          placeholder: (context, url) => Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              CircleAvatar(
                                            radius: 35,
                                            child: Icon(Icons.person),
                                          ),
                                        )
                                      : CircleAvatar(
                                          radius: 31,
                                          backgroundColor:
                                              Theme.of(context).primaryColor,
                                          child: CircleAvatar(
                                            radius: 30,
                                            backgroundColor: Colors.white,
                                            child: Icon(Icons.person),
                                          ),
                                        ),
                                  Text(
                                    _user!.review![index].user!.name!,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .titleSmall,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(),
                                    child: RatingBar.builder(
                                      initialRating:
                                          _user!.review![index].rating!,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 15,
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 1.0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      ignoreGestures: true,
                                      updateOnDrag: false,
                                      onRatingUpdate: (rating) {},
                                    ),
                                  )
                                ],
                              )
                            : SizedBox(),
                      ),
                    ),
                  );
                }),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Nothing is yet to see here',
                style: Theme.of(context).primaryTextTheme.titleMedium,
              ),
            ),
          );
  }

  Widget _shimmer() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Padding(
          padding: const EdgeInsets.only(top: 35),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 38,
                  child: Card(),
                ),
                SizedBox(
                  height: 10,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 85,
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
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
                                        margin: EdgeInsets.only(
                                            bottom: 5, left: 5, top: 5),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          100,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
