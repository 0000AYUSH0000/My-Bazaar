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
    apiKey: 'AIzaSyAfBd0zjPaw6h4h2aXQYQ0J3K0QmYwiLjw',
    appId: '1:323736325571:web:f16ea615b73bb84189c176',
    messagingSenderId: '323736325571',
    projectId: 'myfirstfirebase-fccd1',
    authDomain: 'myfirstfirebase-fccd1.firebaseapp.com',
    storageBucket: 'myfirstfirebase-fccd1.appspot.com',
    measurementId: 'G-KCPBKB8TBH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyADTo7n_2nAw2Z3cMQuMvlmTuLqn5auGdY',
    appId: '1:323736325571:android:436dcc3787069b0289c176',
    messagingSenderId: '323736325571',
    projectId: 'myfirstfirebase-fccd1',
    storageBucket: 'myfirstfirebase-fccd1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDZNJeiD1kz0FoMddGaYODiXe3luhuoSIg',
    appId: '1:323736325571:ios:357477f20d678ab089c176',
    messagingSenderId: '323736325571',
    projectId: 'myfirstfirebase-fccd1',
    storageBucket: 'myfirstfirebase-fccd1.appspot.com',
    iosBundleId: 'com.example.loginSignup',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDZNJeiD1kz0FoMddGaYODiXe3luhuoSIg',
    appId: '1:323736325571:ios:357477f20d678ab089c176',
    messagingSenderId: '323736325571',
    projectId: 'myfirstfirebase-fccd1',
    storageBucket: 'myfirstfirebase-fccd1.appspot.com',
    iosBundleId: 'com.example.loginSignup',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAfBd0zjPaw6h4h2aXQYQ0J3K0QmYwiLjw',
    appId: '1:323736325571:web:509b125e86be03c389c176',
    messagingSenderId: '323736325571',
    projectId: 'myfirstfirebase-fccd1',
    authDomain: 'myfirstfirebase-fccd1.firebaseapp.com',
    storageBucket: 'myfirstfirebase-fccd1.appspot.com',
    measurementId: 'G-NF86GPKR7V',
  );
}
