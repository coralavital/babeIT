// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:babe_it/widgets/baby_details.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        toolbarHeight: 15,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
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
                ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  child: Icon(Icons.logout_outlined, color: Colors.black38),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            BabyDetails(),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                User? user = FirebaseAuth.instance.currentUser;
                user!.delete();
              },
              child: Text('Delete Account', style: TextStyle(color: Colors.black38),),
            ),
          ],
        ),
      ),
    );
  }
}
