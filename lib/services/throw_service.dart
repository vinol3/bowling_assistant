import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/bowling_throw.dart';

class ThrowService {
  static Future<void> saveThrow(BowlingThrow throwData) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('throws')
        .add(throwData.toMap());
  }

  static Stream<List<BowlingThrow>> throwsStream() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return const Stream.empty();

    return FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('throws')
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
            .map((doc) => BowlingThrow.fromMap(doc.id, doc.data()))
            .toList(),
      );
  }

}
