// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:babe_it/theme/theme_colors.dart';

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
      padding: const EdgeInsets.only(right: 10, bottom: 9),
      child: Container(
        width: 175,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: ThemeColors().grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              widget.measurement,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                availableSensor == true
                    ? Container(
                        height: 12,
                        width: 12,
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      )
                    : Container(
                        height: 12,
                        width: 12,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                SizedBox(
                  width: 6,
                ),
                Text(
                  widget.createDate,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10),
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
