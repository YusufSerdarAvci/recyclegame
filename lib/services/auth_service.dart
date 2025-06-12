import 'package:firebase_auth/firebase_auth.dart';
import 'package:recycle_game/services/firestore_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isGuest = false;
  static const String _guestUserIdKey = 'guest_user_id';

  Stream<User?> get user => _auth.authStateChanges();

  Future<User?> signInWithEmail(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      if (user != null) {
        final firestoreService = FirestoreService();
        final userDoc = await firestoreService.getUserProfile(user.uid);
        if (userDoc == null) {
          await _auth.signOut();
          throw Exception('Kullanıcı bulunamadı. Lütfen kayıt olun.');
        }
        isGuest = false;
        return user;
      }
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('errorUserNotFound');
      } else if (e.code == 'wrong-password') {
        throw Exception('errorInvalidCredentials');
      } else if (e.code == 'invalid-email') {
        throw Exception('errorInvalidEmail');
      } else if (e.code == 'user-disabled') {
        throw Exception('Kullanıcı devre dışı.');
      } else if (e.code == 'too-many-requests') {
        throw Exception('errorTooManyRequests');
      } else if (e.code == 'network-request-failed') {
        throw Exception('errorNetworkRequestFailed');
      } else {
        throw Exception(e.message ?? 'Giriş hatası');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> registerWithEmail(String email, String password) async {
    try {
      
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      final user = userCredential.user;
      if (user != null) {
        await FirestoreService().createUserProfile(
          uid: user.uid,
          displayName: 'Player${user.uid.substring(0, 5)}',
        );
      }
      
      isGuest = false;
      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw Exception('Bu email adresi zaten kullanımda.');
        case 'invalid-email':
          throw Exception('Geçersiz email adresi.');
        case 'operation-not-allowed':
          throw Exception('Email/şifre girişi devre dışı bırakılmış.');
        case 'weak-password':
          throw Exception('Şifre çok zayıf. Daha güçlü bir şifre seçin.');
        default:
          throw Exception('Kayıt olurken bir hata oluştu: ${e.message}');
      }
    } catch (e) {
      throw Exception('Beklenmeyen bir hata oluştu. Lütfen tekrar deneyin.');
    }
  }
  
  Future<User?> signInAsGuest() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedGuestId = prefs.getString(_guestUserIdKey);
      
      final currentUser = _auth.currentUser;
      if (currentUser != null) {
        if (savedGuestId == currentUser.uid) {
          isGuest = true;
          return currentUser;
        }
        await _auth.signOut();
      }

      final userCredential = await _auth.signInAnonymously();
      if (userCredential.user != null) {
        await prefs.setString(_guestUserIdKey, userCredential.user!.uid);
        isGuest = true;
        return userCredential.user;
      }
      
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> checkIfGuest() async {
    final prefs = await SharedPreferences.getInstance();
    final savedGuestId = prefs.getString(_guestUserIdKey);
    final currentUser = _auth.currentUser;
    
    if (currentUser != null && savedGuestId == currentUser.uid) {
      isGuest = true;
      return true;
    }
    
    isGuest = false;
    return false;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    isGuest = false;
  }

  Future<void> updateDisplayName(String displayName) async {
    if (isGuest) return;
    final currentUser = await user.first;
    if (currentUser != null) {
      await FirestoreService().updateUserProfile(uid: currentUser.uid, displayName: displayName);
    }
  }
}