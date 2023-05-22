// imports
import 'package:flutter/material.dart';

// SmallText class
class SmallText extends StatelessWidget {
  final Color? color;
  final TextAlign? textAlign;
  final String text;
  final FontWeight fontWeight;
  double size;
  double height;
  SmallText({
    Key? key,
    this.fontWeight = FontWeight.normal,
    this.color = const Color(0xff000000),
    required this.text,
    this.height = 1.2,
    this.size = 12,
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontWeight: fontWeight.value == 0 ? FontWeight.normal : fontWeight,
        fontFamily: 'Poppins',
        fontSize: size,
        height: height,
      ),
    );
  }
}