// Import necessary packages and dependencies
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Import common toast functionality
import '../../../../global/common/toast.dart';

// Define the HomePage widget
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// Define the state for the HomePage
class _HomePageState extends State<HomePage> {
  // Default welcome message for the user
  String welcomeMessage = "Hello there, Home Explorer!";

  // Build method to construct the UI of the HomePage
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
          // GestureDetector for tapping on the Sign Out button
          GestureDetector(
            onTap: () async {
              // Sign out from Google and Firebase
              await GoogleSignIn().signOut();
              FirebaseAuth.instance.signOut();
              // Navigate to the login page and show a sign-out success toast
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
          ),
        ],
      ),
    );
  }

  // Initialize the state of the widget
  @override
  void initState() {
    super.initState();
    // Set the welcome message when the widget is initialized
    setWelcomeMessage();
  }

  // Method to set the welcome message based on the user's sign-in method
  void setWelcomeMessage() {
    // Get the current user from Firebase
    User? user = FirebaseAuth.instance.currentUser;
    
    // Check if the user is signed in
    if (user != null) {
      // User is signed in, customize the welcome message based on sign-in method
      if (user.providerData.isNotEmpty) {
        // Check the first sign-in method used by the user
        String signInMethod = user.providerData[0].providerId;

        // Switch case to determine the sign-in method and set the welcome message accordingly
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
          // Add more cases for additional sign-in methods if needed
        }
      }
    }
  }
}
