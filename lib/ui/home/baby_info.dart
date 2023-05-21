// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:babe_it/ui/home/main_home.dart';
import 'package:babe_it/widgets/custom_button.dart';
import 'package:babe_it/widgets/custom_loader.dart';
import 'package:babe_it/widgets/text_field.dart';
import 'package:babe_it/resources/firestore_service.dart';

class BabyInfoPage extends StatefulWidget {
  const BabyInfoPage({super.key});

  @override
  State<BabyInfoPage> createState() => _BabyInfoPage();
}

class _BabyInfoPage extends State<BabyInfoPage> {
  final TextEditingController _babyName = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _height = TextEditingController();
  final TextEditingController _weight = TextEditingController();
  final CustomLoader _loader = CustomLoader();

  @override
  void dispose() {
    _babyName.dispose();
    _age.dispose();
    _height.dispose();
    _weight.dispose();
    super.dispose();
  }

  saveBabyInformation() async {
    String babyName = _babyName.text.toString().trim();
    String age = _age.text.toString().trim();
    String gender = selectedValue;
    String height = _age.text.toString().trim();
    String weight = _weight.text.toString().trim();

    String res = await FirebaseFirestoreService().addBabyInfo(
      babyName,
      gender,
      age,
      height,
      weight,
    );

    if (res == 'success') {
      _loader.hideLoader();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MainHome(),
        ),
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
        fontSize: 16.0,
      );
    }
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(value: "Girl", child: Text("It's a girl")),
      DropdownMenuItem(value: "Boy", child: Text("It's a boy")),
    ];
    return menuItems;
  }

  String selectedValue = 'Boy';

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
                'Baby Information',
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
                'We need the information about your baby\nso that we can diagnose accurately and quickly.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              DropdownButton(
                  value: selectedValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue!;
                      
                    });
                  },
                  items: dropdownItems),
              TextFieldWidget(
                  controller: _babyName,
                  hintText: 'Name',
                  prefixIcon: Icon(Icons.border_color_rounded)),
              TextFieldWidget(
                  controller: _age,
                  hintText: 'Age',
                  prefixIcon: Icon(Icons.numbers_outlined)),
              TextFieldWidget(
                  controller: _height,
                  hintText: 'Height',
                  prefixIcon: Icon(Icons.height_outlined)),
              TextFieldWidget(
                  controller: _weight,
                  hintText: 'Weight',
                  prefixIcon: Icon(Icons.monitor_weight_outlined)),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                text: 'Continue',
                onTap: () {
                  _loader.showLoader(context);
                  saveBabyInformation();
                },
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}