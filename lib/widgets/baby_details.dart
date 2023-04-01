// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:babe_it/theme/theme_colors.dart';

class BabyDetails extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  BabyDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.only(right: 10, left: 10),
        height: 450,
        width: double.infinity,
        color: ThemeColors().grey,
        child: Row(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(_auth.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  } else {
                    return ListView.builder(
                      itemCount: 1,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Container()
                          // ListContainer(
                          //   elementList: snapshot.data!['baby_details'],
                          //   title: snapshot.data!['baby_details']['name'],
                          // ),
                        );
                      }),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
