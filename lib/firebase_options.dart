// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    apiKey: 'AIzaSyCN92L65nrqtjOUYCFoBsURlow9MstVrpI',
    appId: '1:647001866395:web:f981e6c0e5d51aad47863e',
    messagingSenderId: '647001866395',
    projectId: 'budgetapp-ee73a',
    authDomain: 'budgetapp-ee73a.firebaseapp.com',
    storageBucket: 'budgetapp-ee73a.appspot.com',
    measurementId: 'G-HS3JC8EZLG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBCLK6RogFKNemg4Vzn4BY9rly_ig6B9Rk',
    appId: '1:647001866395:android:df743485214ca3de47863e',
    messagingSenderId: '647001866395',
    projectId: 'budgetapp-ee73a',
    storageBucket: 'budgetapp-ee73a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDMMHJsNTy0Xqi-dDY7bHZ9YXRUPO9ccCI',
    appId: '1:357935783557:ios:c30df50b09ca6b1c7ed3ec',
    messagingSenderId: '357935783557',
    projectId: 'budget-app-89e2f',
    storageBucket: 'budget-app-89e2f.appspot.com',
    iosClientId: '357935783557-oh15arfgp9ls3bp7ufv0m954r1igevdt.apps.googleusercontent.com',
    iosBundleId: 'com.codingliquids.budgetAppStarting',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAMdRHJ1ep-DOdEglGzj63RLIRO-9S3XU8',
    appId: '1:647001866395:ios:7527d33aeec1c9d947863e',
    messagingSenderId: '647001866395',
    projectId: 'budgetapp-ee73a',
    storageBucket: 'budgetapp-ee73a.appspot.com',
    iosBundleId: 'com.example.bankManagementApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCN92L65nrqtjOUYCFoBsURlow9MstVrpI',
    appId: '1:647001866395:web:fd2a2d90febc133f47863e',
    messagingSenderId: '647001866395',
    projectId: 'budgetapp-ee73a',
    authDomain: 'budgetapp-ee73a.firebaseapp.com',
    storageBucket: 'budgetapp-ee73a.appspot.com',
    measurementId: 'G-BC3V0GR14S',
  );

}