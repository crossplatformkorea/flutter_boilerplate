import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final auth = FirebaseAuth.instance;

  Future<UserCredential> signInWithCustomToken(String token) async {
    return auth.signInWithCustomToken(token);
  }
}
