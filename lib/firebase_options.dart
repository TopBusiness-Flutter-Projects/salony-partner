// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDz7LU36T5tJw2bx-o6zUIyKf0n4Jr2Atg',
    appId: '1:559354982479:web:9e127e862e7c80723a7a3a',
    messagingSenderId: '559354982479',
    projectId: 'salonyuser',
    authDomain: 'salonyuser.firebaseapp.com',
    storageBucket: 'salonyuser.appspot.com',
    measurementId: 'G-PHR67W99CQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCI-G6YMnxkYZaRZHcG_7I7ixbz_Z9qcQI',
    appId: '1:559354982479:android:d3acba07e792e2533a7a3a',
    messagingSenderId: '559354982479',
    projectId: 'salonyuser',
    storageBucket: 'salonyuser.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC7tQD9d-eleQrDzXGVe7Nq_DEjAx87SmU',
    appId: '1:559354982479:ios:4f394f0014d109533a7a3a',
    messagingSenderId: '559354982479',
    projectId: 'salonyuser',
    storageBucket: 'salonyuser.appspot.com',
    iosBundleId: 'com.topbusiness.salonypartner',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDz7LU36T5tJw2bx-o6zUIyKf0n4Jr2Atg',
    appId: '1:559354982479:web:f5169ba6d46145233a7a3a',
    messagingSenderId: '559354982479',
    projectId: 'salonyuser',
    authDomain: 'salonyuser.firebaseapp.com',
    storageBucket: 'salonyuser.appspot.com',
    measurementId: 'G-5NF78KZVN4',
  );
}
