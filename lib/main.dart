import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:babe_it/check_user_state.dart';
import 'package:babe_it/firebase_options.dart';
import 'package:babe_it/ui/auth/login_page.dart';
import 'package:babe_it/ui/home/home.dart';
import 'package:babe_it/ui/home/main_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      home: const CheckUserState(),
    );
  }
}
