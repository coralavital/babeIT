import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

String boyIcon =
    'https://firebasestorage.googleapis.com/v0/b/babeit.appspot.com/o/avatar%2Fbaby_boy.png?alt=media&token=5db781eb-16f8-4280-8e28-20855ca8003b';
String girlcon =
    'https://firebasestorage.googleapis.com/v0/b/babeit.appspot.com/o/avatar%2Fbaby_girl.png?alt=media&token=8f187d55-fac3-4e0d-8cd2-72eb3824406f';

class FirebaseFirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String _babyName;
  late String _gender;
  late String _height;
  late String _weight;
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
            _weight = doc['baby_information']['weight'];
            _age = doc['baby_information']['width'];
          }
        }
        return [_babyName, _gender, _height, _weight, _age];
      }
    } catch (e) {
      print(e);
    }
    return [_babyName, _gender, _height, _weight, _age];
  }

  Future<String> addBabyInfo(String name, String gender, String age,
      String height, String weight) async {
    String babyIcon;
    if (gender == "" || gender == 'Boy') {
      gender == 'boy';
      babyIcon = boyIcon;
    } else {
      gender == 'girl';
      babyIcon = girlcon;
    }
    try {
      await _firestore
          .collection('${_auth.currentUser?.uid}')
          .doc('user_data')
          .update(
        {
          'baby_information': ({
            "name": name,
            "gender": gender,
            "height": height,
            'weight': weight,
            'age': age,
            'baby_icon': babyIcon
          })
        },
      );
    } catch (e) {
      return e.toString();
    }
    return 'success';
  }
}
