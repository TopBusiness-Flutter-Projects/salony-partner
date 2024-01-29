import 'dart:io';

import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/screens/appointmentHistoryScreen.dart';
import 'package:app/screens/homeScreen.dart';
import 'package:app/screens/profileScreen.dart';
import 'package:app/screens/requestScreen.dart';
import 'package:app/widgets/drawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rolling_nav_bar/rolling_nav_bar.dart';

class BottomNavigationWidget extends BaseRoute {
  BottomNavigationWidget({a, o})
      : super(a: a, o: o, r: 'BottomNavigationWidget');
  @override
  _BottomNavigationWidgetState createState() =>
      new _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends BaseRouteState {
  int _selectedIndex = 0;
  List<Widget> _children() => [
        HomeScreen(a: widget.analytics, o: widget.observer),
        RequestScreen(a: widget.analytics, o: widget.observer),
        AppointmentHistoryScreen(a: widget.analytics, o: widget.observer),
        ProfileScreen(a: widget.analytics, o: widget.observer)
      ];
  bool isloading = true;

  _BottomNavigationWidgetState() : super();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        exitAppDialog();
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: Container(
          height: 61,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(bottom: Platform.isIOS ? 16 : 0),
          child: RollingNavBar.iconData(
            iconSize: 25,
            iconText: [
              Text(
                AppLocalizations.of(context)!.lbl_home,
                style: TextStyle(fontSize: 10),
              ),
              Text(
                AppLocalizations.of(context)!.lbl_request,
                style: Theme.of(context).primaryTextTheme.bodyMedium,
              ),
              Text(
                AppLocalizations.of(context)!.lbl_appointment_history,
                textAlign: TextAlign.center,
                style: Theme.of(context).primaryTextTheme.bodyMedium,
              ),
              Text(
                AppLocalizations.of(context)!.lbl_profile,
                style: Theme.of(context).primaryTextTheme.bodyMedium,
              )
            ],
            iconData: [
              Icons.home,
              Icons.message,
              Icons.menu_book,
              Icons.person
            ],
            animationCurve: Curves.easeOut,
            baseAnimationSpeed: 300,
            animationType: AnimationType.roll,
            indicatorColors: <Color>[Theme.of(context).primaryColor],
            onTap: _onItemTap,
          ),
        ),
        drawer: _selectedIndex == 0
            ? DrawerWidget(
                a: widget.analytics,
                o: widget.observer,
              )
            : null,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark,
            child: sc(_children().elementAt(_selectedIndex))),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  _onItemTap(int index) {
    _selectedIndex = index;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }
}
