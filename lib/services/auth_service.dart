// lib/services/auth_service.dart
// Manages Firebase Authentication.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:recycle_game/services/firestore_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get user => _auth.authStateChanges();

  Future<User?> getOrCreateUser() async {
    if (_auth.currentUser != null) {
      return _auth.currentUser;
    }
    
    // Try to sign in anonymously
    try {
      final userCredential = await _auth.signInAnonymously();
      final user = userCredential.user;
      if (user != null) {
        // Create a default profile in Firestore if it doesn't exist
        await FirestoreService().createUserProfile(
          uid: user.uid,
          displayName: 'Player${user.uid.substring(0, 5)}',
        );
      }
      return user;
    } catch (e) {
      print("Error signing in anonymously: $e");
      // If anonymous auth fails, try to get the current user or return null
      return _auth.currentUser;
    }
  }

  Future<void> updateDisplayName(String newName) async {
    if (_auth.currentUser != null) {
      await FirestoreService().updateUserProfile(
        uid: _auth.currentUser!.uid,
        displayName: newName,
      );
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}