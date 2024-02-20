import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/privacyAndPolicyModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class PrivacyAndPolicyScreen extends BaseRoute {
  PrivacyAndPolicyScreen({a, o})
      : super(a: a, o: o, r: 'PrivacyAndPolicyScreen');

  @override
  _PrivacyAndPolicyScreenState createState() =>
      new _PrivacyAndPolicyScreenState();
}

class _PrivacyAndPolicyScreenState extends BaseRouteState {
  PrivacyAndPolicy? _privacyAndPolicy = new PrivacyAndPolicy();
  late GlobalKey<ScaffoldState> _scaffoldKey;

  bool _isDataLoaded = false;

  _PrivacyAndPolicyScreenState() : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15, left: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.keyboard_arrow_left_outlined,
                            color: Colors.black,
                          ),
                          Text(
                            'Back',
                            style:
                                TextStyle(color: Colors.black, fontSize: 17.5),
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
                child: SingleChildScrollView(
                  child: _isDataLoaded
                      ? Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  Container(
                                      margin:
                                          EdgeInsets.only(top: 30, bottom: 10),
                                      child: Text('Privacy & Policy',
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .displaySmall)),
                                ],
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: Html(
                                data: "${_privacyAndPolicy?.privacyAndPolicy}",
                              ),
                            )
                          ],
                        )
                      : Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 3),
                            child: CircularProgressIndicator(),
                          ),
                        ),
                ))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  getPrivacyAndPolicy() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper?.getPrivacyAndPolicy().then((result) {
          if (result.status == "1") {
            _privacyAndPolicy = result.recordList;
          } else {
            _privacyAndPolicy = null;
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - privacyAndPolicyScreen.dart - getPrivacyAndPolicy():" +
          e.toString());
    }
  }

  init() async {
    try {
      await getPrivacyAndPolicy();
      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("Exception - privacyAndPolicyScreen.dart - init():" + e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }
}
