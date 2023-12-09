import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../global/common/toast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String welcomeMessage = "Hello there, Home Explorer!";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Social Login App"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              welcomeMessage,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () async {
              await GoogleSignIn().signOut();
              FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, "/login");
              showToast(message: "Successfully signed out");
            },
            child: Container(
              height: 45,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "Sign out",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setWelcomeMessage();
  }

  void setWelcomeMessage() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // User is signed in, customize the welcome message based on sign-in method
      if (user.providerData.isNotEmpty) {
        // Check the first sign-in method used by the user
        String signInMethod = user.providerData[0].providerId;

        switch (signInMethod) {
          case 'google.com':
            setState(() {
              welcomeMessage = "Welcome back, Google Explorer!";
            });
            break;
          case 'facebook.com':
            setState(() {
              welcomeMessage = "Greetings, Facebook Voyager!";
            });
            break;
          case 'password':
            setState(() {
              welcomeMessage = "Hi there, Email Trailblazer!";
            });
            break;
          
        }
      }
    }
  }
}
