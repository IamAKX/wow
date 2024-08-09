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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAuVhAR3kp0IeFi_47uBCnU_1Duj9JOp9Y',
    appId: '1:102730474815:android:19859ecace9a3f49d6df8a',
    messagingSenderId: '102730474815',
    projectId: 'wowcross-d1bf1',
    storageBucket: 'wowcross-d1bf1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDegdAgzH5e30wD-6kWW--OYF_bLbo7BDE',
    appId: '1:102730474815:ios:46c84deb9ba72507d6df8a',
    messagingSenderId: '102730474815',
    projectId: 'wowcross-d1bf1',
    storageBucket: 'wowcross-d1bf1.appspot.com',
    androidClientId: '102730474815-j59kk8mfce2rla89tu4mg0sp0jl8pnbg.apps.googleusercontent.com',
    iosClientId: '102730474815-ve7fo2q41gvb81nq6m0vukop4i2vm1hq.apps.googleusercontent.com',
    iosBundleId: 'com.live.worldsocialintegrationapp',
  );

}