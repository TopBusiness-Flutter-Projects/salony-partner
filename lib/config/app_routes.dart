import 'package:app/screens/notificationScreen.dart';
import 'package:flutter/material.dart';

import '../screens/splashScreen.dart';

class Routes {
  static const String initialRoute = '/';
  static const String notificationScreen = '/notificationScreen';
}

class AppRoutes {
  static String route = '';

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
        );
      case Routes.notificationScreen:
        return MaterialPageRoute(
          builder: (context) => NotificationScreen(),
        );
      //suggestScreen

      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text('no route'),
        ),
      ),
    );
  }
}
