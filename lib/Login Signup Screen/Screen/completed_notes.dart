import 'package:flutter/material.dart';
import 'package:flutter_firebase_project/Login%20Signup%20Screen/Widget/colors.dart';
import 'package:flutter_firebase_project/Login%20Signup%20Screen/Widget/stream_notes.dart';

class CompletedNotes extends StatefulWidget {
  const CompletedNotes({super.key});

  @override
  State<CompletedNotes> createState() => _CompletedNotesState();
}

class _CompletedNotesState extends State<CompletedNotes> {
  bool show = true;

  @override
  Widget build(BuildContext context) {
    // MediaQuery to get screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: custom_white,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        toolbarHeight: screenHeight * 0.1, // Dynamic toolbar height
        elevation: 5,
        shadowColor: Colors.black,
        centerTitle: true,
        backgroundColor: custom_green,

        // Title of the AppBar
        title: Padding(
          padding: EdgeInsets.only(right: screenWidth * 0.1), // Dynamic padding
          child: Center(
            child: Text(
              'Completed Tasks',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.08, // Dynamic font size
              ),
            ),
          ),
        ),

        // Icon theme for back button
        iconTheme: IconThemeData(
          color: Colors.white,
          size: screenWidth * 0.07, // Dynamic icon size
        ),
      ),

      // Body of the page containing the stream of notes
      body: Hero(
        tag: 'hero-tag',
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          // Display the completed tasks using the StreamNotes widget
          child: StreamNotes(true),
        ),
      ),
    );
  }
}
