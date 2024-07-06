import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ploofypaws/services/alert/alert_service.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/models/user_model.dart';

class AuthServices {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  
  final _getIt = GetIt.instance;
  late AlertService _alertService;

  User? _user;

  User? get user {
    return _user;
  }

  AuthServices() {
    _alertService = _getIt.get<AlertService>();
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
        // _user = user;
        _alertService.showToast(text: "Login Successful");

        return UserModel(
          id: user.uid,
          email: user.email ?? '',
          displayName: user.displayName ?? '',
          photoUrl: user.photoURL ?? '',
        );
      } else {
        _alertService.showToast(text: "Login Failed");
        return Future.error('Login failed');
      }
    } catch (e) {
      _alertService.showToast(text: e.toString());
      return Future.error(e);
    }
  }

  Future<UserModel?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        _alertService.showToast(text: "Failed");
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
        // _user = user;

        _alertService.showToast(text: "Login Successful");
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
        // _user = user;
        _alertService.showToast(text: "Registration Successful");
        return UserModel(
          id: user.uid,
          email: user.email ?? '',
          displayName: user.displayName ?? '',
          photoUrl: user.photoURL ?? '',
        );
      } else {
        _alertService.showToast(text: "Login Failed");
        return null;
        // return Future.error('Sign up failed');
      }
    } catch (e) {
      _alertService.showToast(text: e.toString());
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
      
        _alertService.showToast(text: "Error");
      print(e);
      return false;
      // return Future.error(e);
    }
  }
}
