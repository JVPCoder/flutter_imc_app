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
        return macos;
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
    apiKey: 'AIzaSyD5GHfB7dQVaoLiUt-9wHCBoXm-ZirQ6eg',
    appId: '1:972157100006:web:496bd0d0e6c502c039c027',
    messagingSenderId: '972157100006',
    projectId: 'health-calc-48c30',
    authDomain: 'health-calc-48c30.firebaseapp.com',
    storageBucket: 'health-calc-48c30.firebasestorage.app',
    measurementId: 'G-NPRNPN6DEZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCF7_lGzSSix3zgiqw2ge7ieOMUYtgbLTo',
    appId: '1:972157100006:android:b873bf0103f1948a39c027',
    messagingSenderId: '972157100006',
    projectId: 'health-calc-48c30',
    storageBucket: 'health-calc-48c30.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBhfA-F_m8B9DR791gxqb_qRArvX4dYEBo',
    appId: '1:972157100006:ios:c7f18d593483714939c027',
    messagingSenderId: '972157100006',
    projectId: 'health-calc-48c30',
    storageBucket: 'health-calc-48c30.firebasestorage.app',
    iosBundleId: 'com.example.flutterImcApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBhfA-F_m8B9DR791gxqb_qRArvX4dYEBo',
    appId: '1:972157100006:ios:c7f18d593483714939c027',
    messagingSenderId: '972157100006',
    projectId: 'health-calc-48c30',
    storageBucket: 'health-calc-48c30.firebasestorage.app',
    iosBundleId: 'com.example.flutterImcApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD5GHfB7dQVaoLiUt-9wHCBoXm-ZirQ6eg',
    appId: '1:972157100006:web:1a262778ee4186f139c027',
    messagingSenderId: '972157100006',
    projectId: 'health-calc-48c30',
    authDomain: 'health-calc-48c30.firebaseapp.com',
    storageBucket: 'health-calc-48c30.firebasestorage.app',
    measurementId: 'G-CDHBZEDZBS',
  );

}