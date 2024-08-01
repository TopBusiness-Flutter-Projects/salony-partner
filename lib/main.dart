import 'dart:io';
import 'package:app/Theme/nativeTheme.dart';
import 'package:app/provider/local_provider.dart';
import 'package:app/screens/splashScreen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'config/app_routes.dart';
import 'firebase_options.dart';

///!test

final navigatorKey = GlobalKey<NavigatorState>();

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
AndroidNotificationChannel channel = const AndroidNotificationChannel(
  'high_importance_channel_for_partner',
  'High Importance Notifications for partner',
  description: 'This channel is used for important notifications.',
  importance: Importance.defaultImportance,
);
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    await Firebase.initializeApp();
    navigatorKey.currentState?.pushNamed(Routes.notificationScreen);
    print('Handling a background message ${message.messageId}');
  } catch (e) {
    print('Exception - main.dart - _firebaseMessagingBackgroundHandler(): ' +
        e.toString());
  }
}

FirebaseMessaging messaging = FirebaseMessaging.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(
    _firebaseMessagingBackgroundHandler,
  );
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('....................: ontap');
    navigatorKey.currentState?.pushNamed(Routes.notificationScreen);
  });

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  final String routeName = "main";

  @override
  void initState() {
    super.initState();
    var initialzationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/notificationdemo');
    var initializationSettingsIOS = DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
      android: initialzationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: (details) {
        navigatorKey.currentState?.pushNamed(Routes.notificationScreen);
      },
      onDidReceiveNotificationResponse: (details) {
        navigatorKey.currentState?.pushNamed(Routes.notificationScreen);
      },
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      try {
        print('Got a message while in the foreground!');
        print('Message data: ${message.data}');

        if (message.notification != null) {
          Future<String> _downloadAndSaveFile(
              String url, String fileName) async {
            final Directory directory =
                await getApplicationDocumentsDirectory();
            final String filePath = '${directory.path}/$fileName';
            final http.Response response = await http.get(Uri.parse(url));
            final File file = File(filePath);
            await file.writeAsBytes(response.bodyBytes);
            return filePath;
          }

          if (Platform.isAndroid) {
            final String bigPicturePath = await _downloadAndSaveFile(
                message.notification?.android?.imageUrl != null
                    ? message.notification!.android!.imageUrl!
                    : 'https://picsum.photos/200/300',
                'bigPicture');

            final BigPictureStyleInformation bigPictureStyleInformation =
                BigPictureStyleInformation(
              FilePathAndroidBitmap(bigPicturePath),
            );
            final AndroidNotificationDetails androidPlatformChannelSpecifics =
                AndroidNotificationDetails(channel.id, channel.name,
                    channelDescription: channel.description,
                    icon: '@mipmap/notificationdemo',
                    styleInformation: bigPictureStyleInformation);
            final AndroidNotificationDetails androidPlatformChannelSpecifics2 =
                AndroidNotificationDetails(channel.id, channel.name,
                    channelDescription: channel.description,
                    icon: '@mipmap/notificationdemo',
                    styleInformation:
                        BigTextStyleInformation(message.notification!.body!));
            final NotificationDetails platformChannelSpecifics =
                NotificationDetails(
                    android: message.notification?.android?.imageUrl != null
                        ? androidPlatformChannelSpecifics
                        : androidPlatformChannelSpecifics2);

            flutterLocalNotificationsPlugin.show(5, message.notification?.title,
                message.notification?.body, platformChannelSpecifics);
          } else if (Platform.isIOS) {
            final String bigPicturePath = await _downloadAndSaveFile(
                message.notification?.apple?.imageUrl != null
                    ? message.notification!.apple!.imageUrl!
                    : 'https://picsum.photos/200/300',
                'bigPicture.jpg');
            final DarwinNotificationDetails iOSPlatformChannelSpecifics =
                DarwinNotificationDetails(
                    attachments: <DarwinNotificationAttachment>[
                  DarwinNotificationAttachment(bigPicturePath)
                ]);
            final DarwinNotificationDetails iOSPlatformChannelSpecifics2 =
                DarwinNotificationDetails(badgeNumber: 1);
            final NotificationDetails notificationDetails = NotificationDetails(
              iOS: message.notification?.apple?.imageUrl != null
                  ? iOSPlatformChannelSpecifics
                  : iOSPlatformChannelSpecifics2,
            );
            await flutterLocalNotificationsPlugin.show(
                1,
                message.notification?.title,
                message.notification?.body,
                notificationDetails);
          }
        }
//! nav to notification screen
        // navigatorKey.currentState?.pushNamesd(Routes.notificationScreen);

        if (message.notification != null) {
          print(
              'Message also contained a notification: ${message.notification}');
        }
      } catch (e) {
        print('Exception - main.dart - onMessage.listen(): ' + e.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => LocaleProvider(),
        builder: (context, child) {
          final provider = Provider.of<LocaleProvider>(context);

          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'salony partner',
            navigatorObservers: <NavigatorObserver>[observer],
            theme: nativeTheme(),
            // locale: provider.locale,
            supportedLocales: [
              Locale("ar", "AE"),
              // OR Locale('ar', 'AE') OR Other RTL locales
            ],
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            textDirection: TextDirection.rtl,

            home: Builder(builder: (context) {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: SplashScreen(
                  a: analytics,
                  o: observer,
                ),
              );
            }),
            navigatorKey: navigatorKey,
            onGenerateRoute: AppRoutes.onGenerateRoute,
          );
        },
      );
}
