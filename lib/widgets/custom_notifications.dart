// ignore_for_file: prefer_const_constructors
import 'package:babe_it/theme/theme_colors.dart';
import 'package:babe_it/widgets/small_text.dart';
import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class CustomNotification extends StatelessWidget {
  final List<dynamic> notifications;
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

  Widget getTextWidgets() {
    List<Widget> elements = <Widget>[];
    for (var i = 0; i < notifications.length; i++) {
        elements.add(SmallText(
          text: '${notifications[i]['time']}',
          size: Dimensions.size15,
          fontWeight: FontWeight.w600,
          
        ));
        elements.add(SmallText(
          text: '${notifications[i]['message']}\n',
          size: Dimensions.size13,
          color: ThemeColors().welcome,
        ));
        // elements.add(Text('${elementList[i]['value']}\n'));
      }
    
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: elements);
  }

  @override
  Widget build(BuildContext context) {
if (notifications.length > 1) {
      notifications
          .sort((a, b) => (b["time"] as String).compareTo(a["time"] as String));
    }
    return Padding(
      padding:
          EdgeInsets.only(right: Dimensions.size10, bottom: Dimensions.size7),
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
                  child: 
                  notifications.isNotEmpty
                          ? getTextWidgets()
                          : Text(
                              'There is no history yet',
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                color: Colors.black38,
                                fontSize: Dimensions.size13,
                              ),
                            )),
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
