import 'package:flutter/material.dart'; // Import for Flutter widgets
import 'package:flutter_firebase_project/Login%20Signup%20Screen/Screen/edit_screen.dart'; // Import for the edit screen
import 'package:flutter_firebase_project/Login%20Signup%20Screen/Services/authentication.dart'; // Import for authentication services
import 'package:flutter_firebase_project/Login%20Signup%20Screen/Widget/colors.dart'; // Import for custom colors

import '../../Model/notes_model.dart'; // Import for the Note model

class TaskWidget extends StatefulWidget {
  final Note _note; // Note object to be displayed

  const TaskWidget(this._note,
      {super.key}); // Constructor to initialize the note

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsiveness
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return get(width, height); // Call the get() method with screen dimensions
  }

  Widget get(double width, double height) {
    // Widget to display the task/note
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.015), // Responsive padding
      child: Container(
        width: double.infinity, // Take full available width
        height: height * 0.18, // Responsive height
        decoration: BoxDecoration(
          color: Colors.white, // White background color
          borderRadius:
              BorderRadius.circular(width * 0.02), // Responsive rounded corners
          boxShadow: [
            // Add a shadow effect
            BoxShadow(
              color: Colors.grey, // Shadow color
              spreadRadius: width * 0.01, // Responsive spread radius
              blurRadius: width * 0.015, // Responsive blur radius
              offset: const Offset(0, 2), // Shadow offset
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.02), // Responsive padding
          child: Row(
            children: [
              // image
              image(
                  width, height), // Display the image associated with the note
              SizedBox(
                width: width * 0.05, // Responsive spacing
              ),
              // title and subtitle
              Expanded(
                // Expand to fill available space
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align items to the start
                  children: [
                    SizedBox(
                      height: height * 0.01, // Responsive spacing
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // Distribute space between children
                      children: [
                        Expanded(
                          // Expand to fill available space
                          child: Text(
                            widget._note.title, // Display the note's title
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: width * 0.05), // Responsive font size
                            maxLines: 1, // Display only one line
                            overflow: TextOverflow
                                .ellipsis, // Show ellipsis if text overflows
                          ),
                        ),
                        Checkbox(
                          // Checkbox to mark the note as done
                          activeColor: custom_green, // Set active color
                          value:
                              widget._note.isDone, // Get the completion status
                          onChanged: (value) {
                            // Callback when checkbox value changes
                            setState(() {
                              widget._note.isDone = !widget
                                  ._note.isDone; // Toggle completion status
                              // Show a SnackBar based on completion status
                              if (widget._note.isDone) {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar(); // Hide current SnackBar if any
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor:
                                        custom_green, // Set background color
                                    shape: RoundedRectangleBorder(
                                        // Rounded corners
                                        borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(
                                          width * 0.04), // Responsive radius
                                    )),
                                    content: const Text(
                                      'Task Completed!', // Message for completed task
                                      style: TextStyle(
                                          color:
                                              Colors.white), // White text color
                                    ),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar(); // Hide current SnackBar if any
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor:
                                        custom_green, // Set background color
                                    shape: RoundedRectangleBorder(
                                        // Rounded corners
                                        borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(
                                          width * 0.04), // Responsive radius
                                    )),
                                    content: const Text(
                                      'Task Retrieved!', // Message for pending task
                                      style: TextStyle(
                                          color:
                                              Colors.white), // White text color
                                    ),
                                  ),
                                );
                              }
                            });
                            AuthServices().isCheckboxDone(
                                // Update completion status in Firestore
                                widget._note.id,
                                widget._note.isDone);
                          },
                          side: WidgetStateBorderSide.resolveWith(
                            (states) => BorderSide(
                              // Customize checkbox border
                              color: custom_green, // Set border color
                              width: 2, // Set border width
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      // Expand to fill available space
                      child: Text(
                        widget._note.subtitle, // Display the note's subtitle
                        style: TextStyle(
                            // Style for the subtitle
                            fontSize: width * 0.04, // Responsive font size
                            fontWeight: FontWeight.w400, // Set font weight
                            color: Colors.grey.shade400), // Set text color
                        maxLines: 2, // Display only two lines
                        overflow: TextOverflow
                            .ellipsis, // Show ellipsis if text overflows
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: height * 0.013), // Responsive padding
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceEvenly, // Distribute space evenly
                        children: [
                          Container(
                            // Container for time display
                            width: width * 0.23, // Responsive width
                            height: height * 0.035, // Responsive height
                            decoration: BoxDecoration(
                              // Container decoration
                              color: custom_green, // Set background color
                              borderRadius: BorderRadius.circular(
                                  width * 0.01), // Responsive rounded corners
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  // Responsive padding
                                  horizontal: width * 0.03,
                                  vertical: height * 0.005),
                              child: Row(
                                children: [
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 2.0),
                                    child: Image(
                                      // Image for time icon
                                      image: AssetImage(
                                        'images/icon_time.png', // Image path
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.025, // Responsive spacing
                                  ),
                                  Text(
                                    widget
                                        ._note.time, // Display the note's time
                                    style: TextStyle(
                                        // Style for the time text
                                        fontWeight:
                                            FontWeight.bold, // Set font weight
                                        fontSize: width *
                                            0.035, // Responsive font size
                                        color: Colors.white), // Set text color
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.025, // Responsive spacing
                          ),
                          GestureDetector(
                              // GestureDetector for edit button
                              onTap: () {
                                // Callback when edit button is tapped
                                Navigator.of(context).push(
                                  // Navigate to the edit screen
                                  PageRouteBuilder(
                                    // Use PageRouteBuilder for custom transition
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        Edit_Screen(widget
                                            ._note), // Pass the note to the edit screen
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      // Define the transition
                                      var begin = const Offset(
                                          0.0, 1.0); // Starting offset
                                      var end = Offset.zero; // Ending offset
                                      var curve = Curves
                                          .ease; // Transition curve (ease in this case)

                                      var tween =
                                          Tween(begin: begin, end: end).chain(
                                        // Create a tween for the transition
                                        CurveTween(curve: curve),
                                      );
                                      return SlideTransition(
                                        // Use SlideTransition for the animation
                                        position: animation.drive(
                                            tween), // Apply the tween to the animation
                                        child:
                                            child, // The widget to be animated
                                      );
                                    },
                                  ),
                                );
                              },
                              child: Container(
                                // Container for edit button
                                width: width * 0.2, // Responsive width
                                height: height * 0.035, // Responsive height
                                decoration: BoxDecoration(
                                  // Container decoration
                                  color: custom_white, // Set background color
                                  borderRadius: BorderRadius.circular(width *
                                      0.01), // Responsive rounded corners
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      // Responsive padding
                                      horizontal: width * 0.03,
                                      vertical: height * 0.005),
                                  child: Row(
                                    children: [
                                      Image(
                                        // Image for edit icon
                                        color: custom_green, // Set icon color
                                        image: const AssetImage(
                                          'images/icon_edit.png', // Image path
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            width * 0.025, // Responsive spacing
                                      ),
                                      Text(
                                        'Edit', // Text for edit button
                                        style: TextStyle(
                                            // Style for the edit text
                                            fontWeight: FontWeight
                                                .bold, // Set font weight
                                            fontSize: width *
                                                0.035, // Responsive font size
                                            color:
                                                custom_green), // Set text color
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget image(double width, double height) {
    // Widget to display the image
    return Container(
      height: height * 0.17, // Responsive height
      width: width * 0.25, // Responsive width
      decoration: BoxDecoration(
        color: Colors.white, // White background color
        image: DecorationImage(
          // Display the image
          image: AssetImage('images/${widget._note.image}.png'), // Image path
          fit: BoxFit.cover, // Cover the container with the image
        ),
      ),
    );
  }
}
