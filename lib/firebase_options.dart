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
    apiKey: 'AIzaSyACCC5Rlq2L-0eWt3pndu2dRE2u6vLL3pI',
    appId: '1:212960189699:web:9fb3663ebeaa0c0862dd36',
    messagingSenderId: '212960189699',
    projectId: 'mobile-shop-ad210',
    authDomain: 'mobile-shop-ad210.firebaseapp.com',
    storageBucket: 'mobile-shop-ad210.firebasestorage.app',
    measurementId: 'G-5RCK7DQMRL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC-ejBZdkhU3u7G0CoQf99SjkF80zq1VSo',
    appId: '1:212960189699:android:7f59ca4226b7608262dd36',
    messagingSenderId: '212960189699',
    projectId: 'mobile-shop-ad210',
    storageBucket: 'mobile-shop-ad210.firebasestorage.app',
  );
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'your-ios-api-key',
    appId: 'your-ios-app-id',
    messagingSenderId: 'your-sender-id',
    projectId: 'your-project-id',
    storageBucket: 'your-project-id.appspot.com',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'your-macos-api-key',
    appId: 'your-macos-app-id',
    messagingSenderId: 'your-sender-id',
    projectId: 'your-project-id',
    storageBucket: 'your-project-id.appspot.com',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyACCC5Rlq2L-0eWt3pndu2dRE2u6vLL3pI',
    appId: '1:212960189699:web:6bea68f9e7774ed262dd36',
    messagingSenderId: '212960189699',
    projectId: 'mobile-shop-ad210',
    authDomain: 'mobile-shop-ad210.firebaseapp.com',
    storageBucket: 'mobile-shop-ad210.firebasestorage.app',
    measurementId: 'G-LKXEPGXCL3',
  );
}
