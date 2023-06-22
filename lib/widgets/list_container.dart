// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:babe_it/theme/theme_colors.dart';
import 'package:babe_it/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../utils/dimensions.dart';

class ListContainer extends StatelessWidget {
  final String title;
  List<dynamic> elementList;

  ListContainer({
    super.key,
    required this.title,
    required this.elementList,
  });

  Widget getTextWidgets() {
    List<Widget> elements = <Widget>[];
   
    for (var i = 0; i < elementList.length; i++) {
      DateTime time = DateTime.parse(elementList[i]['timestamp']);
     
      if (elementList[i]['value'] != null) {
        elements.add(SmallText(
        text: DateFormat('dd-MM-yyy HH:mm:ss')
                                                  .format(time),
        size: Dimensions.size15,
        fontWeight: FontWeight.w600,
        color: ThemeColors().color4,
      ));
        elements.add(SmallText(
          text: '${elementList[i]['status']}'.toUpperCase(),
          size: Dimensions.size13,
          fontWeight: FontWeight.bold,
          color: ThemeColors().color2,
        ));
        elements.add(SmallText(
            text: 'Measurement value: ${elementList[i]['value']}\n',
            size: Dimensions.size13,
            fontWeight: FontWeight.w500,
            color: ThemeColors().color3));

        // elements.add(Text('${elementList[i]['value']}\n'));
      } else {
        elements.add(SmallText(
        text: DateFormat('dd-MM-yyy HH:mm:ss')
                                                  .format(time),
        size: Dimensions.size15,
        fontWeight: FontWeight.w600,
        color: ThemeColors().color4,
      ));
        elements.add(SmallText(
          text: '${elementList[i]['status']}\n'.toUpperCase(),
          size: Dimensions.size13,
          fontWeight: FontWeight.bold,
          color: ThemeColors().color2,
        ));
      }
    }
    return Padding(padding: EdgeInsets.only(left: Dimensions.size40), child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: elements));
  }

  @override
  Widget build(BuildContext context) {
    if (elementList.length > 1) {
      elementList.sort((a, b) =>
          (b["timestamp"] as String).compareTo(a["timestamp"] as String));
    }

    return Container(
      padding: EdgeInsets.only(left: Dimensions.size10),
      width: double.maxFinite,
      height: Dimensions.screenHeight / 2.8,
      decoration: BoxDecoration(
        color: ThemeColors().color5.withOpacity(0.5),
        borderRadius: BorderRadius.circular(Dimensions.size20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Dimensions.size15,
          ),
          Text(
            title,
            style: TextStyle(
              color: ThemeColors().color7,
              fontSize: Dimensions.size20,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.fade,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: Dimensions.size5,
          ),
          Expanded(
            child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: elementList.isNotEmpty
                    ? getTextWidgets()
                    : Text(
                        'There is no history yet',
                        overflow: TextOverflow.visible,
                        style: TextStyle(
                          color: ThemeColors().color3,
                          fontSize: Dimensions.size13,
                        ),
                      )),
          )
        ],
      ),
    );
  }
}
