// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:babe_it/theme/theme_colors.dart';
import 'package:babe_it/widgets/custom_widget.dart';
import 'package:intl/intl.dart';

import '../../widgets/custom_notifications.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List? allNotifications;
  List availableSensor = [
    'heart_rate_sensor',
    'infrared_sensor',
    'sound_sensor'
  ];

  final List<String> sensors = [
    'heart_rate_sensor',
    'infrared_sensor',
    'sound_sensor'
  ];

  String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  getSensorTitle(String sensor) {
    if (sensor == 'heart_rate_sensor') {
      return "Hart Rate Sensor";
    } else if (sensor == 'infrared_sensor') {
      return "Infrared Sensor";
    } else {
      return 'Sound Sensor';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        toolbarHeight: 15,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            //Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(_auth.currentUser!.uid)
                      .snapshots(),
                  builder: ((context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    } else {
                      return Text(
                        'Hello, ${snapshot.data!.get('name')}',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: ThemeColors().welcome),
                      );
                    }
                  }),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            //Body layout.
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    //Blue top card.
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: ThemeColors().grey,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      height: 115,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Today',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            currentDate,
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    //In progress section.
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sensor Indicators',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Container(
                          height: 20,
                          width: 120,
                          decoration: BoxDecoration(
                            color: ThemeColors().grey.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc(_auth.currentUser!.uid)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Container();
                              } else {
                                // Shows if a sensor is connected only if it reported the last measurement in the last half hour
                                for (var i = 0; i < sensors.length; i++) {
                                  var lastMeasurement = DateTime.parse(
                                      snapshot.data!['Sensors'][sensors[i]]
                                          ['current_measurement']['time']);
                                  if (DateTime.now().isAfter(lastMeasurement
                                      .add(const Duration(minutes: 30)))) {
                                    availableSensor.remove(sensors[i]);
                                  } else {
                                    if(!availableSensor.contains(sensors[i])) {

                                    availableSensor.add(sensors[i]);
                                    }
                                  }
                                }
                                return Center(
                                  child: Text(
                                    '${availableSensor.length} connected',
                                    style: TextStyle(
                                      color: ThemeColors().main,
                                      fontSize: 14,
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
                      height: 20,
                    ),
                    //In progress Stream bulder.
                    Center(
                      child: SizedBox(
                        height: 140,
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .doc(_auth.currentUser!.uid)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Container();
                            } else {
                              return ListView.builder(
                                itemCount: sensors.length,
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: ((context, index) {
                                  var a = DateTime.parse(snapshot
                                      .data!['Sensors'][sensors[index]]
                                          ['current_measurement']['time']
                                      .toString());
                                  var time =
                                      DateFormat('dd/MM/yyyy HH:mm').format(a);
                                  return CustomContainer(
                                    title: getSensorTitle(sensors[index]),
                                    measurement: snapshot.data!['Sensors']
                                            [sensors[index]]
                                        ['current_measurement']['measurement'],
                                    createDate: time,
                                    sensor: snapshot.data!['Sensors']
                                        [sensors[index]]['current_measurement'],
                                  );
                                }),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 200,
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(_auth.currentUser!.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Container();
                          } else {
                            List<dynamic> list =
                                snapshot.data!['notifications'];
                            return CustomNotification(
                              notifications: list,
                              count: 5,
                              fontSize: 15,
                              title: 'Notifications',
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
      ),
    );
  }
}
