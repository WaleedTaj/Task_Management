import 'package:flutter/material.dart';
import 'package:flutter_firebase_project/Login%20Signup%20Screen/Services/authentication.dart'; // Import your authentication service
import 'package:flutter_firebase_project/Login%20Signup%20Screen/Widget/colors.dart'; // Import your color constants
import 'package:flutter_firebase_project/Login%20Signup%20Screen/Widget/text_field.dart'; // Import your custom text field widget

class Add_Screen extends StatefulWidget {
  const Add_Screen({super.key});

  @override
  State<Add_Screen> createState() => _Add_ScreenState();
}

class _Add_ScreenState extends State<Add_Screen> {
  final titleController =
      TextEditingController(); // Controller for the title text field
  final subTitleController =
      TextEditingController(); // Controller for the subtitle text field
  int indexValue = 0; // Variable to store the selected image index

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsiveness
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: custom_white, // Set background color
      resizeToAvoidBottomInset:
          false, // Prevent rendering flex overflow error when keyboard appears
      body: Hero(
        tag: 'hero-tag', // Tag for Hero animation (if used)
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.all(16.0), // Add padding around the content
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center content vertically
              children: [
                // Title text
                Text(
                  "\"Add a task\"",
                  style: TextStyle(
                    color: custom_green, // Use your custom color
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.08, // Responsive font size
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), // Responsive spacing

                // Title input field
                TextFieldInput(
                  customBottomPadding: 0,
                  maxLines: 1,
                  textEditingController: titleController,
                  isPass: false,
                  hintText: 'Title',
                  icon: Icons.title,
                ),
                SizedBox(height: screenHeight * 0.02), // Responsive spacing

                // Subtitle input field
                TextFieldInput(
                  customBottomPadding:
                      screenHeight * 0.06, // Responsive bottom padding
                  maxLines: 3,
                  textEditingController: subTitleController,
                  isPass: false,
                  hintText: 'Subtitle',
                  icon: Icons.subtitles,
                ),
                SizedBox(height: screenHeight * 0.03), // Responsive spacing

                // Image slider
                slideImages(screenHeight, screenWidth),
                SizedBox(height: screenHeight * 0.03), // Responsive spacing

                // Action buttons (Add Task & Cancel)
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly, // Evenly space buttons
                  children: [
                    // Add Task button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: custom_green, // Use your custom color
                        minimumSize: Size(screenWidth * 0.4,
                            screenHeight * 0.07), // Responsive button size
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Rounded corners
                        ),
                      ),
                      onPressed: () {
                        // Add task logic using your authentication service
                        AuthServices().AddNote(titleController.text,
                            subTitleController.text, indexValue);

                        ScaffoldMessenger.of(context)
                            .hideCurrentSnackBar(); // Hide any currently visible SnackBar

                        // Show success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor:
                                custom_green, // Use your custom color
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(15), // Rounded top corners
                              ),
                            ),
                            content: const Text(
                              'Task Added Successfully!',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );

                        // Navigate back after adding the task
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Add Task",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    // Cancel button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        minimumSize: Size(screenWidth * 0.4,
                            screenHeight * 0.07), // Responsive button size
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Rounded corners
                        ),
                      ),
                      onPressed: () {
                        // Navigate back without saving
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Image slider widget
  Widget slideImages(double screenHeight, double screenWidth) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: 15), // Add horizontal padding
      child: Container(
        height: screenHeight * 0.20, // Responsive height for the slider
        child: ListView.builder(
          itemCount: 5, // Number of images in the slider
          scrollDirection: Axis.horizontal, // Horizontal scrolling
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  indexValue = index; // Update selected image index
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                  border: Border.all(
                    width: 2,
                    color: indexValue == index
                        ? custom_green
                        : Colors.white, // Highlight selected image
                  ),
                ),
                width: screenWidth * 0.35, // Responsive image width
                margin: const EdgeInsets.all(8), // Add margin around images
                child: Column(
                  children: [
                    Image.asset(
                      "images/$index.png", // Image path (make sure images are in your assets)
                      fit: BoxFit.cover, // Cover the container with the image
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
