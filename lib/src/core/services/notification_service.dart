// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'dart:math';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:music_booth/Routes/routes.dart';
// import 'package:music_booth/Utils/log.dart';

// /// handle background notification
// Future<void> handleBackground(RemoteMessage message) async {
//   Log.d('Title:- ${message.notification?.title}');
//   Log.d('Body:- ${message.notification?.body}');
//   Log.d('Data:- ${message.data}');
// }

// /// handle local notification on tap event in forground and background
// void onDidReceiveNotificationResponse(
//   NotificationResponse notificationResponse,
// ) {
//   Get.toNamed(Routes.notificationScreen);
// }

// /// [NotificationService] use for handle firebase notification using flutter local notification
// class NotificationService {
//   NotificationService._();

//   static final _instance = NotificationService._();

//   factory NotificationService() {
//     return _instance;
//   }

//   static final firebaseMessaging = FirebaseMessaging.instance;

//   final _flutterLocalNotificationPlugin = FlutterLocalNotificationsPlugin();

//   final _androidChannel = const AndroidNotificationChannel(
//     'channel_id',
//     'Music Booth High Importance Notification',
//     description:
//         'This channel is used for important notifications, such as booking updates.',
//     importance: Importance.high,
//     playSound: true,
//     enableLights: true,
//     enableVibration: true,
//   );
//   final icon = '@drawable/ic_notification';

//   Future<void> init() async {
//     await firebaseMessaging.requestPermission();
//     final fcmToken = await firebaseMessaging.getToken();
//     Log.d('FCM TOKEN:- $fcmToken');
//     await initPushNotification();
//     await initLocalNotification();
//   }

//   Future<void> initPushNotification() async {
//     await firebaseMessaging.setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//     FirebaseMessaging.onMessageOpenedApp.listen(onMessageOpenedApp);
//     FirebaseMessaging.onBackgroundMessage(handleBackground);
//     FirebaseMessaging.instance.setAutoInitEnabled(true);
//     FirebaseMessaging.onMessage.listen((event) {
//       final notification = event.notification;
//       if (notification == null) return;
//       if (Platform.isAndroid) {
//         showNotification(
//           title: notification.title!,
//           body: notification.body!,
//           paylod: notification.toMap(),
//         );
//       }
//     });
//   }

//   Future<void> initLocalNotification() async {
//     const iosInitializationSettings = DarwinInitializationSettings();
//     final androidInitializationSettings = AndroidInitializationSettings(icon);

//     final settings = InitializationSettings(
//       android: androidInitializationSettings,
//       iOS: iosInitializationSettings,
//     );

//     await _flutterLocalNotificationPlugin.initialize(
//       settings,
//       onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
//       onDidReceiveBackgroundNotificationResponse:
//           onDidReceiveNotificationResponse,
//     );

//     final androidPlartformImplementation =
//         _flutterLocalNotificationPlugin.resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>();
//     androidPlartformImplementation?.createNotificationChannel(_androidChannel);
//     final iosPlartformImplementation =
//         _flutterLocalNotificationPlugin.resolvePlatformSpecificImplementation<
//             IOSFlutterLocalNotificationsPlugin>();
//     iosPlartformImplementation?.requestPermissions(
//       alert: true,
//       sound: true,
//       badge: true,
//     );
//   }

//   static Future<String> get fcmToken async {
//     return (await firebaseMessaging.getToken())!;
//   }

//   void showNotification({
//     required String title,
//     required String body,
//     required Map<String, dynamic> paylod,
//   }) {
//     final id = Random().nextInt(1000);
//     final notificationDetails = getNotificationDetails();
//     _flutterLocalNotificationPlugin.show(
//       id,
//       title,
//       body,
//       notificationDetails,
//       payload: jsonEncode(paylod),
//     );
//   }

//   NotificationDetails getNotificationDetails() {
//     return NotificationDetails(
//       android: AndroidNotificationDetails(
//         _androidChannel.id,
//         _androidChannel.name,
//         channelDescription: _androidChannel.description,
//         icon: icon,
//         importance: _androidChannel.importance,
//       ),
//       iOS: const DarwinNotificationDetails(
//         presentAlert: true,
//         presentBadge: true,
//         presentSound: true,
//       ),
//     );
//   }

//   bool onInitialMessage(RemoteMessage? message) {
//     if (message == null) return false;
//     return true;
//   }

//   void onMessageOpenedApp(RemoteMessage? message) {
//     if (message == null) return;
//     Get.toNamed(Routes.notificationScreen);
//   }

//   Future<bool> requestNotification() async {
//     final notificationSetting = await firebaseMessaging.requestPermission();
//     if (notificationSetting.authorizationStatus ==
//         AuthorizationStatus.authorized) {
//       return true;
//     }
//     return false;
//   }
// }
