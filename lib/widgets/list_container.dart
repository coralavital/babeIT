// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:babe_it/theme/theme_colors.dart';

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
    if (elementList.isEmpty) {
      elements += 'There is no history yet';
    } else if (elementList.length > 1) {
      elementList
          .sort((a, b) => (a["time"] as String).compareTo(b["time"] as String));
      for (int i = 0; i < elementList.length; i++) {
        elements +=
            '${elementList[i]['time']} - ${elementList[i]['measurement']}\n';
      }
    } else {
      elements +=
          '${elementList[0]['time']} - ${elementList[0]['measurement']}\n';
    }
    return Container(
      padding: EdgeInsets.only(left: 10),
      width: double.infinity,
      height: 170,
      decoration: BoxDecoration(
        color: ThemeColors().grey.withOpacity(0.5),
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
                    color: Colors.black38,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                    child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Text(
                      elements,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        color: Colors.black38,
                        fontSize: 12,
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
