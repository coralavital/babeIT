import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:babe_it/widgets/list_container.dart';

class ProjectsList extends StatefulWidget {
  const ProjectsList({super.key});

  @override
  State<ProjectsList> createState() => _ProjectsListState();
}

class _ProjectsListState extends State<ProjectsList> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List<String> sensors = [
    'heart_rate_sensor',
    'infrared_sensor',
    'sound_sensor'
  ];

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
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(_auth.currentUser!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    } else {
                      return ListView.builder(
                        itemCount: 3,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: ((context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: ListContainer(
                              elementList:
                                  snapshot.data!['Sensors'][sensors[index]]['history'],
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
