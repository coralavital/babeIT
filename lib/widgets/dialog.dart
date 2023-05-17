import 'package:flutter/material.dart';

import 'custom_field.dart';

class BabyDialog extends StatelessWidget {
  String title;
  List<String> message;
  List<String>? detailType;
  String? iconPath;
  BabyDialog(
      {super.key,
      required this.title,
      required this.message,
      this.detailType,
      this.iconPath,});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Baby $title'),
      icon: Image.network(iconPath!, height: 120, width: 120,),
      content: ListView.builder(
        itemCount: message.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: ((context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: MyTextField(
              fieldName: message[index],
              fieldTitle: detailType![index],
            ),
          );
        }),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => {},
          child: const Text('Edit'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
