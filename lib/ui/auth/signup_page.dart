// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:math';

import 'package:babe_it/ui/auth/baby_details.dart';
import 'package:babe_it/widgets/dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:babe_it/resources/auth_res.dart';
import 'package:babe_it/widgets/custom_button.dart';
import 'package:babe_it/widgets/custom_loader.dart';
import 'package:babe_it/widgets/text_field.dart';

import '../../theme/dimensions.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final CustomLoader _loader = CustomLoader();

  @override
  void dispose() {
    _fullName.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  createAccount() async {
    String fullName = _fullName.text.toString().trim();
    String email = _email.text.toString().trim();
    String password = _password.text.toString().trim();
    List sensors = [{'haterate_sensor': [{'history': []}]}, {'infrared_sensor': [{'history': []}]}, {'sound_sensor': [{'history': []}]}];
    List notifications = [];

    String res = await AuthRes().createAccount(
      fullName,
      email,
      password,
      sensors,
      notifications,
    );

    if (res == 'success') {
      _loader.hideLoader();
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BabyInfoPage(),
          ));
    } else {
      _loader.hideLoader();
      Fluttertoast.showToast(
        msg: res,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: Dimensions.size15,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Text(
                'Welcome',
                style: TextStyle(
                  fontSize: Dimensions.size25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: Dimensions.size20,
              ),
              Text(
                'Create account to continue...',
                style: TextStyle(
                  fontSize: Dimensions.size15,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: Dimensions.size20,
              ),
              TextFieldWidget(
                controller: _fullName,
                hintText: 'Full Name',
                prefixIcon: SvgPicture.asset(
                  'assets/icons/person.svg',
                  fit: BoxFit.none,
                ),
              ),
              TextFieldWidget(
                controller: _email,
                hintText: 'Email',
                prefixIcon: SvgPicture.asset(
                  'assets/icons/email.svg',
                  fit: BoxFit.none,
                ),
              ),
              TextFieldWidget(
                controller: _password,
                hintText: 'Password',
                prefixIcon: SvgPicture.asset(
                  'assets/icons/lock.svg',
                  fit: BoxFit.none,
                ),
              ),
              SizedBox(
                height: Dimensions.size20,
              ),
              CustomButton(
                text: 'Create Account',
                onTap: () {
                  _loader.showLoader(context);
                  createAccount();
                },
              ),
              SizedBox(
                height: Dimensions.size20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Text(
                        'OR',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: Dimensions.size15,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Dimensions.size15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: Dimensions.size50,
                  width: double.infinity,
                  color: Colors.transparent,
                  child: Center(
                    child: Text('Login'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
