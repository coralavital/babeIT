import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/dimensions.dart';

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
       SizedBox(
        height: Dimensions.size10,
      ),
      Text(fieldTitle),
       SizedBox(
        height: Dimensions.size10,
      ),
      TextFormField(
        controller: myController,
        decoration: InputDecoration(
            labelText: fieldName,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.size30),
            ),)
      )
    ]);
  }
}
