// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:babe_it/theme/theme_colors.dart';

class CustomNotification extends StatelessWidget {
  final List<dynamic> notifications;
  String notificationList = "";
  final int count;
  CustomNotification({
    super.key,
    required this.notifications,
    required this.count,
  });
  @override
  Widget build(BuildContext context) {
    notifications
        .sort((a, b) => (a["time"] as String).compareTo(b["time"] as String));
    for (int i = 0; i < count; i++) {
      notificationList +=
          '${notifications[i]['time']} - ${notifications[i]['message']}\n';
    }
    return Padding(
      padding: const EdgeInsets.only(right: 10, bottom: 9),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: ThemeColors().grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Notifications',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 15,
            ),
Expanded(
                    child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Text(
                      notificationList,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 15,
                      ),
                    ),
                  ),
                )),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_circle_right_rounded, color: Colors.black38, size: 35,))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
