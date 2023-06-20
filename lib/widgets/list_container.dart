// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:babe_it/theme/theme_colors.dart';
import 'package:babe_it/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    for(var i = 0; i < elementList.length; i++){
      if(elementList[i]['value'] != null) {
        elements.add(SmallText(text: '${elementList[i]['timestamp']}', size: Dimensions.size15, fontWeight: FontWeight.w500,)); 
        // - ${elementList[i]['value']}'

        elements.add(SmallText(text:'${elementList[i]['status']}', size: Dimensions.size15, fontWeight: FontWeight.bold, color: ThemeColors().welcome,));
                elements.add(SmallText(text: 'Measurement value: ${elementList[i]['value']}\n', size: Dimensions.size10, fontWeight: FontWeight.w500,)); 

        // elements.add(Text('${elementList[i]['value']}\n'));
      }
      else {
        elements.add(SmallText(text: '${elementList[i]['timestamp']}', size: Dimensions.size13,));
        elements.add(SmallText(text:'${elementList[i]['status']}\n'.toUpperCase(), size: Dimensions.size15, fontWeight: FontWeight.bold, color: ThemeColors().welcome,));
      }
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.center,children: elements);
  }

  @override
  Widget build(BuildContext context) {
    if (elementList.length > 1) {
      elementList
          .sort((a, b) => (b["timestamp"] as String).compareTo(a["timestamp"] as String));
    }

    return Container(
      padding: EdgeInsets.only(left: Dimensions.size10),
      width: double.infinity,
      height: Dimensions.size250,
      decoration: BoxDecoration(
        color: ThemeColors().grey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(Dimensions.size20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
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
                  textAlign: TextAlign.center,
                ),
                Expanded(
                    child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                      padding: EdgeInsets.only(right: Dimensions.size5),
                      child: elementList.isNotEmpty
                          ? getTextWidgets()
                          : Text(
                              'There is no history yet',
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                color: Colors.black38,
                                fontSize: Dimensions.size13,
                              ),
                            )),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
