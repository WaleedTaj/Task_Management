import 'package:cloud_firestore/cloud_firestore.dart'; // Import for Firebase Firestore
import 'package:flutter/material.dart'; // Import for Flutter widgets
import 'package:flutter_firebase_project/Login%20Signup%20Screen/Widget/colors.dart'; // Import for custom colors
import 'package:flutter_firebase_project/Login%20Signup%20Screen/Widget/task_widgets.dart'; // Import for task widgets

import '../Services/authentication.dart'; // Import for authentication services

class StreamNotes extends StatefulWidget {
  bool
      done; // Variable to track the completion status of notes (true for done, false for pending)
  StreamNotes(this.done,
      {super.key}); // Constructor to initialize the completion status

  @override
  State<StreamNotes> createState() => _StreamNotesState();
}

class _StreamNotesState extends State<StreamNotes> {
  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsiveness
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // StreamBuilder to listen for changes in Firestore notes collection
    return StreamBuilder<QuerySnapshot>(
      stream: AuthServices().stream(
          widget.done), // Get the stream of notes based on completion status
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          // If no data is available, show a loading indicator
          return Center(
              child: SizedBox(
            height: height *
                0.08, // Responsive height for CircularProgressIndicator
            width:
                width * 0.08, // Responsive width for CircularProgressIndicator
            child: CircularProgressIndicator(
              color: custom_green, // Set the color of the loading indicator
            ),
          ));
        }
        final notesList = AuthServices()
            .getNotes(snapshot); // Get the list of notes from the snapshot
        return ListView.builder(
          // Build a ListView to display the notes
          itemBuilder: (context, index) {
            // Item builder for the ListView
            final note = notesList[index]; // Get the note at the current index

            return Dismissible(
              // Make each note dismissible to delete
              key: UniqueKey(), // Unique key for each dismissible widget
              onDismissed: (direction) async {
                // Callback when the note is dismissed
                await AuthServices()
                    .deleteNote(note.id); // Delete the note from Firestore

                // Show the SnackBar after the note is deleted
                ScaffoldMessenger.of(context)
                    .hideCurrentSnackBar(); // Hide any currently visible SnackBar

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor:
                        custom_green, // Use custom green background color
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top:
                            Radius.circular(15), // Rounded corners for SnackBar
                      ),
                    ),
                    content: const Text(
                      'Task deleted!', // Message to show in the SnackBar
                      style: TextStyle(color: Colors.white),
                    ),
                    duration:
                        const Duration(seconds: 2), // Duration of the SnackBar
                  ),
                );
              },
              child: TaskWidget(note), // Display the note using the TaskWidget
            );
          },
          itemCount:
              notesList.length, // Set the item count to the number of notes
        );
      },
    );
  }
}
