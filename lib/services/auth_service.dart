import 'package:firebase_auth/firebase_auth.dart';
import 'package:recycle_game/services/firestore_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isGuest = false;
  static const String _guestUserIdKey = 'guest_user_id';
  static const String _rememberMeKey = 'rememberMe';
  static const String _rememberedEmailKey = 'rememberedEmail';
  static const String _rememberedPasswordKey = 'rememberedPassword';

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
      print("Misafir olarak giriş yaparken hata: $e");
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

  Future<void> setRememberMe(bool value, {String? email, String? password}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_rememberMeKey, value);
    
    if (value && email != null && password != null) {
      await prefs.setString(_rememberedEmailKey, email);
      await prefs.setString(_rememberedPasswordKey, password);
    } else if (!value) {
      await prefs.remove(_rememberedEmailKey);
      await prefs.remove(_rememberedPasswordKey);
    }
  }

  Future<bool> getRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_rememberMeKey) ?? false;
  }

  Future<Map<String, String?>> getRememberedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'email': prefs.getString(_rememberedEmailKey),
      'password': prefs.getString(_rememberedPasswordKey),
    };
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