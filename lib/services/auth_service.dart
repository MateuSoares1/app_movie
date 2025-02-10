import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  AuthService._internal();
  factory AuthService() => _instance;
  static final AuthService _instance = AuthService._internal();

  User? user;

  Future<void> init() async {
    FirebaseAuth.instance.authStateChanges().listen((userData) {
      if (userData != null) {
        user = userData;
      }
    });
  }

  Future<bool> signInWithGoogle() async {
    try {
      final googleSingIn = await GoogleSignIn().signIn();
      final googleAuth = await googleSingIn?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final credentialUser = await FirebaseAuth.instance.signInWithCredential(credential);

      if (credentialUser.user != null) {
        user = credentialUser.user!;
      }

      return true;
    } on Exception catch (error) {
      print('===== Auth Service =====');
      print('* signInWithGoogle *');
      print(error);
      print('===========================');
      return false;
    }
  }

  Future<bool> signOutFromGoogle() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }
}
