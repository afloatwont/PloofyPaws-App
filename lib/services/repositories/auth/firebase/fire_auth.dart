import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/user_model.dart';

class AuthServices {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? _user;

  User? get user {
    return _user;
  }

  AuthService() {
    _firebaseAuth.authStateChanges().listen((event) {
      authStateChangesStream(event);
    });
  }

  void authStateChangesStream(User? user) {
    if (user != null) {
      _user = user;
    } else {
      _user = null;
    }
  }

  Future<UserModel> login(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        return UserModel(
          id: user.uid,
          email: user.email ?? '',
          displayName: user.displayName ?? '',
          photoUrl: user.photoURL ?? '',
        );
      } else {
        return Future.error('Login failed');
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<UserModel?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return Future.error('Google sign in failed');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      User? user = userCredential.user;
      if (user != null) {
        return UserModel(
          id: user.uid,
          email: user.email ?? '',
          displayName: user.displayName ?? '',
          photoUrl: user.photoURL ?? '',
        );
      } else {
        return Future.error('Google sign in failed');
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<UserModel?>? signUp(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        return UserModel(
          id: user.uid,
          email: user.email ?? '',
          displayName: user.displayName ?? '',
          photoUrl: user.photoURL ?? '',
        );
      } else {
        return null;
        // return Future.error('Sign up failed');
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      print(e);
      return false;
      // return Future.error(e);
    }
  }
}
