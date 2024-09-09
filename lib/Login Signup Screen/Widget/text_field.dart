import 'package:flutter/material.dart';
import 'package:flutter_firebase_project/Login%20Signup%20Screen/Widget/colors.dart';

class TextFieldInput extends StatefulWidget {
  // Controller for the text field input
  final TextEditingController textEditingController;
  // Boolean to determine if the field is for password input
  final bool isPass;
  // Hint text to display inside the text field
  final String hintText;
  // Max lines to write the text in a field
  final int maxLines;
  // Custom Bottom Padding for every TextField
  final double customBottomPadding;
  // Icon to display inside the text field
  final IconData icon;

  // Constructor for initializing the text field input widget
  const TextFieldInput({
    super.key,
    required this.textEditingController,
    required this.isPass,
    required this.hintText,
    required this.icon,
    required this.maxLines,
    required this.customBottomPadding,
  });

  @override
  _TextFieldInputState createState() => _TextFieldInputState();
}

class _TextFieldInputState extends State<TextFieldInput> {
  // State variable to manage the visibility of the password text
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    // Getting screen dimensions for responsive design
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // Building the text field with optional password visibility toggle
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.048, vertical: height * 0.0115),
      child: TextField(
        // Toggle obscuring text if this is a password field
        obscureText: widget.isPass ? _isObscured : false,
        controller: widget.textEditingController,
        maxLines: widget.maxLines,
        decoration: InputDecoration(
          // Display hint text when the field is empty
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.black45, fontSize: width * 0.044,),
          border: InputBorder.none,
          // Icon displayed on the left side of the text field
          prefixIcon: Padding(
            padding: EdgeInsets.only(
                left: width * 0.04,
                right: width * 0.025,
                bottom: widget.customBottomPadding),
            child: Icon(
              widget.icon,
              color: custom_green,
              size: width * 0.06,
            ),
          ),
          // Optional visibility toggle icon for password fields
          suffixIcon: widget.isPass
              ? IconButton(
                  icon: Padding(
                    padding: EdgeInsets.all(width * 0.015),
                    child: Icon(
                      _isObscured ? Icons.visibility_off : Icons.visibility,
                      color: custom_green,
                      size: width * 0.067,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      // Toggle password visibility state
                      _isObscured = !_isObscured;
                    });
                  },
                )
              : null,
          // Padding inside the text field
          contentPadding: EdgeInsets.symmetric(
              horizontal: width * 0.07, vertical: height * 0.019),
          filled: true,
          fillColor: const Color(0xFFedf0f8),
          // Style for the enabled border of the text field
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: width * 0.006, color: Colors.white),
            borderRadius: BorderRadius.circular(15),
          ),
          // Style for the focused border of the text field
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: width * 0.006, color: custom_green),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
