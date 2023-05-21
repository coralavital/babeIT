import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRes {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createAccount(
    String fullName,
    String email,
    String password,
  ) async {
    Map<String, dynamic> sensors = {
      'heart_rate_sensor': {
        'history': [],
        'current_measurement': '',
        'time': ''
      },
      'sound_sensor': {'history': [], 'current_measurement': '', 'time': ''}
    };

    String res = 'Some error accoured';
    if (fullName.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      try {
        await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await _firestore
            .collection(_auth.currentUser!.uid)
            .doc('user_data')
            .set({'name': fullName, 'email': email, 'sensors': sensors, 'notifications': []});
        res = 'success';
      } catch (error) {
        print(error);
        res = '$error';
      }
    } else {
      res = 'fill in all the fields';
    }
    return res;
  }

  Future<String> login(
    String email,
    String password,
  ) async {
    String res = 'Some error occured';
    if (email.isEmpty) {
      res = 'Enter your email';
    } else if (password.isEmpty) {
      res = 'Enter password';
    } else if (!email.contains('@')) {
      res = 'Email is invalid';
    } else {
      try {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } catch (error) {
        res = 'Error while trying to login';
      }
    }
    return res;
  }

  Future<String> resetPassword(String email) async {
    String res = 'Some error occured';
    if (email.isNotEmpty) {
      try {
        await _auth.sendPasswordResetEmail(email: email);
        res = 'success';
      } catch (error) {
        res = 'User not found';
      }
    } else {
      res = 'enter email';
    }
    return res;
  }
}
