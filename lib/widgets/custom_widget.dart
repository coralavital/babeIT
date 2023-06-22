// ignore_for_file: prefer_const_constructors
import 'package:babe_it/theme/theme_colors.dart';
import 'package:babe_it/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/dimensions.dart';

class CustomContainer extends StatefulWidget {
  final String title;
  final List<dynamic> measurement;
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

class _CustomContainerState extends State<CustomContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )
      ..forward()
      ..repeat(reverse: true);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String color = 'green';
    if (widget.sensor!['time'].toString() != "") {
      var lastMeasurement = DateTime.parse(widget.sensor!['time']);
      if (DateTime.now()
          .isAfter(lastMeasurement.add(const Duration(minutes: 30)))) {
        color = 'red';
      } else {
        color = "green";
      }
    } else {
      color = "There is no data";
    }

    return Padding(
      padding:
          EdgeInsets.only(right: Dimensions.size5, bottom: Dimensions.size7),
      child: Container(
        width: Dimensions.size170,
        padding: EdgeInsets.all(Dimensions.size15),
        decoration: BoxDecoration(
          color: ThemeColors().color5.withOpacity(0.3),
          borderRadius: BorderRadius.circular(Dimensions.size20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: ThemeColors().color4,
                  fontSize: Dimensions.size15,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: Dimensions.size10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                color == "green"
                    ? Container(
                        height: Dimensions.size13,
                        width: Dimensions.size13,
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius:
                              BorderRadius.circular(Dimensions.size13),
                        ),
                      )
                    : color == "red"
                        ? Container(
                            height: Dimensions.size13,
                            width: Dimensions.size13,
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius:
                                  BorderRadius.circular(Dimensions.size13),
                            ),
                          )
                        : Column(children: [
                            SmallText(text: "There is no data yet"),
                            SizedBox(
                              height: Dimensions.size5,
                            ),
                            AnimatedIcon(
                              icon: AnimatedIcons.view_list,
                              color: ThemeColors().color1,
                              progress: animation,
                              size: Dimensions.size25,
                              semanticLabel: 'Show menu',
                            ),
                          ]),
                SizedBox(
                  width: Dimensions.size5,
                ),
                widget.measurement[1] != null
                    ? Row(children: [
                        Text(
                          widget.measurement[0].toString().capitalize!,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: Dimensions.size20,
                            color: ThemeColors().color3,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: Dimensions.size5,
                        ),
                        Text(
                          widget.measurement[1].toString().capitalize!,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: Dimensions.size10,
                            color: ThemeColors().color3,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ])
                    : Text(
                        widget.measurement[0].toString().capitalize!,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: Dimensions.size20,
                          color: ThemeColors().color3,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ],
            ),
            SizedBox(
              height: Dimensions.size5,
            ),
            Text(
              widget.createDate,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: Dimensions.size13, color: ThemeColors().color6),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
