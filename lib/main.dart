import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_project/Login%20Signup%20Screen/Screen/home_screen.dart';
import 'package:flutter_firebase_project/Login%20Signup%20Screen/Screen/login.dart';
import 'package:flutter_firebase_project/Login%20Signup%20Screen/Screen/splash_screen.dart'; // Import the SplashScreen
import 'Login Signup Screen/Widget/colors.dart';

void main() async {
  // Ensure that Flutter's binding is initialized before using Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase options for initializing the app
  const firebaseOptions = FirebaseOptions(
    apiKey: "Your API KEY",
    appId: "Your App ID",
    messagingSenderId: "Your Messaging Sender ID",
    projectId: "Your Project ID",
  );

  // Initialize Firebase with options based on platform
  if (Platform.isAndroid ||
      Platform.isIOS ||
      Platform.isWindows ||
      Platform.isMacOS ||
      Platform.isLinux ||
      Platform.isFuchsia) {
    await Firebase.initializeApp(options: firebaseOptions);
  } else {
    await Firebase.initializeApp();
  }

  // Run the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hide the debug banner
      initialRoute: '/', // Set initial route
      routes: {
        '/': (context) => const SplashScreen(), // Show splash screen initially
        '/auth': (context) =>
            const AuthHandler(), // Route to auth logic after splash screen
      },
    );
  }
}

// Widget to handle authentication logic after splash screen
class AuthHandler extends StatelessWidget {
  const AuthHandler({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen dimension for responsiveness
    final screenWidth = MediaQuery.of(context).size.width;

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance
          .authStateChanges(), // Stream of authentication state changes
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            // If user is authenticated, show the HomeScreen
            return const HomeScreen();
          } else {
            // If user is not authenticated, show the LoginScreen
            return const LoginScreen();
          }
        } else {
          // While waiting for the stream to return a value, show a loading indicator
          return Center(
            child: CircularProgressIndicator(
              color: custom_green,
              strokeWidth: screenWidth * 0.02, // Responsive stroke width
            ),
          );
        }
      },
    );
  }
}
