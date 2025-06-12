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
        'musicVolume': 1.0,
        'sfxVolume': 1.0,
        'languageCode': 'en',
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
      final doc = await _db.collection('users').doc(uid).get();
      
      if (!doc.exists) {
        return null;
      }
      
      final data = doc.data();
      if (data == null) {
        return null;
      }
      
      return data;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>> getUserProgress(String uid) async {
    try {
      final doc = await _db.collection('users').doc(uid).get();
      if (doc.exists && doc.data() != null) {
        final data = doc.data()!;
        return {
          'levelStars': data['levelStars'] ?? {},
          'totalScore': data['totalScore'] ?? 0,
          'musicVolume': data['musicVolume'] ?? 1.0,
          'sfxVolume': data['sfxVolume'] ?? 1.0,
          'languageCode': data['languageCode'] ?? 'en',
        };
      }
    } catch (e) {
      rethrow;
    }
    return {
      'levelStars': {},
      'totalScore': 0,
      'musicVolume': 1.0,
      'sfxVolume': 1.0,
      'languageCode': 'en',
    };
  }

  Future<void> updateUserLevelStars(String uid, Map<int, int> stars) async {
    try {
      final docRef = _db.collection('users').doc(uid);
      final doc = await docRef.get();
      Map<String, dynamic> currentStars = {};

      if (!doc.exists) {
        await docRef.set({
          'levelStars': stars.map((k, v) => MapEntry(k.toString(), v)),
          'createdAt': FieldValue.serverTimestamp(),
          'lastUpdated': FieldValue.serverTimestamp(),
        });
        return;
      }

      if (doc.data() != null) {
        final data = doc.data()!;
        if (data.containsKey('levelStars')) {
          currentStars = Map<String, dynamic>.from(data['levelStars']);
        }
      }

      stars.forEach((level, starCount) {
        final currentStarCount = int.tryParse(currentStars[level.toString()]?.toString() ?? '0') ?? 0;
        if (starCount > currentStarCount) {
          currentStars[level.toString()] = starCount;
        }
      });

      await docRef.update({
        'levelStars': currentStars,
        'lastUpdated': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Level yıldızları kaydedilemedi. Lütfen tekrar deneyin.');
    }
  }

  Future<void> updateUserSettings(String uid, Map<String, dynamic> settings) async {
    try {
      final userDoc = _db.collection('users').doc(uid);
      final doc = await userDoc.get();
      
      if (!doc.exists) {
        await userDoc.set({
          ...settings,
          'createdAt': FieldValue.serverTimestamp(),
          'lastUpdated': FieldValue.serverTimestamp(),
        });
      } else {
        await userDoc.update({
          ...settings,
          'lastUpdated': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      throw Exception('Ayarlar kaydedilemedi. Lütfen tekrar deneyin.');
    }
  }

  Stream<QuerySnapshot> getLeaderboard() {
    return _db.collection('leaderboard').orderBy('score', descending: true).limit(100).snapshots();
  }

  Future<void> saveLevelProgress({
    required String uid,
    required int level,
    required int stars,
    required int score,
  }) async {
    final userDoc = _db.collection('users').doc(uid);
    final levelKey = level.toString();

    // Yıldız ve skorun en yükseğini sakla
    final doc = await userDoc.get();
    Map<String, dynamic> currentStars = {};
    Map<String, dynamic> currentScores = {};

    if (doc.exists && doc.data() != null) {
      final data = doc.data()!;
      if (data.containsKey('levelStars')) {
        currentStars = Map<String, dynamic>.from(data['levelStars']);
      }
      if (data.containsKey('levelScores')) {
        currentScores = Map<String, dynamic>.from(data['levelScores']);
      }
    }

    final prevStars = int.tryParse(currentStars[levelKey]?.toString() ?? '0') ?? 0;
    final prevScore = int.tryParse(currentScores[levelKey]?.toString() ?? '0') ?? 0;

    if (stars > prevStars) currentStars[levelKey] = stars;
    if (score > prevScore) currentScores[levelKey] = score;

    await userDoc.set({
      'levelStars': currentStars,
      'levelScores': currentScores,
      'lastUpdated': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }
}