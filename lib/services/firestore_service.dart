// lib/services/firestore_service.dart
// Manages all Firestore database operations.

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Create or update a user profile
  Future<void> createUserProfile({required String uid, required String displayName}) async {
    final userDoc = _db.collection('users').doc(uid);
    final snapshot = await userDoc.get();
    if (!snapshot.exists) {
      return userDoc.set({'displayName': displayName, 'createdAt': FieldValue.serverTimestamp()});
    }
  }

  // Update user profile
  Future<void> updateUserProfile({required String uid, required String displayName}) async {
    return _db.collection('users').doc(uid).update({'displayName': displayName});
  }
  
  // Get a user's display name
  Future<String> getDisplayName(String uid) async {
    try {
      DocumentSnapshot doc = await _db.collection('users').doc(uid).get();
      return (doc.data() as Map<String, dynamic>)['displayName'] ?? 'Player';
    } catch (e) {
      return 'Player';
    }
  }

  // Submit a score to the leaderboard
  Future<void> submitScore({required String uid, required int score}) async {
    String displayName = await getDisplayName(uid);
    await _db.collection('leaderboard').add({
      'uid': uid,
      'displayName': displayName,
      'score': score,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // Get the leaderboard stream
  Stream<QuerySnapshot> getLeaderboard() {
    return _db.collection('leaderboard').orderBy('score', descending: true).limit(100).snapshots();
  }
}