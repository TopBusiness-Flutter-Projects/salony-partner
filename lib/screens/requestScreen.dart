import 'package:app/dialogs/userRequestAcceptDialog.dart';
import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/userRequestModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';

class RequestScreen extends BaseRoute {
  RequestScreen({a, o}) : super(a: a, o: o, r: 'RequestScreen');
  @override
  _RequestScreenState createState() => new _RequestScreenState();
}

class _RequestScreenState extends BaseRouteState {
  late GlobalKey<ScaffoldState> _scaffoldKey;
  List<UserRequest> _userRequest = [];
  bool _isDataLoaded = false;

  _RequestScreenState() : super();

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
                        Theme.of(context).primaryColor, BlendMode.screen),
                    child:
                        Image.asset('assets/banner.jpg', fit: BoxFit.cover))),
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
                        margin: EdgeInsets.only(top: 25, bottom: 10),
                        child: Text(
                          AppLocalizations.of(context)!.lbl_user_request,
                          style:
                              Theme.of(context).primaryTextTheme.displaySmall,
                        ),
                      ),
                      _isDataLoaded
                          ? _userRequest.length > 0
                              ? Flexible(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: _userRequest.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          // height: 85,
                                          child: Card(
                                            margin:
                                                const EdgeInsets.only(top: 8),
                                            child: ListTile(
                                              onTap: () {
                                                if (_userRequest[index]
                                                        .statustext ==
                                                    "Pending") {
                                                  _userRequestDialog(index);
                                                }
                                              },
                                              contentPadding: EdgeInsets.zero,
                                              leading: Padding(
                                                padding: global.isRTL
                                                    ? EdgeInsets.only(right: 5)
                                                    : EdgeInsets.only(left: 5),
                                                child: CircleAvatar(
                                                  child: _userRequest[index]
                                                              .user ==
                                                          null
                                                      ? CircleAvatar(
                                                          radius: 25,
                                                          backgroundImage:
                                                              AssetImage(
                                                                  'assets/userImage.png'))
                                                      : _userRequest[index]
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
                                                                  _userRequest[
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
                                              title: Padding(
                                                padding:
                                                    const EdgeInsets.only(),
                                                child: Text(
                                                  _userRequest[index].user !=
                                                          null
                                                      ? '${_userRequest[index].user?.name}'
                                                      : 'No Name',
                                                  // style: Theme.of(context)
                                                  //     .primaryTextTheme
                                                  //     .headlineSmall,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              subtitle: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0),
                                                child: Text(
                                                  '${_userRequest[index].service_date}\n${_userRequest[index].service_time}',
                                                  style: Theme.of(context)
                                                      .primaryTextTheme
                                                      .titleMedium,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                              ),
                                              horizontalTitleGap: 7,
                                              trailing: Container(
                                                width: 120,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    _userRequest[index]
                                                                .statustext ==
                                                            "Pending"
                                                        ? Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  _userRequestDialog(
                                                                      index);
                                                                },
                                                                child:
                                                                    Container(
                                                                        padding:
                                                                            EdgeInsets.all(
                                                                                4),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Theme.of(context).primaryColor,
                                                                          borderRadius:
                                                                              BorderRadius.all(
                                                                            Radius.circular(11),
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          'قبول',
                                                                          style: Theme.of(context)
                                                                              .primaryTextTheme
                                                                              .bodyLarge,
                                                                        )),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  _requestCancelConfirmationDialog(
                                                                      _userRequest[
                                                                              index]
                                                                          .id);
                                                                },
                                                                child:
                                                                    Container(
                                                                        margin: EdgeInsets.only(
                                                                            left:
                                                                                3,
                                                                            right:
                                                                                6),
                                                                        padding:
                                                                            EdgeInsets.all(
                                                                                4),
                                                                        decoration: BoxDecoration(
                                                                            color: Theme.of(context)
                                                                                .primaryColorLight,
                                                                            borderRadius: BorderRadius.all(Radius.circular(
                                                                                12))),
                                                                        child:
                                                                            Text(
                                                                          'إلغاء',
                                                                          style: Theme.of(context)
                                                                              .primaryTextTheme
                                                                              .bodyMedium,
                                                                        )),
                                                              )
                                                            ],
                                                          )
                                                        : GestureDetector(
                                                            onTap: () {
                                                              if (_userRequest[
                                                                          index]
                                                                      .statustext ==
                                                                  "Confirmed") {
                                                                _requestCompleteConfirmationDialog(
                                                                    _userRequest[
                                                                            index]
                                                                        .id);
                                                              }
                                                            },
                                                            child: Container(
                                                              height: 30,
                                                              width: 130,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 5,
                                                                      right: 5),
                                                              decoration: BoxDecoration(
                                                                  color: _userRequest[index].statustext == "Pending"
                                                                      ? Colors.amber
                                                                      : _userRequest[index].statustext == "Completed"
                                                                          ? Colors.green[600]
                                                                          : _userRequest[index].statustext == "Cancelled"
                                                                              ? Colors.grey
                                                                              : _userRequest[index].statustext == "Payment Failed"
                                                                                  ? Colors.red
                                                                                  : _userRequest[index].statustext == "Confirmed"
                                                                                      ? Colors.blue[600]
                                                                                      : Colors.red,
                                                                  borderRadius: BorderRadius.all(Radius.circular(5))),
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(4),
                                                              child: Center(
                                                                child: Text(
                                                                  '${_userRequest[index].statustext}',
                                                                  style: Theme.of(
                                                                          context)
                                                                      .primaryTextTheme
                                                                      .headlineSmall
                                                                      ?.copyWith(
                                                                          color: Theme.of(context)
                                                                              .primaryTextTheme
                                                                              .headlineSmall
                                                                              ?.color
                                                                              ?.withOpacity(0.8)),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                    Flexible(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 3,
                                                                left: 15,
                                                                right: 5),
                                                        child: Text(
                                                          '${global.currency.currency_sign ?? 'SAR'}${_userRequest[index].total_price}',
                                                          style: Theme.of(
                                                                  context)
                                                              .primaryTextTheme
                                                              .titleSmall,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
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
                                        .txt_user_request_will_be_shown_here),
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

  getUserRequest() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper?.getUserRequest(global.user.id!).then((result) {
          if (result != null) {
            if (result.status == "1") {
              _userRequest = result.recordList;
            } else {
              _userRequest = [];
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print(
          "Exception - requestScreen.dart - getUserRequest():" + e.toString());
    }
  }

  init() async {
    try {
      setState(() {
        _isDataLoaded = false;
      });
      await getUserRequest();
      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("Exception - requestScreen.dart - init():" + e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  _cancelRequest(int orderId) async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        showOnlyLoaderDialog();
        await apiHelper?.cancelRequest(orderId).then((result) {
          if (result.status == "1") {
            Navigator.of(context).pop();
            init();
          } else {
            Navigator.of(context).pop();
            showSnackBar(snackBarMessage: '${result.message}');
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print(
          "Exception - requestScreen.dart - _cancelRequest():" + e.toString());
    }
  }

  Future _requestCancelConfirmationDialog(orderId) async {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(
              AppLocalizations.of(context)!.lbl_cancel_request,
            ),
            content: Text(AppLocalizations.of(context)!
                .txt_confirmation_message_for_cancel_request),
            actions: [
              TextButton(
                child: Text(AppLocalizations.of(context)!.lbl_no),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: Text(AppLocalizations.of(context)!.lbl_yes),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await _cancelRequest(orderId);
                },
              )
            ],
          );
        });
  }

  Future _requestCompleteConfirmationDialog(orderId) async {
    try {
      showDialog(
          context: context,
          builder: (context) => UserRequestAcceptDialog(
                orderId,
                false,
                2,
                a: widget.analytics,
                o: widget.observer,
              ));
    } catch (e) {
      print(
          "Exception - requestScreen.dart - _requestCompleteConfirmationDialog():" +
              e.toString());
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

  _userRequestDialog(int _index) {
    try {
      showDialog(
          context: context,
          builder: (context) => UserRequestAcceptDialog(
                _userRequest[_index].id!,
                false,
                1,
                a: widget.analytics,
                o: widget.observer,
              ));
    } catch (e) {
      print(
          'Exception - requestScreen - _userRequestDialog(): ${e.toString()}');
    }
  }
}
