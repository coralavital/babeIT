// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:babe_it/theme/theme_colors.dart';
import 'package:babe_it/widgets/custom_widget.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../theme/dimensions.dart';
import '../../widgets/custom_notifications.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List? allNotifications;
  late AnimationController controller;
  late Animation<double> animation;
  List availableSensor = ['haterate_sensor', 'infrared_sensor', 'sound_sensor'];

  final List<String> sensors = [
    'haterate_sensor',
    'infrared_sensor',
    'sound_sensor'
  ];

  String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  getSensorTitle(String sensor) {
    if (sensor == 'haterate_sensor') {
      return "Hart Rate Sensor";
    } else if (sensor == 'infrared_sensor') {
      return "Infrared Sensor";
    } else {
      return 'Sound Sensor';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
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
                  stream: _firestore
                      .collection(_auth.currentUser!.uid)
                      .doc('user_data')
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
                            stream: _firestore
                                .collection(_auth.currentUser!.uid)
                                .doc('user_data')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.data!['sensors'][0] != null) {
                                // Shows if a sensor is connected only if it reported the last measurement in the last half hour
                                for (var i = 0; i < sensors.length; i++) {
                                  if (snapshot.data!['sensors'][i][0] != null) {
                                    var lastMeasurement = DateTime.parse(
                                        snapshot.data!['sensors'][i]
                                            ['current_measurement']['time']);
                                    if (DateTime.now().isAfter(lastMeasurement
                                        .add(const Duration(minutes: 30)))) {
                                      availableSensor.remove(sensors[i]);
                                    } else {
                                      if (!availableSensor
                                          .contains(sensors[i])) {
                                        availableSensor.add(sensors[i]);
                                      }
                                    }
                                  } else {
                                    availableSensor = [];
                                  }
                                }
                                return Center(
                                  child: Text(
                                    '${availableSensor.length} connected',
                                    style: TextStyle(
                                      color: ThemeColors().main,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),

                    //In progress Stream bulder.
                    Center(
                      child: SizedBox(
                        height: 140,
                        child: StreamBuilder(
                          stream: _firestore
                              .collection(_auth.currentUser!.uid)
                              .doc('user_data')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.data!['sensors'] == null) {
                              return Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Column(children: [
                                    SizedBox(
                                      height: 70,
                                    ),
                                    AnimatedIcon(
                                      icon: AnimatedIcons.list_view,
                                      color: ThemeColors().main,
                                      progress: animation,
                                      size: 30,
                                      semanticLabel: 'Loadding',
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      'There is no products yet',
                                    ),
                                  ]));
                            } else {
                              return ListView.builder(
                                itemCount: sensors.length,
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: ((context, index) {
                                  if (snapshot.data!['sensors'][index][0] !=
                                      null) {
                                    var a = DateTime.parse(snapshot
                                        .data!['sensors'][index][0]
                                            ['current_measurement']['time']
                                        .toString());
                                    var time = DateFormat('dd/MM/yyyy HH:mm')
                                        .format(a);

                                    return CustomContainer(
                                      title: getSensorTitle(sensors[index]),
                                      measurement: snapshot.data!['sensors']
                                              [index][0]['current_measurement']
                                          ['measurement'],
                                      createDate: time,
                                      sensor: snapshot.data!['sensors'][index]
                                          [0]['current_measurement'],
                                    );
                                  } else {
                                    Container();
                                  }
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
                    Text(
                      'Notifications',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),

                    SizedBox(
                      height: 200,
                      child: StreamBuilder(
                        stream: _firestore
                            .collection(_auth.currentUser!.uid)
                            .doc('user_data')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.data!['notifications'] != null) {
                            return Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Column(children: [
                                  SizedBox(
                                    height: 70,
                                  ),
                                  AnimatedIcon(
                                    icon: AnimatedIcons.list_view,
                                    color: ThemeColors().main,
                                    progress: animation,
                                    size: 30,
                                    semanticLabel: 'Loadding',
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    'There is no products yet',
                                  ),
                                ]));
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
