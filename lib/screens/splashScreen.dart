import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/partnerUserModel.dart';
import 'package:app/provider/local_provider.dart';
import 'package:app/screens/introScreen.dart';
import 'package:app/widgets/bottomNavigationBar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class SplashScreen extends BaseRoute {
  SplashScreen({a, o}) : super(a: a, o: o, r: 'SplashScreen');
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends BaseRouteState {
  bool isloading = true;
  late GlobalKey<ScaffoldState> _scaffoldKey;

  _SplashScreenState() : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/splash.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 1.8,
                  ),
                  Image.asset(
                    'assets/appicon_120x120.png',
                    width: MediaQuery.of(context).size.width / 1.8,
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(top: 20),
                  //   child: Text(
                  //     AppLocalizations.of(context)!.lbl_gofresha,
                  //     style: TextStyle(color: Colors.white, fontSize: 22),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
            child: Align(
              alignment: Alignment.bottomCenter,
              // child: RichText(
              //     textAlign: TextAlign.center,
              //     text: TextSpan(
              //         style: TextStyle(color: Colors.white, fontSize: 18),
              //         children: [
              //           TextSpan(
              //               text:
              //                   AppLocalizations.of(context)!.txt_welcome_to),
              //           TextSpan(
              //             text: AppLocalizations.of(context)!.lbl_gofresha,
              //             style: TextStyle(
              //                 color: Theme.of(context).primaryColor,
              //                 fontSize: 18),
              //           ),
              //           TextSpan(
              //               text: AppLocalizations.of(context)!.txt_app,
              //               style:
              //                   TextStyle(color: Colors.white, fontSize: 18))
              //         ])),
              child: Image.asset('assets/top.png',
                  width: MediaQuery.of(context).size.width / 2.5),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _init();
  }

  _getCurrency() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper?.getCurrency().then((result) {
          if (result != null) {
            if (result.status == "1") {
              global.currency = result.recordList;

              setState(() {});
            } else {}
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - splashScreen.dart - _getCurrency(): " + e.toString());
    }
  }

  void _init() async {
    try {
      await br.getSharedPreferences();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final provider = Provider.of<LocaleProvider>(context, listen: false);
        if (global.sp.getString("selectedLang") == null) {
          var locale = provider.locale ?? Locale('en');
          global.languageCode = locale.languageCode;
        } else {
          global.languageCode = global.sp.getString("selectedLang");
          provider.setLocale(Locale(global.languageCode!));
        }
        if (global.rtlLanguageCodeLList.contains(global.languageCode)) {
          global.isRTL = true;
        } else {
          global.isRTL = false;
        }
      });

      await getToke();
      var duration = Duration(seconds: 3);
      Timer(duration, () async {


        // global.appDeviceId = await FirebaseMessaging.instance.getToken();
        await _getCurrency();
        bool isConnected = await br.checkConnectivity();
        if (isConnected) {
          if (global.sp.getString('currentUser') != null) {
            global.user = CurrentUser.fromJson(
                json.decode(global.sp.getString("currentUser")!));

            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BottomNavigationWidget(
                      a: widget.analytics,
                      o: widget.observer,
                    )));
          } else {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => IntroScreen(
                      a: widget.analytics,
                      o: widget.observer,
                    )));
          }
        } else {
          showNetworkErrorSnackBar(_scaffoldKey);
        }
      });
    } catch (e) {
      print("Exception - splashScreen.dart - init():" + e.toString());
    }
  }
  
  
  getToke()async{

  messaging.getToken().then((value) {
    print('ssssssssssss : $value');
    global.appDeviceId =value;
    


  }).onError((error, stackTrace) {
    print('ssssssssssss${error.toString()}');

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));


  });
      // Handle the case when permission is not granted
    
  }
}
