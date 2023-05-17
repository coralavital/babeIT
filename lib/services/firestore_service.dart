import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String _babyName;
  late String _gender;
  late String _height;
  late String _width;
  late String _age;

  Future<List> getBabyInfo() async {
    QuerySnapshot querySnapshot;
    try {
      querySnapshot = await _firestore.collection(_auth.currentUser!.uid).get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          if (doc.id == 'user_data') {
            _babyName = doc['baby_information']['name'];
            _gender = doc['baby_information']['gender'];
            _height = doc['baby_information']['height'];
            _width = doc['baby_information']['width'];
            _age = doc['baby_information']['width'];
          }
        }
        return [_babyName, _gender, _height, _width, _age];
      }
    } catch (e) {
      print(e);
    }
    return [_babyName, _gender, _height, _width, _age];
  }

  Future<String> addBabyInfo(String name, String gender, String age,
      String height, String width) async {
    if (gender == "" || gender == 'Boy') {
      gender == 'boy';
    } else {
      gender == 'girl';
    }
    try {
      await _firestore
          .collection('${_auth.currentUser?.uid}')
          .doc('user_data')
          .update(
        {
          'baby_information': (
            {
              "name": name,
              "gender": gender,
              "height": height,
              'width': width,
              'age': age
            }
        )
        },
      );
    } catch (e) {
      return e.toString();
    }
    return 'success';
  }
}
