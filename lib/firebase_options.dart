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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBAswooOMuJXHJ1mfUB7pW44zv2F_K2XQI',
    appId: '1:40028629531:web:ca4adda5fcf5deef2626be',
    messagingSenderId: '40028629531',
    projectId: 'mauanews-d80ea',
    authDomain: 'mauanews-d80ea.firebaseapp.com',
    storageBucket: 'mauanews-d80ea.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBHC0TMILWG5s5QlfqNJKdgBNw6_YeqkZI',
    appId: '1:40028629531:android:17688784c73499792626be',
    messagingSenderId: '40028629531',
    projectId: 'mauanews-d80ea',
    storageBucket: 'mauanews-d80ea.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDQatSD1RWomAbEy7x-fmh4t5vIglqkzmc',
    appId: '1:40028629531:ios:60927857ee6753fa2626be',
    messagingSenderId: '40028629531',
    projectId: 'mauanews-d80ea',
    storageBucket: 'mauanews-d80ea.appspot.com',
    iosBundleId: 'com.example.mauanews',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDQatSD1RWomAbEy7x-fmh4t5vIglqkzmc',
    appId: '1:40028629531:ios:335328f089f27b7d2626be',
    messagingSenderId: '40028629531',
    projectId: 'mauanews-d80ea',
    storageBucket: 'mauanews-d80ea.appspot.com',
    iosBundleId: 'com.example.mauanews.RunnerTests',
  );
}

