import 'dart:async'; // Import for timer functionality
import 'package:flutter/material.dart';
import 'package:flutter_firebase_project/Login%20Signup%20Screen/Widget/colors.dart'; // Import for custom colors

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay for 2 seconds before navigating to the main screen
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context)
          .pushReplacementNamed('/auth'); // Navigate to auth logic
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive layout
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: custom_green, // Set background color for splash screen
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'images/Task Manager Icon.png',
              width: screenWidth * 0.4, // Scale logo to 40% of screen width
              height: screenHeight * 0.2, // Scale logo to 20% of screen height
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Text(
              "Task Manager",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.1),
            ),
            // Image.asset(
            //   'images/banking.png',
            //   width: screenWidth * 0.6,
            //   height: screenHeight * 0.6,
            // ),
            SizedBox(
              height: screenHeight * 0.3,
            ),
            const CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
