import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
<<<<<<< HEAD
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb;
=======
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
>>>>>>> bcbea81 (Added passenger rating dialog and updated driver rating calculation)

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
<<<<<<< HEAD
      case TargetPlatform.iOS:
        return ios;
=======
>>>>>>> bcbea81 (Added passenger rating dialog and updated driver rating calculation)
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
<<<<<<< HEAD
    apiKey: 'YOUR_WEB_API_KEY',
    appId: 'YOUR_WEB_APP_ID',
    messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
    projectId: 'firgo-ride-sharing',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'YOUR_ANDROID_API_KEY',
    appId: 'YOUR_ANDROID_APP_ID',
    messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
    projectId: 'firgo-ride-sharing',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'YOUR_IOS_API_KEY',
    appId: 'YOUR_IOS_APP_ID',
    messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
    projectId: 'firgo-ride-sharing',
=======
    apiKey: "AIzaSyDVq94AwgBb64FTaGWiBgAhcPagyAIaUv8",
    authDomain: "firgo06.firebaseapp.com",
    projectId: "firgo06",
    storageBucket: "firgo06.firebasestorage.app",
    messagingSenderId: "248782088583",
    appId: "1:248782088583:web:9eb6f8677106148dd48b22",
    measurementId: "G-3MGMBBMHJP",
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyDVq94AwgBb64FTaGWiBgAhcPagyAIaUv8",
    authDomain: "firgo06.firebaseapp.com",
    projectId: "firgo06",
    storageBucket: "firgo06.firebasestorage.app",
    messagingSenderId: "248782088583",
    appId: "1:248782088583:web:9eb6f8677106148dd48b22",
    measurementId: "G-3MGMBBMHJP",
>>>>>>> bcbea81 (Added passenger rating dialog and updated driver rating calculation)
  );
}