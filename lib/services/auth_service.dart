import 'package:firebase_auth/firebase_auth.dart';
import 'package:recycle_game/services/firestore_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isGuest = false;

  Stream<User?> get user => _auth.authStateChanges();

  // Email ve Şifre ile Giriş
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      print("Giriş denemesi başladı: $email");
      
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Kullanıcı Firestore'da var mı kontrol et
      final user = userCredential.user;
      if (user != null) {
        print("Firebase Auth girişi başarılı, Firestore kontrolü yapılıyor...");
        final firestoreService = FirestoreService();
        final userDoc = await firestoreService.getUserProfile(user.uid);
        
        if (userDoc == null) {
          print("Kullanıcı Firestore'da bulunamadı: ${user.uid}");
          await _auth.signOut();
          throw Exception('Kullanıcı bulunamadı. Lütfen kayıt olun.');
        }
        
        print("Kullanıcı Firestore'da bulundu: ${userDoc['displayName']}");
        isGuest = false;
        return user;
      }
      
      return null;
    } on FirebaseAuthException catch (e) {
      print("Firebase Auth hatası: ${e.code} - ${e.message}");
      switch (e.code) {
        case 'invalid-credential':
          throw Exception('Email veya şifre hatalı.');
        case 'user-not-found':
          throw Exception('Bu email ile kayıtlı kullanıcı bulunamadı.');
        case 'wrong-password':
          throw Exception('Şifre hatalı.');
        case 'invalid-email':
          throw Exception('Geçersiz email adresi.');
        case 'user-disabled':
          throw Exception('Bu hesap devre dışı bırakılmış.');
        default:
          throw Exception('Giriş yapılırken bir hata oluştu: ${e.message}');
      }
    } catch (e) {
      print("Giriş yaparken beklenmeyen hata: $e");
      throw Exception('Beklenmeyen bir hata oluştu. Lütfen tekrar deneyin.');
    }
  }

  Future<User?> registerWithEmail(String email, String password) async {
    try {
      print("Kayıt denemesi başladı: $email");
      
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      final user = userCredential.user;
      if (user != null) {
        print("Firebase Auth kaydı başarılı, Firestore profili oluşturuluyor...");
        // Yeni kullanıcı için Firestore profili oluştur
        await FirestoreService().createUserProfile(
          uid: user.uid,
          displayName: 'Player${user.uid.substring(0, 5)}',
        );
        print("Firestore profili oluşturuldu");
      }
      
      isGuest = false;
      return user;
    } on FirebaseAuthException catch (e) {
      print("Firebase Auth hatası: ${e.code} - ${e.message}");
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
      print("Kayıt olurken beklenmeyen hata: $e");
      throw Exception('Beklenmeyen bir hata oluştu. Lütfen tekrar deneyin.');
    }
  }
  
  Future<User?> signInAsGuest() async {
      try {
        final userCredential = await _auth.signInAnonymously();
        isGuest = true;
        return userCredential.user;
      } catch (e) {
        print("Misafir olarak giriş yaparken hata: $e");
        return null;
      }
  }

  Future<void> setRememberMe(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rememberMe', value);
  }

  Future<bool> getRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('rememberMe') ?? false;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await setRememberMe(false); 
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