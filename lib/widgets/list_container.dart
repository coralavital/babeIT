// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:babe_it/theme/theme_colors.dart';

class ListContainer extends StatelessWidget {
  final String illustration;
  final String title;
  List<dynamic> elementList;
  String elements = "";
  ListContainer({
    super.key,
    required this.illustration,
    required this.title,
    required this.elementList,
  });

  @override
  Widget build(BuildContext context) {
    elementList=elementList..sort((a, b) => DateTime.parse(a['time']).compareTo(DateTime.parse(b['time'])));
    for (int i = 0; i < elementList.length; i++) {
      elements +=
          '${elementList[i]['time']} - ${elementList[i]['measurement']}\n';
    }
    print(elementList);
    return Container(
      padding: EdgeInsets.only(left: 10),
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        color: ThemeColors().main,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Text(
                    elements,
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
