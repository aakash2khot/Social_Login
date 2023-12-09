import 'package:flutter/material.dart';

// Define SplashScreen widget
class SplashScreen extends StatefulWidget {
  final Widget? child;

  // Constructor with optional child parameter
  const SplashScreen({super.key, this.child});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// Define the state for SplashScreen
class _SplashScreenState extends State<SplashScreen> {
  // initState method is called when the state is initialized
  @override
  void initState() {
    // Delayed navigation to the child widget after 3 seconds
    Future.delayed(
      Duration(seconds: 3),
      () {
        // Navigate to the child widget and remove the splash screen from the navigation stack
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => widget.child!),
            (route) => false);
      },
    );
    super.initState();
  }

  // Build method to construct the UI of the SplashScreen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Welcome To My Social Login App",
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),
      ),
    );
  }
}
