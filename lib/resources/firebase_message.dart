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
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? mtoken;
  Map<String, dynamic>? sensors;
  List sensorsList = ["heart_rate_sensor", "sound_sensor"];

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  DefaultFirebaseOptions firebaseOptions = DefaultFirebaseOptions();

  void getChanges() async {
    DocumentReference reference =
        _firestore.collection(auth.currentUser!.uid).doc("user_data");
    reference.snapshots().listen((querySnapshot) {
      sensors = querySnapshot.get("sensors");
      for (var i = 0; i < sensors!.length; i++) {
        if (sensors![sensorsList[i]]['status'] == "abnormal") {
          if (sensors![sensorsList[i]] == "heart_rate_sensor") {
            if (int.parse(sensors![sensorsList[i]]['current_measurement']) <
                80) {
              sendPushMessage(
                  mtoken.toString(),
                  "In the last heart rate measurement, a value lower than 80 was reported.\nYou must contact your family doctor for consultation.",
                  "Heart Rate");
            } else {
              sendPushMessage(
                  mtoken.toString(),
                  "In the last heart rate measurement, a value higher than 130 was reported.\nYou must contact your family doctor for consultation.",
                  "Heart Rate");
            }
          } else if (sensors![sensorsList[i]] == "sound_sensor") {
            sendPushMessage(
                mtoken.toString(),
                "Your baby is crying now.\nIt is recommended to go and check how it is.",
                "Sound Rate");
          } else {
            continue;
          }
        } else {
          continue;
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

  Future<String> updateNotificationsList(String message) async {
    String now = DateTime.now().toUtc().toString();
    print(now);
    try {
      await _firestore
          .collection('${auth.currentUser?.uid}')
          .doc('user_data')
          .update({
        "notifications": FieldValue.arrayUnion([{'time': now, 'message': message}])
      });
    } catch (e) {
      return e.toString();
    }
    return 'success';
  }

  void sendPushMessage(String token, String body, String title) async {
    try {
      await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization':
                'key=AAAAw8wiyvA:APA91bFgeiFNeiLXwHIh3aM_ZNIe8_aaxwfQFl3djnTDL3B_vx7gi4eHXA_ornrz-jNoCrRJrEmMNP1sPf_OVRhBGe14ByTEpMhkGnRBMNnAmnwM5Rg4FsmzigfVwjIz4ORtIDQbR6Ao'
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
              "android_channel_id": "BabeIT"
            },
            "to": token,
          }));
      updateNotificationsList(body);
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
    await _firestore
        .collection("${auth.currentUser?.uid}")
        .doc("user_token")
        .set({"token": token});
  }

  initInfo() {
    var androidInitialize =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
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
          AndroidNotificationDetails('BabeIT', 'BabeIT',
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
