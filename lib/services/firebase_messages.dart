import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../firebase_options.dart';
import 'dart:convert';

class FMessaging {
  FirebaseAuth auth = FirebaseAuth.instance;
  String? mtoken;
  List<dynamic>? products;

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  DefaultFirebaseOptions firebaseOptions = DefaultFirebaseOptions();

  void getChanges() async {
    DocumentReference reference = FirebaseFirestore.instance
        .collection(auth.currentUser!.uid)
        .doc("user_data");
    reference.snapshots().listen((querySnapshot) {
      products = querySnapshot.get("recently_detected_products");
      for (var index = 0; index < products!.length; index++) {
        var now = DateTime.now();
        var product = products![index];
        if (product["expiration_date"] != null) {
          var date = product["expiration_date"] + '/' + DateTime.now().year.toString();
          DateFormat format = DateFormat('d/M/y');
          DateTime expirationDate = format.parse(date);
          final bool isExpired = expirationDate.isBefore(now);
          var difference = expirationDate.difference(now).inDays;
          if (!isExpired && difference < 2) {
            if (difference == 0) {
              difference = 1;
            }
            sendPushMessage(
                mtoken.toString(),
                "Your ${product["name"]} has $difference days left until its expiration date!\nTry to consume it in the next few days",
                "Expiration Date");
          }
        }
      }
    });
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  void sendPushMessage(String token, String body, String title) async {
    try {
      await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization':
                'key=AAAAroemubE:APA91bH_-j0J5H5ADNnEOGLYRpPnMjt5xni5ZLCEef6JjRqKY_sGuRC3Qkfl3UuKpp_2lL3XGKUh6NzMSjBcoIRE1Qmv_pLvUDFl9L2wB3DcjreOmP8JdueV7Q11bshp2D8qPnM7eDRe'
          },
          body: jsonEncode(<String, dynamic>{
            'prioriity': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': body,
              'title': title,
            },
            "notification": <String, dynamic>{
              "title": title,
              "body": body,
              "android_channel_id": "FridgeIT"
              
            },
            "to": token,
          }));
    } catch (e) {
      print("Can't push notification");
    }
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      mtoken = token;
      print("My token is $token");
      saveToken(token!);
    });
  }

  void saveToken(String token) async {
    await FirebaseFirestore.instance
        .collection("${auth.currentUser?.uid}")
        .doc("user_token")
        .set({"token": token});
  }

  initInfo() {
    var androidInitialize =
        const AndroidInitializationSettings('@drawable/notification_icon');
    var initializationsSettings =
        InitializationSettings(android: androidInitialize);
    flutterLocalNotificationsPlugin.initialize(initializationsSettings,
        onSelectNotification: (String? payload) async {
      try {
        if (payload != null && payload.isNotEmpty) {
        } else {}
      } catch (e) {}
      return;
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("....................onMessage....................");
      print("onMessage\n"
          "title: ${message.notification?.title}"
          "\nbody: ${message.notification?.body}");

      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
          message.notification!.body.toString(),
          htmlFormatBigText: true,
          contentTitle: message.notification!.title.toString(),
          htmlFormatContentTitle: true);
      AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails('FridgeIT', 'FridgeIT',
              importance: Importance.high,
              styleInformation: bigTextStyleInformation,
              priority: Priority.high,
              playSound: true);
      NotificationDetails platformChannelSpecipics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.show(0, message.notification?.title,
          message.notification?.body, platformChannelSpecipics,
          payload: message.data['title']);
    });
  }
}
