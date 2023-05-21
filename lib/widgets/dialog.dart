import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/theme_colors.dart';
import 'custom_loader.dart';

class BabyDialog extends StatefulWidget {
  String babyAge;
  String babyHeight;
  String babyWeight;
  String babyName;
  String babyIcon;

  BabyDialog(
      {super.key,
      required this.babyAge,
      required this.babyHeight,
      required this.babyIcon,
      required this.babyName,
      required this.babyWeight});

  @override
  State<BabyDialog> createState() => _BabyDialog();
}

class _BabyDialog extends State<BabyDialog> {
  bool editFields = false;
  String buttonText = "Edit";

  final TextEditingController _age = TextEditingController();
  final TextEditingController _height = TextEditingController();
  final TextEditingController _weight = TextEditingController();
  final CustomLoader _loader = CustomLoader();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text('Baby ${widget.babyName}'),
        icon: Image.network(
          widget.babyIcon,
          height: 120,
          width: 120,
        ),
        content: Column(children: [
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: _age,
            enabled: editFields,
            cursorColor: ThemeColors().blue,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.babyAge,
                prefixIcon: Icon(Icons.numbers_outlined)),
          ),
          TextField(
            controller: _height,
            enabled: editFields,
            cursorColor: ThemeColors().blue,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.babyAge,
                prefixIcon: Icon(Icons.height_outlined)),
          ),
          TextField(
            controller: _weight,
            enabled: editFields,
            cursorColor: ThemeColors().blue,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.babyAge,
                prefixIcon: Icon(Icons.line_weight_outlined)),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => {
                  setState(() {
                    editFields = true;
                    buttonText = 'Cancel';
                  })
                },
                child: Text(buttonText),
              ),
           
            ],
          )
        ]));
  }
}
