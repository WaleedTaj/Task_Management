import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_project/Login%20Signup%20Screen/Widget/colors.dart';
import 'package:flutter_firebase_project/Login%20Signup%20Screen/Widget/snack_bar.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  // Controller for email input field
  TextEditingController emailController = TextEditingController();

  // Firebase Auth instance
  final auth = FirebaseAuth.instance;

  // Loading state to show the progress indicator
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    // Getting the screen dimensions
    double width = MediaQuery.of(context).size.width;

    // Screen UI
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.06),
      child: Align(
        alignment: Alignment.centerRight,
        child: InkWell(
          onTap: () {
            // Show dialog box when "Forgot Password?" is tapped
            myDialogBox(context);
          },
          child: Text(
            "Forgot Password?",
            style: TextStyle(
              fontSize: width * 0.039,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  // Function to display the "Forgot Password" dialog box
  void myDialogBox(BuildContext context) {
    // Getting the screen dimensions
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // Display dialog box
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            decoration: BoxDecoration(
              color: custom_white,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.fromLTRB(
              width * 0.04,
              height * 0.015,
              width * 0.04,
              height * 0.015,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header row with title and close icon
                Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: width * 0.02)),
                    Text(
                      "Forgot Your Password?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.044,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: width * 0.117)),
                    IconButton(
                      onPressed: () {
                        // Close the dialog box when the close icon is pressed
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        size: height * 0.031,
                      ),
                    ),
                  ],
                ),
                // Text field to enter email
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: custom_green, width: 2.0),
                    ),
                    labelText: "Enter Your Email",
                    hintText: "eg: abc@gmail.com",
                    labelStyle: const TextStyle(color: Colors.black),
                    floatingLabelStyle: TextStyle(color: custom_green),
                  ),
                ),
                SizedBox(
                  height: height * 0.013,
                ),
                // Conditionally show the loading indicator or "Send" button
                isLoading
                    ? CircularProgressIndicator(
                        color: custom_green,
                      )
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: custom_green,
                        ),
                        onPressed: () async {
                          // Start the loading indicator
                          setState(() {
                            isLoading = true;
                          });

                          try {
                            // Send password reset email
                            await auth.sendPasswordResetEmail(
                                email: emailController.text);

                            // Show success message
                            showSnackBar(
                              context,
                              "We have sent you the reset password link to your email id, Please check it.",
                            );

                            // Close the dialog box after sending the email
                            Navigator.pop(context);

                            // Clear the email text field
                            emailController.clear();
                          } catch (error) {
                            // Show error message if something goes wrong
                            showSnackBar(
                              context,
                              "Invalid email address or Network error",
                            );
                          }

                          // Stop the loading indicator
                          setState(() {
                            isLoading = false;
                          });
                        },
                        child: Text(
                          "Send",
                          style: TextStyle(
                            fontSize: width * 0.045,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
