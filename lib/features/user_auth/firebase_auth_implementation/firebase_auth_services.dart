import 'package:firebase_auth/firebase_auth.dart';

import '../../../global/common/toast.dart';

// Service class for Firebase Authentication
class FirebaseAuthService {

  FirebaseAuth _auth = FirebaseAuth.instance;

  // Method for user registration
  Future<User?> signUpWithEmailAndPassword(String email, String password) async {

    try {
      // Create a new user with email and password
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {

      // Handle specific exceptions during the registration process
      if (e.code == 'email-already-in-use') {
        showToast(message: 'The email address is already in use.');
      } else {
        showToast(message: 'An error occurred: ${e.code}');
      }
    }
    return null;

  }

  // Method for user login
  Future<User?> signInWithEmailAndPassword(String email, String password) async {

    try {
      // Sign in user with email and password
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {

      // Handle specific exceptions during the login process
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        showToast(message: 'Invalid email or password.');
      } else {
        showToast(message: 'An error occurred: ${e.code}');
      }

    }
    return null;

  }

}
