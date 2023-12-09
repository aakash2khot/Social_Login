import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:flutter_firebase/features/app/splash_screen/splash_screen.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/home_page.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/login_page.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/sign_up_page.dart';

// Main function to run the app
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase for web or other platforms
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyAvzsX-_A516B7TeVyaiK4uztOZiz47Mvg",
        appId: "1:1024867182845:web:2a994acfb2a6bdc598b694",
        messagingSenderId: "1024867182845",
        projectId: "sociallogin-da408",
        // Your web Firebase config options
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  // Run the app
  runApp(MyApp());
}

// MyApp class, extending StatelessWidget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Social Login',
      routes: {
        '/': (context) => SplashScreen(
          // Decide whether to show the LoginPage or HomePage based on user authentication
          child: LoginPage(),
        ),
        '/login': (context) => LoginPage(),
        '/signUp': (context) => SignUpPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
