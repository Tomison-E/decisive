import 'package:firebase_auth/firebase_auth.dart';

class Api {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Api();

  Future<void> signUp(String email, String passsword) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: passsword);
  }

  Future<bool> signIn(String email, String password) async {
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    if (result != null) {
      return true;
    }
    return false;
  }


}