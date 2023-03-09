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
    apiKey: 'AIzaSyDRNJX4L9temMua7ZQvqpUYg61B5d3ZgpM',
    appId: '1:597337847222:web:911bcef049e2fc2f0ebd17',
    messagingSenderId: '597337847222',
    projectId: 'kostapp-4e329',
    authDomain: 'kostapp-4e329.firebaseapp.com',
    storageBucket: 'kostapp-4e329.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBNdSEi4pEhwdL9F1QTWDwgFeH1XtB1wuc',
    appId: '1:597337847222:android:2d5b2d392eb39ffd0ebd17',
    messagingSenderId: '597337847222',
    projectId: 'kostapp-4e329',
    storageBucket: 'kostapp-4e329.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDnzRYyB4uBZDctMTzxEddBMm3i6WfZNoc',
    appId: '1:597337847222:ios:5c3c0f2ca74307160ebd17',
    messagingSenderId: '597337847222',
    projectId: 'kostapp-4e329',
    storageBucket: 'kostapp-4e329.appspot.com',
    iosClientId: '597337847222-n44i0b2e629vfsj8eu6cipr76u4r8hhf.apps.googleusercontent.com',
    iosBundleId: 'com.example.adminKos',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDnzRYyB4uBZDctMTzxEddBMm3i6WfZNoc',
    appId: '1:597337847222:ios:5c3c0f2ca74307160ebd17',
    messagingSenderId: '597337847222',
    projectId: 'kostapp-4e329',
    storageBucket: 'kostapp-4e329.appspot.com',
    iosClientId: '597337847222-n44i0b2e629vfsj8eu6cipr76u4r8hhf.apps.googleusercontent.com',
    iosBundleId: 'com.example.adminKos',
  );
}
