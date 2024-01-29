import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/serviceModel.dart';
import 'package:app/models/serviceVariantModel.dart';
import 'package:app/screens/addServiceVariantScreen.dart';
import 'package:app/screens/addServicesScreen.dart';
import 'package:app/widgets/bottomNavigationBar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';

class ServiceListScreen extends BaseRoute {
  final int? screenId;
  ServiceListScreen({a, o, this.screenId}) : super(a: a, o: o, r: 'ServiceListScreen');
  @override
  _ServiceListScreenState createState() => new _ServiceListScreenState(screenId: screenId);
}

class _ServiceListScreenState extends BaseRouteState {
  late GlobalKey<ScaffoldState> _scaffoldKey;
  List<Service> _serviceList = [];
  int? screenId;
  bool _isDataLoaded = false;

  _ServiceListScreenState({this.screenId}) : super();

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
                                        builder: (context) => BottomNavigationWidget(
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
                    height: MediaQuery.of(context).size.height - 190,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.only(top: 30, bottom: 10),
                              child: Text(
                                AppLocalizations.of(context)!.lbl_services,
                                style: Theme.of(context).primaryTextTheme.displaySmall,
                              )),
                          _isDataLoaded
                              ? _serviceList.length > 0
                                  ? Expanded(
                                      child: ListView.builder(
                                          itemCount: _serviceList.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                                              child: Card(
                                                child: ExpansionTile(
                                                  tilePadding: EdgeInsets.only(left: 2),
                                                  children: [_serviceVariant1(index)!],
                                                  trailing: Padding(
                                                    padding: const EdgeInsets.only(),
                                                    child: PopupMenuButton(itemBuilder: (BuildContext context) {
                                                      return [
                                                        PopupMenuItem(
                                                          padding: EdgeInsets.all(0),
                                                          child: new ListTile(
                                                            leading: Icon(
                                                              Icons.edit,
                                                              color: Theme.of(context).primaryColor,
                                                            ),
                                                            title: Text(
                                                              AppLocalizations.of(context)!.lbl_edit,
                                                              style: Theme.of(context).primaryTextTheme.titleSmall,
                                                            ),
                                                            onTap: () {
                                                              Navigator.of(context).pop();
                                                              Navigator.of(context).push(MaterialPageRoute(
                                                                  builder: (context) => AddServiceScreen(
                                                                        a: widget.analytics,
                                                                        o: widget.observer,
                                                                        service: _serviceList[index],
                                                                      )));
                                                            },
                                                          ),
                                                        ),
                                                        PopupMenuItem(
                                                          padding: EdgeInsets.all(0),
                                                          child: new ListTile(
                                                            leading: Icon(Icons.delete, color: Theme.of(context).primaryColor),
                                                            title: Text(AppLocalizations.of(context)!.lbl_delete, style: Theme.of(context).primaryTextTheme.titleSmall),
                                                            onTap: () {
                                                              Navigator.of(context).pop();
                                                              _deleteServiceConfirmationDialog(_serviceList[index].service_id, index);
                                                            },
                                                          ),
                                                        ),
                                                        PopupMenuItem(
                                                          padding: EdgeInsets.all(0),
                                                          child: new ListTile(
                                                            leading: Icon(
                                                              Icons.add,
                                                              color: Theme.of(context).primaryColor,
                                                            ),
                                                            title: Text(
                                                              AppLocalizations.of(context)!.lbl_add_service_variant,
                                                              style: Theme.of(context).primaryTextTheme.titleSmall,
                                                            ),
                                                            onTap: () {
                                                              Navigator.of(context).pop();
                                                              Navigator.of(context).push(MaterialPageRoute(
                                                                  builder: (context) => AddServiceVariantScreen(
                                                                        _serviceList[index].service_id!,
                                                                        a: widget.analytics,
                                                                        o: widget.observer,
                                                                      )));
                                                            },
                                                          ),
                                                        ),
                                                      ];
                                                    }),
                                                  ),
                                                  title: Container(
                                                    height: 70,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          margin: EdgeInsets.only(left: 3, right: 3),
                                                          child: ClipRRect(
                                                            borderRadius: BorderRadius.all(Radius.circular(7)),
                                                            child: Container(
                                                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15))),
                                                              height: 70,
                                                              width: 70,
                                                              child: _serviceList[index].service_image == 'N/A'
                                                                  ? Image.asset(
                                                                      'assets/sample_image.jpg',
                                                                      fit: BoxFit.cover,
                                                                    )
                                                                  : CachedNetworkImage(
                                                                      imageUrl: global.baseUrlForImage + _serviceList[index].service_image!,
                                                                      imageBuilder: (context, imageProvider) => Container(
                                                                        height: 70,
                                                                        decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: imageProvider)),
                                                                      ),
                                                                      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                                                    ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Padding(
                                                            padding: global.isRTL ? EdgeInsets.only(right: 15.0, top: 10) : EdgeInsets.only(left: 15.0, top: 10),
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Container(
                                                                    child: Text(
                                                                  '${_serviceList[index].service_name}',
                                                                  style: Theme.of(context).primaryTextTheme.titleSmall,
                                                                )),
                                                                Padding(
                                                                  padding: const EdgeInsets.only(top: 2),
                                                                  child: Text(
                                                                    _serviceList[index].createdAt != "N/A" ? '${_serviceList[index].createdAt}' : '',
                                                                    style: Theme.of(context).primaryTextTheme.titleMedium,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                    )
                                  : Center(
                                      child: Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3), child: Text(AppLocalizations.of(context)!.txt_service_will_shown_here)),
                                    )
                              : Expanded(child: _shimmer())
                        ],
                      ),
                    ))
              ],
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: _isDataLoaded
                ? Container(
              margin: EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 8),
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddServiceScreen(
                        a: widget.analytics,
                        o: widget.observer,
                      )));
                },
                child: Text(AppLocalizations.of(context)!.btn_add_new_service),
              ),
              decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.all(Radius.circular(10))),
            )
                : _shimmer1(),
          )
        ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  getService() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper?.getService(global.user.id!).then((result) {
          if (result != null) {
            if (result.status == "1") {
              _serviceList = result.recordList;
            } else {
              _serviceList = [];
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - serviceListScreen.dart - _getServices():" + e.toString());
    }
  }

  init() async {
    await getService();
    _isDataLoaded = true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  _deleteService(int serviceId, int _index) async {
    bool isConnected = await br.checkConnectivity();
    if (isConnected) {
      showOnlyLoaderDialog();
      await apiHelper?.deleteService(serviceId).then((result) {
        if (result.status == "1") {
          hideLoader();
          _serviceList.removeAt(_index);
          setState(() {});
        } else {
          hideLoader();
          showSnackBar(snackBarMessage: '${result.message}');
        }
      });
    } else {
      showNetworkErrorSnackBar(_scaffoldKey);
    }
  }

  Future _deleteServiceConfirmationDialog(serviceId, _index) async {
    try {
      
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text(
                AppLocalizations.of(context)!.lbl_delete_service,
              ),
              content: Text(AppLocalizations.of(context)!.txt_confirmation_message_for_delete_service),
              actions: [
                TextButton(
                  child: Text(AppLocalizations.of(context)!.lbl_no),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  child: Text(AppLocalizations.of(context)!.lbl_yes),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await _deleteService(serviceId, _index);
                  },
                )
              ],
            );
          });
    } catch (e) {
      print("Exception - serviceListScreen.dart - _deleteServiceConfirmationDialog():" + e.toString());
    }
  }

  _deleteServiceVariant(int varientId, int _index, int parentId) async {
    try {
      showOnlyLoaderDialog();
      await apiHelper?.deleteServiceVariant(varientId).then((result) {
        if (result.status == '1') {
          hideLoader();
          _serviceList[parentId].varients.removeAt(_index);

          setState(() {});
        } else {
          hideLoader();
          showSnackBar(snackBarMessage: '${result.message}');
        }
      });
    } catch (e) {
      print("Exception - serviceListScreen.dart - _deleteServiceVariant():" + e.toString());
    }
  }

  Future _deleteServiceVariantConfirmationDialog(varientId, _index, parentId) async {
    try {
      
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text(
                AppLocalizations.of(context)!.lbl_delete_service_variant,
              ),
              content: Text(AppLocalizations.of(context)!.txt_confirmation_message_for_delete_service_variant),
              actions: [
                TextButton(
                  child: Text(AppLocalizations.of(context)!.lbl_no),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  child: Text(AppLocalizations.of(context)!.lbl_yes),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await _deleteServiceVariant(varientId, _index, parentId);
                  },
                )
              ],
            );
          });
    } catch (e) {
      print("Exception - serviceListScreen.dart - _deleteServiceVariantConfirmationDialog():" + e.toString());
    }
  }

  Widget? _serviceVariant1(int index) {
    try {
      List<ServiceVariant> _serviceVariant = [];
      _serviceVariant = _serviceList[index].varients;

      return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _serviceVariant.length,
          itemBuilder: (BuildContext context, int i) {
            return ListTile(
                trailing: Container(
                  height: 40,
                  width: 100,
                  child: Row(
                    children: [
                      Container(
                        height: 30,
                        width: 70,
                        decoration: BoxDecoration(border: Border.all(color: Theme.of(context).primaryColor, width: 1)),
                        padding: EdgeInsets.only(left: 5, right: 2, top: 2, bottom: 2),
                        child: Center(
                            child: Text(
                          '${global.currency.currency_sign} ${_serviceVariant[i].price}',
                          overflow: TextOverflow.ellipsis,
                        )),
                      ),
                      Container(
                        width: 30,
                        padding: const EdgeInsets.only(),
                        child: PopupMenuButton(itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem(
                              padding: EdgeInsets.all(0),
                              child: new ListTile(
                                leading: Icon(
                                  Icons.edit,
                                  color: Theme.of(context).primaryColor,
                                ),
                                title: Text(
                                  AppLocalizations.of(context)!.lbl_edit,
                                  style: Theme.of(context).primaryTextTheme.titleSmall,
                                ),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => AddServiceVariantScreen(
                                            _serviceVariant[i].service_id!,
                                            a: widget.analytics,
                                            o: widget.observer,
                                            serviceVariant: _serviceVariant[i],
                                          )));
                                },
                              ),
                            ),
                            PopupMenuItem(
                              padding: EdgeInsets.all(0),
                              child: new ListTile(
                                leading: Icon(Icons.delete, color: Theme.of(context).primaryColor),
                                title: Text(AppLocalizations.of(context)!.lbl_delete, style: Theme.of(context).primaryTextTheme.titleSmall),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  _deleteServiceVariantConfirmationDialog(_serviceVariant[i].varient_id, i, index);
                                },
                              ),
                            ),
                          ];
                        }),
                      ),
                    ],
                  ),
                ),
                leading: Container(
                  margin: EdgeInsets.only(right: 6),
                  width: 35,
                  child: Text(
                    "${i + 1}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                title: Text('${_serviceVariant[i].varient}'),
                subtitle: Text('${_serviceVariant[i].time}' + " " + AppLocalizations.of(context)!.lbl_min));
          });
    } catch (e) {
      print("Exception - serviceListScreen.dart - _serviceVariant1():" + e.toString());
      return null;
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
                    Container(
                      height: 90,
                      width: 80,
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
                                margin: EdgeInsets.only(bottom: 5, left: 5, top: 5),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 30,
                              child: Card(margin: EdgeInsets.only(bottom: 5, left: 5, top: 5)),
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

  Widget _shimmer1() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Card(),
          )),
    );
  }
}
