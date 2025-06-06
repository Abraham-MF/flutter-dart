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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDJAbln0Aot7j0Q4YNQvwG69_HAm3x4-SA',
    appId: '1:295137902989:web:075e795abe42de8cbf7dc4',
    messagingSenderId: '295137902989',
    projectId: 'flutter-movil1',
    authDomain: 'flutter-movil1.firebaseapp.com',
    storageBucket: 'flutter-movil1.firebasestorage.app',
    measurementId: 'G-W6K2G282N3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDqlOjTquNGlw0MXh5GelllDLwkyRHHcM8',
    appId: '1:295137902989:android:a17f00ad7059ee77bf7dc4',
    messagingSenderId: '295137902989',
    projectId: 'flutter-movil1',
    storageBucket: 'flutter-movil1.firebasestorage.app',
  );
}
