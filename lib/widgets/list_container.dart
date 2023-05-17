// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:babe_it/theme/theme_colors.dart';

import '../theme/dimensions.dart';

class ListContainer extends StatelessWidget {
  final String title;
  List<dynamic> elementList;
  String elements = "";
  ListContainer({
    super.key,
    required this.title,
    required this.elementList,
  });

  @override
  Widget build(BuildContext context) {
    elementList
        .sort((a, b) => (a["time"] as String).compareTo(b["time"] as String));
    for (int i = 0; i < elementList.length; i++) {
      elements +=
          '${elementList[i]['time']} - ${elementList[i]['measurement']}\n';
    }
    return Container(
      padding: EdgeInsets.only(left: Dimensions.size10),
      width: double.infinity,
      height: Dimensions.size170,
      decoration: BoxDecoration(
        color: ThemeColors().grey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(Dimensions.size20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Dimensions.size15,
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: Dimensions.size20,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                    child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.only(right: Dimensions.size5),
                    child: Text(
                      elements,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        color: Colors.black38,
                        fontSize: Dimensions.size13,
                      ),
                    ),
                  ),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
