import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../models/bowling_throw.dart';

class ThrowService {
  static Future<void> saveThrow(BowlingThrow throwData) async {
    debugPrint('DEBUG: saveThrow() called');
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      debugPrint('DEBUG: No authenticated user, throw NOT saved');
      return;
    }

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('throws')
        .add(throwData.toMap());
    
    debugPrint('DEBUG: Throw saved for user ${user.uid}');
  }
}
