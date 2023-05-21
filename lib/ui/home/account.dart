// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/dialog.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        toolbarHeight: 15,
      ),
      body: StreamBuilder(
        stream: _firestore
            .collection(_auth.currentUser!.uid)
            .doc('user_data')
            .snapshots(),
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else {
            return Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Account',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SettingsGroup(
                      items: [
                        SettingsItem(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  var data = snapshot.data!['baby_information'];

                                  return BabyDialog(
                                    babyName: data['name'],
                                    babyAge: data['age'],
                                    babyHeight: data['height'],
                                    babyWeight: data['weight'],
                                    babyIcon: data['baby_icon'],
                                  );
                                });
                          },
                          icons: Icons.info_rounded,
                          iconStyle: IconStyle(
                            backgroundColor: Colors.purple,
                          ),
                          title: 'Baby Information',
                        ),
                      ],
                    ),
                    // You can add a settings title
                    SettingsGroup(
                      items: [
                        SettingsItem(
                          onTap: () {
                            _auth.signOut();
                          },
                          icons: Icons.exit_to_app_rounded,
                          title: "Sign Out",
                        ),
                        SettingsItem(
                          onTap: () {
                            User user = _auth.currentUser!;
                            user.delete();
                          },
                          icons: CupertinoIcons.delete_solid,
                          title: "Delete account",
                          titleStyle: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ));
          }
        }),
      ),
    );
  }
}
