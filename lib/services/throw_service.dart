import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/bowling_throw.dart';

class ThrowService {
  static Future<void> saveThrow(BowlingThrow throwData) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('throws')
        .add(throwData.toMap());
  }
}
