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
    apiKey: 'AIzaSyCZbxN19kEbf2D84cpEODxEVh3pKjTmtdA',
    appId: '1:659778050561:web:6c26f4ee140120ec0abe00',
    messagingSenderId: '659778050561',
    projectId: 'hidayah-8007a',
    authDomain: 'hidayah-8007a.firebaseapp.com',
    storageBucket: 'hidayah-8007a.firebasestorage.app',
    measurementId: 'G-WCVQ3QTMBG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBekM9w--Xyz9xZsVPCXBX102LOOQjemTY',
    appId: '1:659778050561:android:3f2915eec6e240030abe00',
    messagingSenderId: '659778050561',
    projectId: 'hidayah-8007a',
    storageBucket: 'hidayah-8007a.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDrWrY6Xf01rJH_C-BOCjJBqH9RNbfADNc',
    appId: '1:659778050561:ios:6b807b4d080e721e0abe00',
    messagingSenderId: '659778050561',
    projectId: 'hidayah-8007a',
    storageBucket: 'hidayah-8007a.firebasestorage.app',
    iosBundleId: 'com.example.primajasa',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDrWrY6Xf01rJH_C-BOCjJBqH9RNbfADNc',
    appId: '1:659778050561:ios:6b807b4d080e721e0abe00',
    messagingSenderId: '659778050561',
    projectId: 'hidayah-8007a',
    storageBucket: 'hidayah-8007a.firebasestorage.app',
    iosBundleId: 'com.example.primajasa',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCZbxN19kEbf2D84cpEODxEVh3pKjTmtdA',
    appId: '1:659778050561:web:e456ea7c8f3bd3910abe00',
    messagingSenderId: '659778050561',
    projectId: 'hidayah-8007a',
    authDomain: 'hidayah-8007a.firebaseapp.com',
    storageBucket: 'hidayah-8007a.firebasestorage.app',
    measurementId: 'G-0JCRED4QFF',
  );
}
