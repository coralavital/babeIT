import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:babe_it/widgets/list_container.dart';

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
        toolbarHeight: 15,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              //Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'History',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
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
                            padding: const EdgeInsets.only(bottom: 10),
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
