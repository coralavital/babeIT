// ignore_for_file: prefer_const_constructors
import 'package:babe_it/ui/home/history_list.dart';
import 'package:babe_it/ui/home/notification_list.dart';
import 'package:flutter/material.dart';
import 'package:babe_it/theme/theme_colors.dart';

class CustomNotification extends StatelessWidget {
  final List<dynamic> notifications;
  String notificationList = "";
  String lastNotifications = "";

  final int count;
  final double? fontSize;
  String? title;
  CustomNotification({
    super.key,
    required this.notifications,
    required this.count,
    required this.fontSize,
    this.title,
  });
  @override
  Widget build(BuildContext context) {
    notifications
        .sort((a, b) => (a["time"] as String).compareTo(b["time"] as String));
    if (count <= 5) {
      for (int i = 0; i < count; i++) {
        var lastMeasurement = DateTime.parse(notifications[i]['time']);
          notificationList +=
              '${notifications[i]['time']} - ${notifications[i]['message']}\n';
      }
    } else {
      for (int i = 0; i < count; i++) {
        notificationList +=
            '${notifications[i]['time']} - ${notifications[i]['message']}\n';
      }
    }
    return Padding(
      padding: const EdgeInsets.only(right: 10, bottom: 8),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: ThemeColors().grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            title != null
                ? Center(
                    child: Text(
                      'Notifications',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                : Container(),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Row(children: [
                    Text(
                      notificationList,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: fontSize,
                      ),
                    ),
                  ])),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
