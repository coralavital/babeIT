// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:babe_it/theme/theme_colors.dart';

import '../theme/dimensions.dart';

class WidgetHome extends StatefulWidget {
  final String title;
  final String description;
  final String createDate;
  final String progress_percentage;
  const WidgetHome({
    super.key,
    required this.title,
    required this.description,
    required this.createDate,
    required this.progress_percentage,
  });

  @override
  State<WidgetHome> createState() => _WidgetHomeState();
}

class _WidgetHomeState extends State<WidgetHome> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Dimensions.size10),
      child: Container(
        height: Dimensions.size90,
        padding: EdgeInsets.all(Dimensions.size10),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Dimensions.size20),
            border: Border.all(width: 1, color: ThemeColors().grey)),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: Dimensions.size5,
                  ),
                  Text(
                    widget.description,
                    style: TextStyle(
                      fontSize: Dimensions.size15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(widget.createDate)
                ],
              ),
            ),
            CircularStepProgressIndicator(
              totalSteps: int.parse(widget.progress_percentage),
              currentStep: int.parse(widget.progress_percentage),
              stepSize: 2,
              selectedColor: ThemeColors().blue,
              unselectedColor: ThemeColors().grey,
              padding: 0,
              width: Dimensions.size50,
              height: Dimensions.size50,
              selectedStepSize: 2,
              roundedCap: (_, __) => true,
              child: Center(
                child: Text(
                  '${widget.progress_percentage}%',
                  style: TextStyle(
                    fontSize: Dimensions.size15,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
