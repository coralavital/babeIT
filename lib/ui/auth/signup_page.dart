// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:babe_it/resources/auth_res.dart';
import 'package:babe_it/widgets/custom_button.dart';
import 'package:babe_it/widgets/custom_loader.dart';
import 'package:babe_it/widgets/text_field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _surname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final CustomLoader _loader = CustomLoader();

  @override
  void dispose() {
    _name.dispose();
    _surname.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  var avatars = [
    'https://firebasestorage.googleapis.com/v0/b/babeit.appspot.com/o/avatar%2Favatar1.png?alt=media&token=a0d86773-1df8-4e7f-b9d8-37e588e77fcf',
    'https://firebasestorage.googleapis.com/v0/b/babeit.appspot.com/o/avatar%2Favatar10.png?alt=media&token=7441c5a7-eae6-4e15-87ad-2dcbe013db6a',
    'https://firebasestorage.googleapis.com/v0/b/babeit.appspot.com/o/avatar%2Favatar11.png?alt=media&token=585db2d4-f86c-4a7d-b526-9a91b0ba7371',
    'https://firebasestorage.googleapis.com/v0/b/babeit.appspot.com/o/avatar%2Favatar12.png?alt=media&token=03cdcb46-1f90-47cd-9145-0fb4c42b3074',
    'https://firebasestorage.googleapis.com/v0/b/babeit.appspot.com/o/avatar%2Favatar13.png?alt=media&token=319babb6-285a-4498-8786-1d198a786704',
    'https://firebasestorage.googleapis.com/v0/b/babeit.appspot.com/o/avatar%2Favatar14.png?alt=media&token=cfaf4cbe-ffe2-4d2a-8935-2a254892bf75',
    'https://firebasestorage.googleapis.com/v0/b/babeit.appspot.com/o/avatar%2Favatar2.png?alt=media&token=486459ed-cd7b-4f68-8e4b-19dcc1f8db3b',
    'https://firebasestorage.googleapis.com/v0/b/babeit.appspot.com/o/avatar%2Favatar3.png?alt=media&token=8b61a38b-2690-466d-b2eb-ecc9bb27faf4',
    'https://firebasestorage.googleapis.com/v0/b/babeit.appspot.com/o/avatar%2Favatar4.png?alt=media&token=78fbb383-a6c8-4bc3-9c9b-7dd12cda395b',
    'https://firebasestorage.googleapis.com/v0/b/babeit.appspot.com/o/avatar%2Favatar5.png?alt=media&token=2cd54e1b-281b-4c70-8737-841c4d2b0c77',
    'https://firebasestorage.googleapis.com/v0/b/babeit.appspot.com/o/avatar%2Favatar6.png?alt=media&token=9abcc325-7598-4837-b458-356ecde0c93b',
    'https://firebasestorage.googleapis.com/v0/b/babeit.appspot.com/o/avatar%2Favatar7.png?alt=media&token=cd45d31b-675c-4bab-a26f-45aa54728873',
    'https://firebasestorage.googleapis.com/v0/b/babeit.appspot.com/o/avatar%2Favatar8.png?alt=media&token=06d01cd6-e1f8-4987-8e42-539195cf25b8',
    'https://firebasestorage.googleapis.com/v0/b/babeit.appspot.com/o/avatar%2Favatar9.png?alt=media&token=28be50e1-047d-496c-b4cf-0cef0c2eb350',
  ];

  createAccount() async {
    var avatarList = avatars[Random().nextInt(avatars.length)];
    String name = _name.text.toString().trim();
    String surname = _surname.text.toString().trim();
    String email = _email.text.toString().trim();
    String password = _password.text.toString().trim();

    String res = await AuthRes().createAccount(
      name,
      surname,
      email,
      avatarList,
      password,
    );

    if (res == 'success') {
      _loader.hideLoader();
      Navigator.pop(context);
    } else {
      _loader.hideLoader();
      Fluttertoast.showToast(
        msg: res,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
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
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Create account to continue...',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                controller: _name,
                hintText: 'Name',
                prefixIcon: SvgPicture.asset(
                  'assets/icons/person.svg',
                  fit: BoxFit.none,
                ),
              ),
              TextFieldWidget(
                controller: _surname,
                hintText: 'Surname',
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
                height: 20,
              ),
              CustomButton(
                text: 'Create Account',
                onTap: () {
                  _loader.showLoader(context);
                  createAccount();
                },
              ),
              SizedBox(
                height: 20,
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
                          fontSize: 14,
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
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 50,
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
