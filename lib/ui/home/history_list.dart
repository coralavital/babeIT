import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:babe_it/widgets/list_container.dart';

import '../../utils/dimensions.dart';

class HistoryList extends StatefulWidget {
  const HistoryList({super.key});

  @override
  State<HistoryList> createState() => _HistoryList();
}

class _HistoryList extends State<HistoryList> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List<String> sensors = [
    'heart_rate_sensor',
    'sound_sensor'
  ];

  getSensorTitle(String sensor) {
    if (sensor == 'heart_rate_sensor') {
      return "Hart Rate Sensor";
    } else {
      return 'Sound Sensor';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        toolbarHeight: Dimensions.size15,
      ),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.size15),
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              //Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'History',
                    style: TextStyle(
                      fontSize: Dimensions.size30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Dimensions.size20,
              ),
              //Body
              Expanded(
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
                        itemCount: data.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: ((context, index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: Dimensions.size10),
                            child: ListContainer(
                              elementList: data[sensors[index]]
                                  ['history'] ?? [],
                              title: getSensorTitle(sensors[index]),
                            ),
                          );
                        }),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
