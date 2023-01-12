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
    apiKey: 'AIzaSyDcjjdK3fjX8y7qg9vT_iZWV2OVKDVRATE',
    appId: '1:10593468501:web:26f09671cea986ac3d54dc',
    messagingSenderId: '10593468501',
    projectId: 'rem-workshop-system',
    authDomain: 'rem-workshop-system.firebaseapp.com',
    storageBucket: 'rem-workshop-system.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA61iMIkybzvCrxByNhikpiudQfEFKFGxc',
    appId: '1:10593468501:android:81a5fb3863a638963d54dc',
    messagingSenderId: '10593468501',
    projectId: 'rem-workshop-system',
    storageBucket: 'rem-workshop-system.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCYdV7Fp8B2m5Gakn5N31vhZWllRZ_5_is',
    appId: '1:10593468501:ios:4ce5c500cbc866843d54dc',
    messagingSenderId: '10593468501',
    projectId: 'rem-workshop-system',
    storageBucket: 'rem-workshop-system.appspot.com',
    iosClientId: '10593468501-mnkbb6afhdrvrnoh5523ns2iddd7h50a.apps.googleusercontent.com',
    iosBundleId: 'com.example.popperMobile',
  );
}