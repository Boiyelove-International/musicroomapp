import 'dart:convert';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// Import the generated file
import '../firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

class FCMService {
  // BuildContext context;

  FCMService() {
    initialiseFCM();
  }

  initialiseFCM() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // await FirebaseMessaging.instance.requestPermission();
    String? deviceId = await FirebaseMessaging.instance.getToken();
    print("FCM DEVICE ID >>> $deviceId");
// Set the background messaging handler early on, as a named top-level function
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    var initializationSettingsAndroid =
        AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('received push notification');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      print(message.notification?.title);
      print(message.notification?.body);

      notify(message.notification?.title, message.notification?.body,
          payload: jsonEncode(message.data));
    });
  }

  selectNotification(a) {
    Map data = jsonDecode(a);
    print(data['data']);
    Map payload = jsonDecode(data['data']);
  }

  onDidReceiveLocalNotification(a, b, c, d) {
    print(a);
    print(b);
    print(c);
    print(d);
  }

  Future notify(title, text,
      {String? payload, channelID: 'musicroom_id', hashcode: 0}) async {
    int notification_id = Random().nextInt(1000);

    flutterLocalNotificationsPlugin.show(
        notification_id,
        title,
        text,
        NotificationDetails(
          android: AndroidNotificationDetails(channel.id, channel.name,
              channelDescription: channel.description,
              icon: 'mipmap/ic_launcher',
              playSound: true),
        ),
        payload: payload ?? '');
    print('launched');
  }
}
