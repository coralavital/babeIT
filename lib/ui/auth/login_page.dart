// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables
import 'package:babe_it/ui/auth/reset_password.dart';
import 'package:babe_it/widgets/custom_button.dart';
import 'package:babe_it/widgets/custom_loader.dart';
import 'package:babe_it/ui/auth/signup_page.dart';
import 'package:babe_it/resources/auth_res.dart';
import 'package:babe_it/widgets/text_field.dart';
import 'package:babe_it/ui/home/main_home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

import '../../utils/dimensions.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final CustomLoader _loader = CustomLoader();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  login() async {
    String email = _email.text.toString().trim();
    String password = _password.text.toString().trim();

    String res = await AuthRes().login(email, password);

    if (res == 'success') {
      _loader.hideLoader();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MainHome(),
        ),
      );
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
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Text(
                'Welcome back',
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
                'Login to continue...',
                style: TextStyle(
                  fontSize: Dimensions.size15,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: Dimensions.size20,
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
                text: 'Login',
                onTap: () {
                  _loader.showLoader(context);
                  login();
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignupPage(),
                      ));
                },
                child: Container(
                  height: Dimensions.size50,
                  width: double.infinity,
                  color: Colors.transparent,
                  child: Center(
                    child: Text('Create Account'),
                  ),
                ),
              ),
              SizedBox(
                height: Dimensions.size15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResetPassword(),
                      ));
                },
                child: Container(
                  height: Dimensions.size50,
                  width: double.infinity,
                  color: Colors.transparent,
                  child: Center(
                    child: Text('Reset password'),
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
