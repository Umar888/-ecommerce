import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecommerce/repositories/auth/repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'utils/services/fcm/firebase_messaging.dart';

Future<void> main() async {
  await runZonedGuarded(() async {

    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    FCM firebaseMessaging = FCM();
    firebaseMessaging.setNotifications();
    firebaseMessaging.streamCtrl.stream.listen((msgData) {
      debugPrint('messageData $msgData');
    });

    runApp(App(
      authenticationRepository: AuthenticationRepository(),
      connectivity: Connectivity(),
    ));
  }, (error, stackTrace) {
  });
}
