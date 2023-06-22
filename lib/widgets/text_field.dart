// ignore_for_file: prefer_const_constructors

import 'package:babe_it/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:babe_it/theme/theme_colors.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final dynamic? onSubmitted;
  const TextFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: Dimensions.size20,
        right: Dimensions.size20,
        top: Dimensions.size10,
      ),
      child: Container(
        height: Dimensions.size50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: ThemeColors().color5.withOpacity(0.5),
          borderRadius: BorderRadius.circular(Dimensions.size15),
        ),
        child: TextField(
          controller: controller,
          onSubmitted: onSubmitted,
          cursorColor: ThemeColors().color2,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
          ),
        ),
      ),
    );
  }
}
