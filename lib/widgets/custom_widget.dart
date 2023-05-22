// ignore_for_file: prefer_const_constructors
import 'package:babe_it/theme/theme_colors.dart';
import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class CustomContainer extends StatefulWidget {
  final String title;
  final String measurement;
  final String createDate;
  Map<String, dynamic>? sensor;

  CustomContainer({
    super.key,
    required this.title,
    required this.measurement,
    required this.createDate,
    required this.sensor,
  });

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  @override
  Widget build(BuildContext context) {
    bool availableSensor = true;
    if (widget.sensor!['time'] == "") {
      
    } else {
      var lastMeasurement = DateTime.parse(widget.sensor!['time']);
      if (DateTime.now()
          .isAfter(lastMeasurement.add(const Duration(minutes: 30)))) {
        availableSensor = false;
      } else {
        availableSensor = true;
      }
    }

    return Padding(
      padding: EdgeInsets.only(right: Dimensions.size10, bottom: Dimensions.size7),
      child: Container(
        width: Dimensions.size170,
        padding: EdgeInsets.all(Dimensions.size15),
        decoration: BoxDecoration(
          color: ThemeColors().grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(Dimensions.size20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: Dimensions.size15,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: Dimensions.size15,
            ),
            Text(
              widget.measurement,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: Dimensions.size20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: Dimensions.size10,
            ),
            Row(
              children: [
                availableSensor == true
                    ? Container(
                        height: Dimensions.size13,
                        width: Dimensions.size13,
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(Dimensions.size13),
                        ),
                      )
                    : Container(
                        height: Dimensions.size13,
                        width: Dimensions.size13,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(Dimensions.size13),
                        ),
                      ),
                SizedBox(
                  width: Dimensions.size5,
                ),
                Text(
                  widget.createDate,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: Dimensions.size10),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
