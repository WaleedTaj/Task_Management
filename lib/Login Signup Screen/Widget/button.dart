import 'package:flutter/material.dart';
import 'package:flutter_firebase_project/Login%20Signup%20Screen/Widget/colors.dart';

class MyButton extends StatelessWidget {
  // Define callback and text variables
  final VoidCallback onTab; // Callback function to handle button tap
  final String text; // Text to display on the button

  // Constructor to initialize the callback and text
  const MyButton({super.key, required this.onTab, required this.text});

  @override
  Widget build(BuildContext context) {
    // Getting screen dimensions to make the button responsive
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // Button UI starts from here
    return InkWell(
      // Trigger the callback when the button is tapped
      onTap: onTab,
      child: Padding(
        padding: EdgeInsets.all(width * 0.05), // Responsive padding around the button
        child: Container(
          // Center the content within the button
          alignment: Alignment.center,
          // Set vertical padding for the button content
          padding: EdgeInsets.symmetric(vertical: height * 0.016),
          // Decorate the button with a rounded shape and a blue background color
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  width * 0.04), // Responsive rounded corners
            ),
            color: custom_green, // Button background color
          ),
          // Display the text on the button
          child: Text(
            text, // Use the text passed through the constructor
            style: TextStyle(
                fontSize:
                width * 0.049, // Font size proportional to screen width
                fontWeight: FontWeight.bold, // Bold text style
                color: Colors.white // White text color
            ),
          ),
        ),
      ),
    );
  }
}