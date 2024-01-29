import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/galleryModel.dart';
import 'package:app/screens/addGalleryScreen.dart';
import 'package:app/widgets/bottomNavigationBar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';

class GalleryListScreen extends BaseRoute {
  final int? screenId;
  GalleryListScreen({a, o, this.screenId}) : super(a: a, o: o, r: 'GalleryListScreen');
  @override
  _GalleryListScreenState createState() => new _GalleryListScreenState(screenId: screenId);
}

class _GalleryListScreenState extends BaseRouteState {
  late GlobalKey<ScaffoldState> _scaffoldKey;
  List<Gallery> _galleryList = [];
  int? screenId;
  bool _isDataLoaded = false;

  _GalleryListScreenState({this.screenId}) : super();

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
                                AppLocalizations.of(context)!.lbl_gallery,
                                style: Theme.of(context).primaryTextTheme.displaySmall,
                              )),
                          _isDataLoaded
                              ? _galleryList.length > 0
                                  ? Expanded(
                                      child: GridView.count(
                                          crossAxisSpacing: 7,
                                          mainAxisSpacing: 7,
                                          crossAxisCount: 2,
                                          children: List.generate(_galleryList.length, (index) {
                                            return Stack(alignment: Alignment.topRight, children: [
                                              Container(
                                                  height: 200,
                                                  width: MediaQuery.of(context).size.width / 2,
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                                    child: CachedNetworkImage(
                                                      imageUrl: global.baseUrlForImage + _galleryList[index].image!,
                                                      imageBuilder: (context, imageProvider) => Container(
                                                        height: 90,
                                                        decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: imageProvider)),
                                                      ),
                                                      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                                    ),
                                                  )),
                                              IconButton(
                                                onPressed: () {
                                                  _deleteGalleryConfirmationDialog(_galleryList[index].id, index);
                                                },
                                                icon: Icon(
                                                  Icons.delete,
                                                  size: 30,
                                                ),
                                                color: Colors.red,
                                              )
                                            ]);
                                          })),
                                    )
                                  : Center(
                                      child: Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3), child: Text(AppLocalizations.of(context)!.txt_gallery_will_shown_here)),
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
                      builder: (context) => AddGalleryScreen(
                        a: widget.analytics,
                        o: widget.observer,
                      )));
                },
                child: Text(
                  AppLocalizations.of(context)!.btn_add_new_gallery,
                ),
              ),
              decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.all(Radius.circular(10))),
            )
                : _shimmer1(),
          ),
        ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  getGallery() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper?.getGallery(global.user.id!).then((result) {
          if (result != null) {
            if (result.status == "1") {
              _galleryList = result.recordList;
            } else {
              _galleryList = [];
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - galleryListScreen.dart - _getGallerys():" + e.toString());
    }
  }

  init() async {
    try {
      await getGallery();
      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("Exception - galleryListScreen.dart - init():" + e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  _deleteGallery(int galleryId, int _index) async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        showOnlyLoaderDialog();
        await apiHelper?.deleteGallery(galleryId).then((result) {
          if (result.status == "1") {
            hideLoader();
            _galleryList.removeAt(_index);
            setState(() {});
          } else {
            hideLoader();
            showSnackBar(snackBarMessage: '${result.message}');
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - galleryListScreen.dart - _deleteGallery():" + e.toString());
    }
  }

  Future _deleteGalleryConfirmationDialog(galleryId, _index) async {
    try {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text(
                AppLocalizations.of(context)!.lbl_delete_gallery,
              ),
              content: Text(AppLocalizations.of(context)!.txt_confirmation_message_for_delete_gallery),
              actions: [
                TextButton(
                  child: Text(AppLocalizations.of(context)!.lbl_no),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  child: Text(AppLocalizations.of(context)!.lbl_yes),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await _deleteGallery(galleryId, _index);
                  },
                )
              ],
            );
          });
    } catch (e) {
      print("Exception - galleryListScreen.dart - _deleteGalleryConfirmationDialog():" + e.toString());
    }
  }

  Widget _shimmer() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 400,
                width: MediaQuery.of(context).size.width,
                child: GridView.count(
                    crossAxisSpacing: 7,
                    mainAxisSpacing: 7,
                    crossAxisCount: 2,
                    children: List.generate(6, (index) {
                      return Stack(alignment: Alignment.topRight, children: [
                        Container(height: 200, width: MediaQuery.of(context).size.width / 2, child: Card()),
                      ]);
                    })),
              ),
            ],
          ),
        ),
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
