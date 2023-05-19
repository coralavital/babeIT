import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatelessWidget {
  MyTextField({
    super.key,
    required this.fieldName,
    required this.fieldTitle,
    this.myIcon = Icons.verified_user_outlined,
    this.prefixIconColor = Colors.blueAccent,
  });

  TextEditingController? myController;
  String fieldName;
  String fieldTitle;
  final IconData myIcon;
  Color prefixIconColor;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(
        height: 10,
      ),
      Text(fieldTitle),
      const SizedBox(
        height: 10,
      ),
      TextFormField(
        // onEditingComplete: () {
        //   if (double.tryParse(value!) != null) {
        //     print('llllllllllllllllllllllll');
        //   }
        // },
        controller: myController,
        decoration: InputDecoration(
            labelText: fieldName,
            // prefixIcon: Icon(myIcon, color: prefixIconColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),)
      )
    ]);
  }
}
