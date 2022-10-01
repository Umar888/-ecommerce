import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as meth;
import 'package:ecommerce/utils/services/shared_preference/shared_preference.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:flutter/foundation.dart';

final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
BehaviorSubject<ReceivedNotification>();


class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

String? selectedNotificationPayload;

const String urlLaunchActionId = 'id_1';

const String navigationActionId = 'id_3';

const String darwinNotificationCategoryText = 'textCategory';

const String darwinNotificationCategoryPlain = 'plainCategory';



class FCM {

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final streamCtrl = StreamController<String>.broadcast();

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings = const AndroidInitializationSettings('@drawable/shopping');
  final List<DarwinNotificationCategory> darwinNotificationCategories =
  <DarwinNotificationCategory>[];
  DarwinInitializationSettings initializationSettingsDarwin =
  DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
    onDidReceiveLocalNotification:
        (int id, String? title, String? body, String? payload) async {
      didReceiveLocalNotificationSubject.add(
        ReceivedNotification(
          id: id,
          title: title,
          body: body,
          payload: payload,
        ),
      );
    },
    notificationCategories: [],
  );

  late InitializationSettings initializationSettings;

  Future<void> initializing() async {
    await FirebaseMessaging.instance.setAutoInitEnabled(true).catchError((onError){
      print("auto init error $onError");
    }); // later added for manifest.xml permission
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    ).catchError((onError){
      print("auto fore error $onError");
    });
    // print("int");

    initializationSettings = InitializationSettings(iOS: initializationSettingsDarwin,
    android: androidInitializationSettings);
    print("int2");
    await flutterLocalNotificationsPlugin.initialize(initializationSettings).onError((error, stackTrace){
          print(error);
    });
    print("int3");
  }

  static void _showNotifications(String body, String title,String channelDescription,String ticker,bool wakeUpScreen,bool autoCancel,String category,int? badge) async {
      await notification(body,title,channelDescription,ticker,wakeUpScreen,autoCancel,category,badge);
  }

  static Future<void> notification(String body, String title,String channelDescription,String ticker,bool wakeUpScreen,bool autoCancel,String category,int? badge) async {
   log("sending notification");
    var vibrationPattern = Int64List(8);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 250;
    vibrationPattern[2] = 500;
    vibrationPattern[3] = 250;
    vibrationPattern[4] = 500;
    vibrationPattern[5] = 250;
    vibrationPattern[4] = 500;
    vibrationPattern[5] = 250;
    vibrationPattern[6] = 0;



    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
        meth.Random().nextInt(1000).toString(), title,
        priority: Priority.high,
        largeIcon: const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
        vibrationPattern: vibrationPattern,
        channelDescription: channelDescription,
        fullScreenIntent: wakeUpScreen,
        category: AndroidNotificationCategory.message,
        autoCancel: autoCancel,
        importance: Importance.high,
        channelShowBadge: true,
        styleInformation: BigTextStyleInformation(body,htmlFormatSummaryText: true),
        ticker: ticker);

    DarwinNotificationDetails iosNotificationDetails =
   DarwinNotificationDetails(
     categoryIdentifier: darwinNotificationCategoryPlain,
       presentAlert: true,
       presentBadge: true,
       presentSound: true,
       badgeNumber: badge
   );


    NotificationDetails notificationDetails =
    NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails
    );


    await flutterLocalNotificationsPlugin.show(meth.Random().nextInt(1000), title, body, notificationDetails,payload: 'item z').catchError((onError){
      log("onError $onError");
    }).whenComplete((){
      log("done");
    });

  }

  void onSelectNotification(String? payload) {
//    _navigationService.navigateTo(FaqPage.route());
  }
  Future<void> iosPermission() async {
    if(Platform.isIOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            critical: true,
            sound: true,
          );
    }
    else if (Platform.isAndroid) {

    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
    AndroidFlutterLocalNotificationsPlugin>();

    final bool? granted = await androidImplementation?.requestPermission();
    }
    _firebaseMessaging.requestPermission(sound: true, badge: true, alert: true,
      announcement: true,
      carPlay: true,
      criticalAlert: true,
    );
  }

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage messages) async {
    print("on _firebaseMessagingBackgroundHandler ios called");
    Map<String, dynamic> message = messages.data;
      if (Platform.isAndroid) {
       _showNotifications(messages.notification!.body!, messages.notification!.title!,'message_channel','message',true,false,'CATEGORY_MESSAGE',0);
      } else {
      // _showNotifications(messages.notification!.body!, messages.notification!.title!,'message_channel','message',true,false,'CATEGORY_MESSAGE',int.parse(message['badge']));
    }
  }

  void firebaseCloudMessagingListeners() {
    if (Platform.isIOS) iosPermission();
    Future.delayed(const Duration(milliseconds: 500), () {
      FirebaseMessaging.onMessage.listen((RemoteMessage messages) async {
        print("on message called");

        Map<String, dynamic> message = messages.data;
        if (Platform.isAndroid) {
            _showNotifications(messages.notification!.body!, messages.notification!.title!,'message_channel','message',true,false,'CATEGORY_MESSAGE',0);
          } else {
          // _showNotifications(messages.notification!.body!, messages.notification!.title!,'message_channel','message',true,false,'CATEGORY_MESSAGE',int.parse(message['badge']??"0"));
          }
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage messages) async {
        Map<String, dynamic> message = messages.data;
        print("on onMessageOpenedApp called");

      });
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    });

  }

  Future<String> setNotifications() async {
    print("fnf");
   await initializing();
    print("fnfe");
    firebaseCloudMessagingListeners();
    print("fnfs");
    String token="";
    _firebaseMessaging.getToken().then((tokens) async {
      token =tokens??"";
      await SharedPreference().saveString("fcm_token",tokens!);
      print('device token_id:_______________$tokens _______________');
    });
    return token;
  }

}