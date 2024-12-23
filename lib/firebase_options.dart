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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAa-k35tXmEJC2JAxSLVxBxz6bpOVZkas0',
    appId: '1:487408505500:android:71b84288dc18b292bb9359',
    messagingSenderId: '487408505500',
    projectId: 'quiz-app-11d6c',
    storageBucket: 'quiz-app-11d6c.firebasestorage.app',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBJxt0GKwc1LmUvqraM3QDR5GKwwV6jfqM',
    appId: '1:487408505500:web:f06d060abdd08223bb9359',
    messagingSenderId: '487408505500',
    projectId: 'quiz-app-11d6c',
    authDomain: 'quiz-app-11d6c.firebaseapp.com',
    storageBucket: 'quiz-app-11d6c.firebasestorage.app',
    measurementId: 'G-XRYR83S2EJ',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDYz0L8VPTVQK5Nmsre6eEPACGM4QNK8Qw',
    appId: '1:487408505500:ios:9a1e73d028f2b69ebb9359',
    messagingSenderId: '487408505500',
    projectId: 'quiz-app-11d6c',
    storageBucket: 'quiz-app-11d6c.firebasestorage.app',
    iosBundleId: 'com.zerocorp.questionapp',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDYz0L8VPTVQK5Nmsre6eEPACGM4QNK8Qw',
    appId: '1:487408505500:ios:9a1e73d028f2b69ebb9359',
    messagingSenderId: '487408505500',
    projectId: 'quiz-app-11d6c',
    storageBucket: 'quiz-app-11d6c.firebasestorage.app',
    iosBundleId: 'com.zerocorp.questionapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBJxt0GKwc1LmUvqraM3QDR5GKwwV6jfqM',
    appId: '1:487408505500:web:6d8babf9720d5b02bb9359',
    messagingSenderId: '487408505500',
    projectId: 'quiz-app-11d6c',
    authDomain: 'quiz-app-11d6c.firebaseapp.com',
    storageBucket: 'quiz-app-11d6c.firebasestorage.app',
    measurementId: 'G-XTC7P1E2E8',
  );

}