// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:babe_it/widgets/custom_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../utils/dimensions.dart';
import '../../widgets/custom_notifications.dart';
import 'package:babe_it/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List? allNotifications;
  List availableSensor = ['heart_rate_sensor', 'sound_sensor'];

  final List<String> sensors = ['heart_rate_sensor', 'sound_sensor'];

  String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  getSensorTitle(String sensor) {
    if (sensor == 'heart_rate_sensor') {
      return "Heart Rate Sensor";
    } else {
      return 'Sound Sensor';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          toolbarHeight: Dimensions.size15,
        ),
        body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: _firestore
                .collection(_auth.currentUser!.uid)
                .doc('user_data')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return LinearProgressIndicator();
              return Padding(
                padding: EdgeInsets.all(Dimensions.size15),
                child: Column(
                  children: [
                    //Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Hello, ${snapshot.data!['name']}',
                          style: TextStyle(
                              fontSize: Dimensions.size25,
                              fontWeight: FontWeight.bold,
                              color: ThemeColors().color1),
                        ),
                        SizedBox(
                          height: Dimensions.size40,
                        ),
                      ],
                    ),
                    //Body layout.
                    Expanded(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            //Blue top card.
                            Container(
                              padding: EdgeInsets.all(Dimensions.size20),
                              decoration: BoxDecoration(
                                color: ThemeColors().color6.withOpacity(0.1),
                                borderRadius:
                                    BorderRadius.circular(Dimensions.size25),
                              ),
                              height: Dimensions.size120,
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Today',
                                    style: TextStyle(
                                      color: ThemeColors().color2,
                                      fontSize: Dimensions.size15,
                                    ),
                                  ),
                                  SizedBox(
                                    height: Dimensions.size5,
                                  ),
                                  Text(
                                    currentDate,
                                    style: TextStyle(
                                      color: ThemeColors().color2,
                                      fontSize: Dimensions.size30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.size25,
                            ),
                            //In progress section.
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Sensor Indicators',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: Dimensions.size20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              
                                Container(
                                  height: Dimensions.size25,
                                  width: Dimensions.size130,
                                  decoration: BoxDecoration(
                                    color:
                                        ThemeColors().color5.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.size10),
                                  ),
                                  child: StreamBuilder(
                                    stream: _firestore
                                        .collection(_auth.currentUser!.uid)
                                        .doc('user_data')
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Container();
                                      } else {
                                        final data = snapshot.data!['sensors'];
                                        // Shows if a sensor is connected only if it reported the last measurement in the last half hour
                                        for (var i = 0;
                                            i < sensors.length;
                                            i++) {
                                          if (data[sensors[i]]['time'] == "") {
                                            availableSensor.remove(sensors[i]);
                                            continue;
                                          }
                                          var lastMeasurement = DateTime.parse(
                                              data[sensors[i]]['time']
                                                  .toString());
                                          if (DateTime.now().isAfter(
                                              lastMeasurement.add(
                                                  const Duration(
                                                      minutes: 30)))) {
                                            availableSensor.remove(sensors[i]);
                                          } else {
                                            if (!availableSensor
                                                .contains(sensors[i])) {
                                              availableSensor.add(sensors[i]);
                                            }
                                          }
                                        }
                                        return Center(
                                          child: Text(
                                            '${availableSensor.length} connected',
                                            style: TextStyle(
                                              color: ThemeColors().color2,
                                              fontSize: Dimensions.size15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Dimensions.size10,
                            ),
                            //In progress Stream bulder.
                            SizedBox(
                              height: Dimensions.size140,
                              child: StreamBuilder(
                                stream: _firestore
                                    .collection(_auth.currentUser!.uid)
                                    .doc('user_data')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Container();
                                  } else {
                                    final data = snapshot.data!['sensors'];
                                    return ListView.builder(
                                      itemCount: sensors.length,
                                      physics: BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: ((context, index) {
                                        var time;
                                        if (data[sensors[index]]['time'] ==
                                            "") {
                                          time = "";
                                        } else {
                                          var a = DateTime.parse(
                                              data[sensors[index]]['time']);
                                          time =
                                              DateFormat('dd-MM-yyy HH:mm:ss')
                                                  .format(a);
                                        }
                                        return CustomContainer(
                                          title:
                                              getSensorTitle(sensors[index]),
                                          measurement: [
                                            data[sensors[index]]['status'],
                                            
                                          ],
                                          createDate: time,
                                          sensor: data[sensors[index]],
                                        );
                                      }),
                                    );
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.size10,
                            ),
                            Row(children: [

                            Text(
                              'Notifications',
                             
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: Dimensions.size20,
                                  fontWeight: FontWeight.bold,),
                            ),
                            ],),
                            SizedBox(height: Dimensions.size5,),
                            SizedBox(
                              height: Dimensions.size240,
                              child: StreamBuilder(
                                stream: _firestore
                                    .collection(_auth.currentUser!.uid)
                                    .doc('user_data')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Container();
                                  } else {
                                    final data =
                                        snapshot.data!['notifications'];
                                    return CustomNotification(
                                      notifications: data,
                                      count: 5,
                                      fontSize: Dimensions.size15,
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }));
  }
}
