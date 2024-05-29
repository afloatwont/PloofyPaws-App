import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:restoe/services/repositories/auth/base_repository.dart';
import 'package:restoe/services/repositories/auth/model.dart' as models;

final authRepositoryProvider = Provider((ref) => AuthRepository());

class AuthRepository extends BaseRepository {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  models.UserData? _userData;

  models.UserData? get userData => _userData;

  Future<models.UserData> login({required PostData data}) async {
    try {
      final response = await provider.post('/v1/auth/login', data: data);

      return models.UserData.fromJson(response.data);
    } catch (e) {
      return Future.error(e);
    }
  }


  Future<models.UserData?> signInWithGoogle() async {
    if (_userData != null) {
      return _userData;
    }

    try {
      final user = await _googleSignIn.signIn  ();

      if (user == null) {
        return Future.error('Google sign in failed');
      }

      print(user);

      _userData = models.UserData(
        id: user.id,
        email: user.email,
        displayName: user.displayName ?? '',
        photoUrl: user.photoUrl ?? '',
        serverAuthCode: user.serverAuthCode ?? '',
      );

      return _userData;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<models.UserData> signUp({required PostData data}) async {
    try {
      final response = await provider.post('/v1/auth/signup', data: data);
      return models.UserData.fromJson(response.data);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> googleSignOut() async {
    try {
      await _googleSignIn.signOut();
      await _googleSignIn.disconnect();

      _userData = null;
    } catch (e) {
      return Future.error(e);
    }
  }
}
