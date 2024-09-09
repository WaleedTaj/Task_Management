import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_project/Login%20Signup%20Screen/Widget/colors.dart';
import 'package:flutter_firebase_project/Phone%20Auth/otp_screen.dart';
import 'package:icons_plus/icons_plus.dart';

class PhoneAuthentication extends StatefulWidget {
  const PhoneAuthentication({super.key});

  @override
  State<PhoneAuthentication> createState() => _PhoneAuthenticationState();
}

class _PhoneAuthenticationState extends State<PhoneAuthentication> {
  // Controller to manage phone number input
  TextEditingController phoneController = TextEditingController();

  // Indicator to show loading state
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    // Getting the screen dimensions for responsive design
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    // Main UI layout starts here
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.06, vertical: height * 0.01),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              backgroundColor: Colors.green,
              padding: EdgeInsets.symmetric(
                  vertical: height * 0.001, horizontal: width * 0.06)),
          onPressed: () {
            // Show the dialog box for phone number input
            myDialogBox(context);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.005),
            child: Row(
              children: [
                // Phone icon from the Icons_plus package
                Brand(
                  Brands.phone,
                  size: height * 0.051,
                ),
                SizedBox(
                  width: width * 0.038,
                ),
                Text(
                  "Sign In with Phone",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: width * 0.048,
                      color: Colors.white),
                ),
              ],
            ),
          )),
    );
  }

  // Function to show a dialog box for phone number input
  void myDialogBox(BuildContext context) {
    // Getting the dimensions of the screen
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    // Dialog box layout
    showDialog(
      context: context,
      barrierDismissible:
          false, // Prevent dismissing the dialog by tapping outside
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(
                width * 0.04, height * 0.015, width * 0.04, height * 0.015),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: custom_white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: width * 0.023)),
                    Text(
                      "Phone Authentication",
                      style: TextStyle(
                          fontSize: width * 0.047, fontWeight: FontWeight.bold),
                    ),
                    Padding(padding: EdgeInsets.only(left: width * 0.116)),
                    IconButton(
                      onPressed: () {
                        // Close the dialog and clear the phone number input
                        Navigator.pop(context);
                        phoneController.clear();
                      },
                      icon: Icon(
                        Icons.close,
                        size: height * 0.031,
                      ),
                    ),
                  ],
                ),
                // Phone number input field
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: custom_green, width: 2.0),
                    ),
                    hintText: "+92 3123456789",
                    labelText: "Enter the Phone Number",
                    labelStyle: const TextStyle(color: Colors.black),
                    floatingLabelStyle: TextStyle(color: custom_green),
                  ),
                ),
                SizedBox(height: height * 0.02),
                // Button to send OTP
                isLoading
                    ? CircularProgressIndicator(
                        color: custom_green,
                      )
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: custom_green,
                          padding: EdgeInsets.symmetric(
                              vertical: height * 0.015,
                              horizontal: width * 0.05),
                        ),
                        onPressed: () async {
                          try {
                            setState(
                              () {
                                isLoading = true; // Show loading indicator
                                if (isLoading == true) {
                                  CircularProgressIndicator(
                                    color: custom_green,
                                  );
                                }
                              },
                            );
                            final phoneNumber = phoneController.text;
                            // Validate the phone number input
                            if (phoneNumber.isEmpty) {
                              throw const FormatException(
                                  'Please Enter the Phone Number');
                            } else if (!phoneNumber.startsWith('+')) {
                              throw const FormatException(
                                  'Phone number must start with "+"');
                            }
                            // Verify phone number and handle OTP process
                            await FirebaseAuth.instance.verifyPhoneNumber(
                              phoneNumber: phoneNumber,
                              verificationCompleted: (phoneAuthCredential) {},
                              verificationFailed: (error) {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar(); // Hide current SnackBar if any
                                // Show error message if verification fails
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: custom_green,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(15),
                                      )),
                                      content: Text(
                                        'Verification failed: ${error.message}',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      )),
                                );
                                setState(() {
                                  isLoading = false; // Hide loading indicator
                                });
                              },
                              codeSent: (verificationId, forceResendingToken) {
                                setState(() {
                                  isLoading = false; // Hide loading indicator
                                });
                                Navigator.pop(context);
                                // Navigate to OTP screen with verification ID
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    // Use PageRouteBuilder for custom transition
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        OTPScreen(
                                            verificationId: verificationId),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      // Define the transition
                                      var begin = const Offset(
                                          1.0, 0.0); // Starting offset
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
                              codeAutoRetrievalTimeout: (verificationId) {},
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context)
                                .hideCurrentSnackBar(); // Hide current SnackBar if any
                            // Show error message if an exception occurs
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  backgroundColor: custom_green,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(15),
                                  )),
                                  content: Text(
                                    'Error: ${e.toString()}',
                                    style: const TextStyle(color: Colors.white),
                                  )),
                            );
                            setState(
                              () {
                                isLoading = false; // Hide loading indicator
                              },
                            );
                          }
                        },
                        child: Text(
                          "Send OTP",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.038,
                              color: Colors.white),
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
