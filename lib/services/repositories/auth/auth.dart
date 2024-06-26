import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ploofypaws/services/repositories/auth/base_repository.dart';
import 'package:ploofypaws/services/repositories/auth/model.dart' as models;

final authRepositoryProvider = Provider((ref) => AuthRepository());

class AuthRepository extends BaseRepository {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  models.UserData? _userData;

  models.UserData? get userData => _userData;

  Future<models.UserData> login({required PostData data}) async {
    try {
      final response = await provider.post('/v1/auth/login', data: data);
      final user = response.data;

      // Firebase login
      await _firebaseAuth.signInWithEmailAndPassword(
        email: user['email'],
        password: data['password'],
      );

      return models.UserData.fromJson(user);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<models.UserData?> signInWithGoogle() async {
    if (_userData != null) {
      return _userData;
    }

    try {
      final googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return Future.error('Google sign in failed');
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      final firebaseUser = userCredential.user;

      if (firebaseUser == null) {
        return Future.error('Firebase sign in failed');
      }

      _userData = models.UserData(
        id: firebaseUser.uid,
        email: firebaseUser.email ?? '',
        displayName: firebaseUser.displayName ?? '',
        photoUrl: firebaseUser.photoURL ?? '',
        serverAuthCode: googleUser.serverAuthCode ?? '',
      );

      return _userData;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<models.UserData> signUp({required PostData data}) async {
    try {
      // final response = await provider.post('/v1/auth/signup', data: data);
      // final user = response.data;

      // Firebase signup
      print(data);
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: data['email'],
        password: data['password'],
      );

      return models.UserData.fromJson({"email": "jjl"});
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> googleSignOut() async {
    try {
      await _googleSignIn.signOut();
      await _googleSignIn.disconnect();
      await _firebaseAuth.signOut();

      _userData = null;
    } catch (e) {
      return Future.error(e);
    }
  }
}
