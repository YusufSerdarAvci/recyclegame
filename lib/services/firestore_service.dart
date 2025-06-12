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
    try {
      final doc = await _db.collection('users').doc(uid).get();
      Map<String, dynamic> currentStars = {};
      
      if (doc.exists && doc.data() != null) {
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

      await _db.collection('users').doc(uid).update({
        'levelStars': currentStars,
        'lastUpdated': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Level yıldızları güncellenirken hata: $e");
      throw Exception('Level yıldızları kaydedilemedi. Lütfen tekrar deneyin.');
    }
  }

  Future<void> updateUserSettings(String uid, Map<String, dynamic> settings) async {
    await _db.collection('users').doc(uid).update(settings);
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