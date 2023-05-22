// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:babe_it/resources/auth_res.dart';
import 'package:babe_it/widgets/custom_button.dart';
import 'package:babe_it/widgets/custom_loader.dart';
import 'package:babe_it/widgets/text_field.dart';

import '../../utils/dimensions.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _email = TextEditingController();
  final CustomLoader _loader = CustomLoader();

  @override
  void dispose() {
    _email.dispose();

    super.dispose();
  }

  resetPass() async {
    String email = _email.text.trim().toString();
    String res = await AuthRes().resetPassword(email);
    if (res == 'success') {
      _loader.hideLoader();
      Fluttertoast.showToast(
        msg: 'Password reset link sent to your mail',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: Dimensions.size15,
      );
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
                'Forgot Password',
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
                'Enter your email to reset password',
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
                hintText: 'Password',
                prefixIcon: SvgPicture.asset(
                  'assets/icons/email.svg',
                  fit: BoxFit.none,
                ),
              ),
              SizedBox(
                height: Dimensions.size20,
              ),
              CustomButton(
                text: 'Reset password',
                onTap: () {
                  _loader.showLoader(context);
                  resetPass();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
