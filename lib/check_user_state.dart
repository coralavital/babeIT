import 'package:babe_it/ui/auth/baby_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:babe_it/ui/auth/login_page.dart';
import 'package:babe_it/ui/home/main_home.dart';

class CheckUserState extends StatefulWidget {
  const CheckUserState({super.key});

  @override
  State<CheckUserState> createState() => _CheckUserStateState();
}

class _CheckUserStateState extends State<CheckUserState> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _friestore = FirebaseFirestore.instance;
  late Map<String, dynamic> babyInfo;

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.signOut();
    return StreamBuilder<User?>(
      stream: _auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Stream<DocumentSnapshot<Map<String, dynamic>>> reference = _friestore
              .collection(_auth.currentUser!.uid)
              .doc("user_data")
              .snapshots();
          reference.listen((querySnapshot) {
            babyInfo = querySnapshot['baby_information'];
          });
          if (babyInfo['name'] != null &&
              babyInfo['age'] != null &&
              babyInfo['height'] != null &&
              babyInfo['weight'] != null) {
            return const BabyInfoPage();
          } else {
            return const MainHome();
          }
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
