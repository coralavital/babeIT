import 'package:babe_it/theme/theme_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:babe_it/widgets/list_container.dart';

import '../../utils/dimensions.dart';
import '../../widgets/custom_notifications.dart';

class NotificationsList extends StatefulWidget {
  const NotificationsList({super.key});

  @override
  State<NotificationsList> createState() => _NotificationsList();
}

class _NotificationsList extends State<NotificationsList> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        toolbarHeight: Dimensions.size15,
      ),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.size15),
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              //Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Notifications',
                    style: TextStyle(
                      fontSize: Dimensions.size30,
                      fontWeight: FontWeight.bold,
                      color: ThemeColors().color1
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Dimensions.size25,
              ),
              //Body
              Expanded(
                child: SizedBox(
                  height: Dimensions.size200,
                  child: StreamBuilder(
                    stream: _firestore
                        .collection(_auth.currentUser!.uid)
                        .doc('user_data')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data!['notifications'];
                        return CustomNotification(
                          notifications: data,
                          count: data.length,
                          fontSize: Dimensions.size15,
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
