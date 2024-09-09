import 'package:firebase_auth/firebase_auth.dart'; // Import for Firebase Authentication
import 'package:flutter/material.dart';
import 'package:flutter_firebase_project/Login%20Signup%20Screen/Screen/Login.dart'; // Import for the login screen
import 'package:flutter_firebase_project/Login%20Signup%20Screen/Widget/button.dart'; // Import for a custom button widget
import 'package:flutter_firebase_project/Login%20With%20Google/google_auth.dart'; // Import for Google authentication

import '../Widget/colors.dart'; // Import for custom color constants

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current logged-in user from Firebase
    final User? user = FirebaseAuth.instance.currentUser;

    // Get the screen dimensions for responsiveness
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    // Build the UI for the HomeScreen
    return Scaffold(
      backgroundColor: custom_white, // Set background color
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          // Rounded corners for the app bar
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        toolbarHeight: height * 0.1, // Responsive toolbar height
        elevation: 5, // Add elevation to the app bar
        shadowColor: Colors.black, // Set shadow color
        centerTitle: true, // Center the title
        backgroundColor: custom_green, // Set background color
        title: Padding(
          padding: EdgeInsets.only(right: width * 0.1), // Responsive padding
          child: Center(
            child: Text(
              'Your Profile',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: width * 0.09, // Responsive font size
              ),
            ),
          ),
        ),
        iconTheme: IconThemeData(
            color: Colors.white,
            size: height * 0.04), // Set icon color and size
      ),
      body: Hero(
        tag: 'hero-tag', // Tag for Hero animation (if used)
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04, // Responsive horizontal padding
            vertical: height * 0.05, // Responsive vertical padding
          ),
          child: SingleChildScrollView(
            // Allow scrolling if content overflows
            child: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Center content vertically
                  children: [
                    // Display the user's profile picture if available
                    if (user?.photoURL != null)
                      ClipOval(
                        // Make the image circular
                        child: LayoutBuilder(builder: (context, constraints) {
                          final double imageSize = constraints.maxWidth *
                              0.4; // Responsive image size
                          return Image.network(
                            user!.photoURL!,
                            width: imageSize,
                            height: imageSize,
                            fit: BoxFit.cover, // Cover the area with the image
                          );
                        }),
                      )
                    else
                      // Display a placeholder icon if no profile picture is available
                      ClipOval(
                        // Make the container circular
                        child: LayoutBuilder(builder: (context, constraints) {
                          final double imageSize = constraints.maxWidth *
                              0.4; // Responsive container size
                          return Container(
                            width: imageSize,
                            height: imageSize,
                            color: custom_green, // Set background color
                            child: Icon(Icons.person,
                                size: width * 0.2,
                                color: Colors.white), // Display a person icon
                          );
                        }),
                      ),

                    SizedBox(height: height * 0.03), // Responsive spacing

                    // Display the user's display name if available
                    if (user?.displayName != null)
                      Text(
                        user!.displayName!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.07, // Responsive font size
                        ),
                      ),
                    SizedBox(height: height * 0.01), // Responsive spacing

                    // Display the user's email if available
                    if (user?.email != null)
                      Text(
                        user!.email!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.05, // Responsive font size
                        ),
                      ),

                    // Display the user's phone number if available
                    if (user?.phoneNumber != null)
                      Text(
                        user!.phoneNumber!,
                        style: TextStyle(
                          fontSize: width * 0.07, // Responsive font size
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    SizedBox(height: height * 0.03), // Responsive spacing

                    // Horizontal divider
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: height * 0.001, // Responsive height
                            color: custom_green, // Set divider color
                          ),
                        ),
                        Text(
                          "    ",
                          style: TextStyle(
                              fontSize: width * 0.035), // Responsive font size
                        ),
                        Expanded(
                          child: Container(
                            height: height * 0.001, // Responsive height
                            color: custom_green, // Set divider color
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: height * 0.03), // Responsive spacing

                    // Log Out Button
                    MyButton(
                      onTab: () async {
                        // Sign out the user from Google and Firebase
                        await FirebaseServices().googleSignOut();
                        await FirebaseAuth.instance.signOut();

                        // Navigate to the LoginScreen
                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            // Use PageRouteBuilder for custom transition
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                            const LoginScreen(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              // Define the transition
                              var begin =
                              const Offset(0.0, -1.0); // Starting offset
                              var end = Offset.zero; // Ending offset
                              var curve = Curves
                                  .ease; // Transition curve (ease in this case)

                              var tween = Tween(begin: begin, end: end).chain(
                                // Create a tween for the transition
                                CurveTween(curve: curve),
                              );
                              return SlideTransition(
                                // Use SlideTransition for the animation
                                position: animation.drive(
                                    tween), // Apply the tween to the animation
                                child: child, // The widget to be animated
                              );
                            },
                          ),
                        );

                        // Show a dialog indicating the user has logged out
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor:
                                custom_white, // Set background color
                            title: Text(
                              "Logged Out",
                              style: TextStyle(
                                  color: custom_green), // Set title color
                            ),
                            content: const Text(
                                "You have been successfully logged out."),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                child: Text(
                                  "OK",
                                  style: TextStyle(
                                      color: custom_green,
                                      fontSize:
                                          width * 0.04), // Responsive font size
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      text: "Log Out",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
