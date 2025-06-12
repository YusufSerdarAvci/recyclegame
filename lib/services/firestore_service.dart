// lib/services/firestore_service.dart
// Manages all Firestore database operations.

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createUserProfile({required String uid, required String displayName}) async {
    final userDoc = _db.collection('users').doc(uid);
    final snapshot = await userDoc.get();
    if (!snapshot.exists) {
      return userDoc.set({
        'displayName': displayName,
        'createdAt': FieldValue.serverTimestamp(),
        'totalScore': 0, 
        'levelStars': {}, 
      });
    }
  }

  Future<void> updateUserProfile({required String uid, required String displayName}) async {
    return _db.collection('users').doc(uid).update({'displayName': displayName});
  }
  
  Future<String> getDisplayName(String uid) async {
    try {
      DocumentSnapshot doc = await _db.collection('users').doc(uid).get();
      return (doc.data() as Map<String, dynamic>)['displayName'] ?? 'Player';
    } catch (e) {
      return 'Player';
    }
  }

  Future<void> submitScore({required String uid, required int score}) async {
    String displayName = await getDisplayName(uid);
    await _db.collection('leaderboard').doc(uid).set({
      'displayName': displayName,
      'score': FieldValue.increment(score), 
    }, SetOptions(merge: true));
  }
  
  Future<Map<String, dynamic>?> getUserProfile(String uid) async {
    try {
      print("Firestore'dan kullanıcı profili alınıyor: $uid");
      final doc = await _db.collection('users').doc(uid).get();
      
      if (!doc.exists) {
        print("Kullanıcı dokümanı bulunamadı: $uid");
        return null;
      }
      
      final data = doc.data();
      if (data == null) {
        print("Kullanıcı dokümanı boş: $uid");
        return null;
      }
      
      print("Kullanıcı profili başarıyla alındı: ${data['displayName']}");
      return data;
    } catch (e) {
      print("Kullanıcı profili alınırken hata: $e");
      return null;
    }
  }

  Future<Map<String, dynamic>> getUserProgress(String uid) async {
    try {
      final doc = await _db.collection('users').doc(uid).get();
      if (doc.exists && doc.data() != null) {
        return {
          'levelStars': doc.data()!['levelStars'] ?? {},
          'totalScore': doc.data()!['totalScore'] ?? 0,
        };
      }
    } catch (e) {
      print("Kullanıcı verisi alınırken hata: $e");
    }
    return {'levelStars': {}, 'totalScore': 0};
  }

  Future<void> updateUserLevelStars(String uid, Map<int, int> stars) async {
    final starData = stars.map((key, value) => MapEntry(key.toString(), value));
    await _db.collection('users').doc(uid).set({
      'levelStars': starData
    }, SetOptions(merge: true));
  }

  Stream<QuerySnapshot> getLeaderboard() {
    return _db.collection('leaderboard').orderBy('score', descending: true).limit(100).snapshots();
  }
}