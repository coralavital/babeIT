// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously
import 'package:email_validator/email_validator.dart';
import 'package:babe_it/widgets/custom_button.dart';
import 'package:babe_it/widgets/custom_loader.dart';
import 'package:babe_it/widgets/text_field.dart';
import 'package:babe_it/resources/auth_res.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import '../../utils/dimensions.dart';
import '../../widgets/small_text.dart';
import 'baby_info.dart';

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

  bool showEmailError = false;
  bool showPasswordError = false;
  bool showNameError = false;

  @override
  void dispose() {
    _fullName.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  createAccount() async {
    String email = _email.text.toString().trim();
    String password = _password.text.toString().trim();
    String fullName = _fullName.text.toString().trim();
    String res = await AuthRes().createAccount(fullName, email, password);

    if (res == 'success') {
      _loader.hideLoader();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BabyInfoPage(),
          ));
    } else {
      setState(() {});
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

  void validatePassword(String password) {
    RegExp regex = RegExp(r'^(?=.*?[A-Za-z])(?=.*?[0-9]).{6,}$');
    if (!regex.hasMatch(password) || password.isEmpty) {
      showPasswordError = true;
    } else {
      showPasswordError = false;
    }
  }

  void validateEmail(String email) {
    if (!EmailValidator.validate(email) || email.isEmpty) {
      showEmailError = true;
    } else {
      showEmailError = false;
    }
  }

  void validateName(String firstName) {
    if (firstName.isEmpty) {
      showNameError = true;
    } else {
      showNameError = false;
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
                hintText: 'Name',
                prefixIcon: SvgPicture.asset(
                  'assets/icons/person.svg',
                  fit: BoxFit.none,
                ),
              ),
              showNameError == true
                  ? SmallText(
                      color: Colors.red,
                      textAlign: TextAlign.start,
                      text: 'Please enter full name\n')
                  : SizedBox(
                      height: Dimensions.size10,
                    ),
              TextFieldWidget(
                controller: _email,
                hintText: 'Email',
                prefixIcon: SvgPicture.asset(
                  'assets/icons/email.svg',
                  fit: BoxFit.none,
                ),
              ),
              showEmailError == true
                  ? SmallText(
                      color: Colors.red,
                      textAlign: TextAlign.start,
                      text: 'Please enter emaill in the following format:\n'
                          '\u2022 a@a.a')
                  : SizedBox(
                      height: Dimensions.size10,
                    ),
              TextFieldWidget(
                controller: _password,
                hintText: 'Password',
                prefixIcon: SvgPicture.asset(
                  'assets/icons/lock.svg',
                  fit: BoxFit.none,
                ),
              ),
              showPasswordError == true
                  ? SmallText(
                      color: Colors.red,
                      textAlign: TextAlign.start,
                      text:
                          'Please enter password with at least\n6 characters and digits\n')
                  : SizedBox(
                      height: Dimensions.size10,
                    ),
              SizedBox(
                height: Dimensions.size20,
              ),
              CustomButton(
                text: 'Create Account',
                onTap: () {
                  _loader.showLoader(context);
                  String email = _email.text.toString().trim();
                  String password = _password.text.toString().trim();
                  String firstName = _fullName.text.toString().trim();
                  validateEmail(email);
                  validatePassword(password);
                  validateName(firstName);
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
                      padding: EdgeInsets.only(left: Dimensions.size5, right: Dimensions.size5),
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
