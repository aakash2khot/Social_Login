// Import necessary packages and dependencies
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/sign_up_page.dart';
import 'package:flutter_firebase/features/user_auth/presentation/widgets/form_container_widget.dart';
import 'package:flutter_firebase/global/common/toast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

import '../../firebase_auth_implementation/firebase_auth_services.dart';

// Define the LoginPage widget
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

// Define the state for the LoginPage
class _LoginPageState extends State<LoginPage> {
  // Boolean flag to track if the user is currently signing in
  bool _isSigning = false;

  // Instances of FirebaseAuthService and FirebaseAuth
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Controllers for handling email and password input
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  // Dispose method to clean up resources when the widget is disposed
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Build method to construct the UI of the LoginPage
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Social Login App"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login here!",
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              // FormContainerWidget for email input
              FormContainerWidget(
                controller: _emailController,
                hintText: "Email",
                isPasswordField: false,
              ),
              SizedBox(
                height: 10,
              ),
              // FormContainerWidget for password input
              FormContainerWidget(
                controller: _passwordController,
                hintText: "Password",
                isPasswordField: true,
              ),
              SizedBox(
                height: 30,
              ),
              // GestureDetector for tapping on the Login button
              GestureDetector(
                onTap: () {
                  _signIn();
                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: _isSigning ? CircularProgressIndicator(
                      color: Colors.white,) : Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              // GestureDetector for tapping on the Google Sign-In button
              GestureDetector(
                onTap: () {
                  _signInWithGoogle();
                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(FontAwesomeIcons.google, color: Colors.white,),
                        SizedBox(width: 5,),
                        Text(
                          "Sign in with Google",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // GestureDetector for tapping on the Facebook Sign-In button
              GestureDetector(
                onTap: () {
                  _signInWithFacebook();
                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(FontAwesomeIcons.facebook, color: Colors.white,),
                        SizedBox(width: 5,),
                        Text(
                          "Sign in with Facebook",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              // Row for suggesting to sign up if not registered
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to the SignUpPage
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                            (route) => false,
                      );
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to handle the user sign-in process
  void _signIn() async {
    // Set the flag to indicate signing in
    setState(() {
      _isSigning = true;
    });

    // Get email and password from controllers
    String email = _emailController.text;
    String password = _passwordController.text;

    // Sign in with email and password
    User? user = await _auth.signInWithEmailAndPassword(email, password);

    // Reset the flag after sign-in attempt
    setState(() {
      _isSigning = false;
    });

    // Check if sign-in was successful and navigate to home page
    if (user != null) {
      showToast(message: "User is successfully signed in");
      Navigator.pushNamed(context, "/home");
    } else {
      showToast(message: "Some error occurred");
    }
  }

  // Method to handle Google sign-in
  _signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      // Sign out from Google to ensure a clean sign-in process
      await _googleSignIn.signOut();

      // Initiate Google sign-in
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      // Check if Google sign-in was successful
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        // Sign in with the Google credential
        UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);

        // Check if user sign-in was successful
        if (userCredential.user != null) {
          showToast(message: "User is successfully signed in with Google");
          Navigator.pushNamed(context, "/home");
        } else {
          showToast(message: "Google sign-in failed");
          // Handle the case where Google sign-in failed
        }
      }
    } catch (e) {
      showToast(message: "Some error occurred $e");
    }
  }

  // Method to handle Facebook sign-in
  _signInWithFacebook() async {
    // Perform Facebook login with specified permissions
    final LoginResult loginResult = await FacebookAuth.instance.login(
        permissions: ['email']
    );

    // Obtain OAuth credential from Facebook login result
    final OAuthCredential credential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Sign in with the Facebook credential
    UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);

    // Check if user sign-in was successful
    if (userCredential.user != null) {
      showToast(message: "User is successfully signed in with Facebook");
      Navigator.pushNamed(context, "/home");
    } else {
      showToast(message: "Facebook sign-in failed");
      // Handle the case where Facebook sign-in failed
    }
  }
}
