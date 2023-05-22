// ignore_for_file: prefer_const_constructors
import 'package:babe_it/theme/theme_colors.dart';
import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class CustomNotification extends StatelessWidget {
  final List<dynamic> notifications;
  String notificationList = "";
  late DateTime lastNotifications;

  final int count;
  final double? fontSize;
  String? title;
  CustomNotification({
    super.key,
    required this.notifications,
    required this.count,
    required this.fontSize,
  });
  @override
  Widget build(BuildContext context) {
    if (notifications.isNotEmpty) {
      if (notifications.length > 1) {
        notifications.sort(
            (a, b) => (a["time"] as String).compareTo(b["time"] as String));
        if (count <= 5) {
          for (int i = 0; i < count; i++) {
            notificationList +=
                '${notifications[i]['time']} - ${notifications[i]['content']}\n';
          }
        } else {
          for (int i = 0; i < count; i++) {
            notificationList +=
                '${notifications[i]['time']} - ${notifications[i]['content']}\n';
          }
        }
      } else {
        notificationList +=
            '${notifications[0]['time']} - ${notifications[0]['content']}\n';
      }
    } else {
      notificationList += 'There is no notifications yet';
    }
    return Padding(
      padding: EdgeInsets.only(right: Dimensions.size10, bottom: Dimensions.size7),
      child: Container(
        padding: EdgeInsets.all(Dimensions.size15),
        decoration: BoxDecoration(
          color: ThemeColors().grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(Dimensions.size20),
        ),
        child: Column(
          children: [
            SizedBox(
              height: Dimensions.size15,
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
              height: Dimensions.size10,
            ),
          ],
        ),
      ),
    );
  }
}
