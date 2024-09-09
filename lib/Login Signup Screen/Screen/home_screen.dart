import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart'; // Import for scroll direction detection
import 'package:flutter_firebase_project/Login%20Signup%20Screen/Screen/add_note_screen.dart'; // Import for adding notes screen
import 'package:flutter_firebase_project/Login%20Signup%20Screen/Screen/completed_notes.dart'; // Import for completed notes screen
import 'package:flutter_firebase_project/Login%20Signup%20Screen/Screen/profile_screen.dart'; // Import for profile screen
import 'package:flutter_firebase_project/Login%20Signup%20Screen/Widget/colors.dart'; // Import for custom color constants
import 'package:flutter_firebase_project/Login%20Signup%20Screen/Widget/stream_notes.dart'; // Import for stream notes widget

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool show =
      true; // Variable to control the visibility of the floating action button

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsiveness
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: custom_white, // Set background color
      appBar: AppBar(
        automaticallyImplyLeading:
            false, // removes the back icon that is automatically appears
        shape: const RoundedRectangleBorder(
          // Rounded corners for the app bar
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        toolbarHeight: screenHeight * 0.1, // Responsive toolbar height
        elevation: 5, // Add elevation to the app bar
        shadowColor: Colors.black, // Set shadow color
        centerTitle: true, // Center the title
        backgroundColor: custom_green, // Set background color
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Center the title row
          children: [
            GestureDetector(
              // Add a tap gesture to the profile image
              onTap: () {
                // Navigate to the profile screen with a slide transition
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const ProfileScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      var begin = const Offset(-1, 0.0); // Slide from left
                      var end = Offset.zero;
                      var curve = Curves.ease;

                      var tween = Tween(begin: begin, end: end).chain(
                        CurveTween(curve: curve),
                      );
                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                    },
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.only(
                    right: screenWidth * 0.09), // Responsive padding
                child: CircleAvatar(
                  // Display a circular profile image
                  backgroundColor: custom_white,
                  radius: screenHeight * 0.03, // Responsive radius
                  backgroundImage: const AssetImage(
                      'images/profile_photo.png'), // Replace with your image path
                ),
              ),
            ),
            Text(
              // Display the app title
              'Task Manager',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.08, // Responsive font size
              ),
            ),
            SizedBox(width: screenWidth * 0.05), // Responsive spacing
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(
                right: screenWidth * 0.02,
                top: screenHeight * 0.01), // Responsive padding
            child: IconButton(
              // Add an icon button for completed tasks
              icon: Icon(
                Icons.check_box,
                color: Colors.white,
                size: screenHeight * 0.04, // Responsive icon size
              ),
              onPressed: () {
                // Navigate to the completed notes screen with a slide transition
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const CompletedNotes(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      var begin = const Offset(1.0, 0.0); // Slide from right
                      var end = Offset.zero;
                      var curve = Curves.ease;

                      var tween = Tween(begin: begin, end: end).chain(
                        CurveTween(curve: curve),
                      );
                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Visibility(
        // Control the visibility of the floating action button
        visible: show,
        child: SizedBox(
          width: screenWidth * 0.17, // Responsive width
          height: screenHeight * 0.08, // Responsive height
          child: FloatingActionButton(
            // Add a floating action button to add new tasks
            elevation: 5,
            onPressed: () {
              // Navigate to the add note screen with a slide transition
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const Add_Screen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    var begin = const Offset(0.0, 1.0); // Slide from bottom
                    var end = Offset.zero;
                    var curve = Curves.ease;

                    var tween = Tween(begin: begin, end: end).chain(
                      CurveTween(curve: curve),
                    );
                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
                ),
              );
            },
            backgroundColor: custom_green, // Set background color
            shape: RoundedRectangleBorder(
              // Rounded corners
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: screenHeight * 0.04, // Responsive icon size
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: NotificationListener<UserScrollNotification>(
          // Listen for user scroll notifications
          onNotification: (notification) {
            // Show/hide the floating action button based on scroll direction
            if (notification.direction == ScrollDirection.forward) {
              setState(() {
                show = true;
              });
            }
            if (notification.direction == ScrollDirection.reverse) {
              setState(() {
                show = false;
              });
            }
            return true;
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.02), // Responsive padding
            child: StreamNotes(false), // Display notes from Firestore
          ),
        ),
      ),
    );
  }
}
