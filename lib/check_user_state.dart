import 'package:babe_it/ui/auth/baby_info.dart';
import 'package:babe_it/ui/auth/signup_page.dart';
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
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return StreamBuilder(
              stream: _firestore
                  .collection(_auth.currentUser!.uid)
                  .doc('user_data')
                  .snapshots(),
              builder: ((context, snapshot) {
                if (!snapshot.hasData) {
                  return const SignupPage();
                } else {
                  if (snapshot.data!['baby_information'].toString() == "") {
                    return const BabyInfoPage();
                  } else {
                    return const MainHome();
                  }
                }
              }));
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
