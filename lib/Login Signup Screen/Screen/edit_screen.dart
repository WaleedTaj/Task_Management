import 'package:flutter/material.dart';
import 'package:flutter_firebase_project/Login%20Signup%20Screen/Services/authentication.dart';
import 'package:flutter_firebase_project/Login%20Signup%20Screen/Widget/colors.dart';
import 'package:flutter_firebase_project/Login%20Signup%20Screen/Widget/text_field.dart';

import '../../Model/notes_model.dart';

class Edit_Screen extends StatefulWidget {
  final Note _note; // Note object to be edited
  Edit_Screen(this._note, {super.key});

  @override
  State<Edit_Screen> createState() => _Edit_ScreenState();
}

class _Edit_ScreenState extends State<Edit_Screen> {
  late TextEditingController titleController;
  late TextEditingController subTitleController;

  int indexValue = 0; // Used to track the selected image index

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing note values
    titleController = TextEditingController(text: widget._note.title);
    subTitleController = TextEditingController(text: widget._note.subtitle);
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height for responsiveness
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: custom_white,
      body: Hero(
        tag: 'hero-tag',
        child: SafeArea(
          child: Center( // Wrap the content inside Center widget
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Center the content vertically
                crossAxisAlignment: CrossAxisAlignment.center, // Center the content horizontally
                children: [
                  SizedBox(height: screenHeight * 0.03), // Add some spacing at the top
                  // Update Task Heading
                  Text(
                    "\"Update task\"",
                    style: TextStyle(
                      color: custom_green,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.08, // Responsive font size
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02), // Space between elements

                  // Title input field
                  TextFieldInput(
                    customBottomPadding: 0,
                    maxLines: 1,
                    textEditingController: titleController,
                    isPass: false,
                    hintText: 'Title',
                    icon: Icons.title,
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // Subtitle input field
                  TextFieldInput(
                    customBottomPadding: screenHeight * 0.06,
                    maxLines: 3,
                    textEditingController: subTitleController,
                    isPass: false,
                    hintText: 'Subtitle',
                    icon: Icons.subtitles,
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  // Image selection section
                  slideImages(),

                  SizedBox(height: screenHeight * 0.03), // Space between elements

                  // Action buttons (Update and Cancel)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: custom_green,
                          minimumSize: Size(screenWidth * 0.4, screenHeight * 0.07), // Responsive size
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          // Call update note function from AuthServices
                          AuthServices().updateNote(
                            widget._note.id,
                            indexValue,
                            titleController.text,
                            subTitleController.text,
                          );
                          ScaffoldMessenger.of(context)
                              .hideCurrentSnackBar(); // Hide any currently visible SnackBar
                          // Show a confirmation snackbar and navigate back
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: custom_green,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(15),
                                ),
                              ),
                              content: const Text(
                                'Task Updated Successfully!',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                          Navigator.pop(context); // Close the screen
                        },
                        child: const Text(
                          "Update Task",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: Size(screenWidth * 0.4, screenHeight * 0.07), // Responsive size
                        ),
                        onPressed: () {
                          Navigator.pop(context); // Close the screen without changes
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
      ),
    );
  }

  // Widget to display images in a horizontal ListView
  Widget slideImages() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        height: 160, // Fixed height for image slider
        child: ListView.builder(
          itemCount: 5, // Number of images
          scrollDirection: Axis.horizontal, // Horizontal scrolling
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Update selected image index when tapped
                setState(() {
                  indexValue = index;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 2,
                    color: indexValue == index ? custom_green : Colors.grey, // Highlight selected image
                  ),
                ),
                width: 140, // Fixed width for each image
                margin: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    // Load image assets dynamically based on index
                    Image.asset("images/$index.png"),
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
