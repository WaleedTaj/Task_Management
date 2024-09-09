import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_project/Login%20Signup%20Screen/Screen/home_screen.dart';
import 'package:flutter_firebase_project/Login%20Signup%20Screen/Widget/colors.dart';

class OTPScreen extends StatefulWidget {
  // The verification ID received from the phone authentication process
  final String verificationId;

  // Constructor to receive the verification ID
  const OTPScreen({super.key, required this.verificationId});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  // Controller to manage the OTP input field
  TextEditingController otpController = TextEditingController();

  // Indicator to show loading state
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    // Getting screen dimensions for responsive design
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    // Main screen layout starts here
    return Scaffold(
      backgroundColor: custom_white,
      resizeToAvoidBottomInset: true, // Avoid resizing when keyboard appears
      body: SafeArea(
        child: Column(
          children: [
            // Image at the top of the screen
            SizedBox(
              width: double.infinity,
              height: height * 0.4,
              child: Image.asset(
                "images/7.png",
              ),
            ),
            // Title of the screen
            Text(
              "OTP Verification",
              style: TextStyle(
                fontSize: width * 0.07,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Description text
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.08),
              child: Text(
                textAlign: TextAlign.center,
                "We need to register your phone by using a one-time OTP code verification.",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: width * 0.046,
                ),
              ),
            ),
            // OTP input field
            Padding(
              padding: EdgeInsets.all(width * 0.04),
              child: TextField(
                controller: otpController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: width * 0.07, vertical: height * 0.019),
                    filled: true,
                    fillColor: const Color(0xFFedf0f8),
                    // Style for the enabled border of the text field
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: width * 0.006, color: Colors.white),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    // Style for the focused border of the text field
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: width * 0.006, color: custom_green),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    labelText: "Enter the OTP",
                    labelStyle: TextStyle(fontSize: width * 0.043),
                    prefixIcon: Icon(
                      Icons.password,
                      color: custom_green,
                    )),
              ),
            ),
            SizedBox(
              height: height * 0.003,
            ),
            // Button to verify OTP
            isLoading
                ? CircularProgressIndicator(
                    color: custom_green,
                  )
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: custom_green,
                      padding: EdgeInsets.symmetric(
                        vertical: height * 0.009,
                        horizontal: width * 0.06,
                      ),
                    ),
                    onPressed: () async {
                      try {
                        setState(() {
                          isLoading = true; // Show loading indicator
                        });

                        // Create credential using the verification ID and OTP
                        final credential = PhoneAuthProvider.credential(
                          verificationId: widget.verificationId,
                          smsCode: otpController.text,
                        );

                        // Sign in with the credential
                        await FirebaseAuth.instance
                            .signInWithCredential(credential);

                        ScaffoldMessenger.of(context)
                            .hideCurrentSnackBar(); // Hide current SnackBar if any

                        // Show success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: custom_green,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(15),
                              ),
                            ),
                            content: const Text(
                              "Success",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );

                        // Navigate to the home screen
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            // Use PageRouteBuilder for custom transition
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const HomeScreen(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              // Define the transition
                              var begin =
                                  const Offset(0.0, -1.0); // Starting offset
                              var end = Offset.zero; // Ending offset
                              var curve = Curves
                                  .ease; // Transition curve (ease in this case)

                              var tween = Tween(begin: begin, end: end).chain(
                                // Create a tween for the transition
                                CurveTween(curve: curve),
                              );
                              return SlideTransition(
                                // Use SlideTransition for the animation
                                position: animation.drive(
                                    tween), // Apply the tween to the animation
                                child: child, // The widget to be animated
                              );
                            },
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context)
                            .hideCurrentSnackBar(); // Hide current SnackBar if any
                        // Show error message if OTP verification fails
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: custom_green,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                              top: Radius.circular(15),
                            )),
                            content: Text(
                              e.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      } finally {
                        setState(() {
                          isLoading = false; // Hide loading indicator
                        });
                      }
                    },
                    child: Text(
                      "Verify",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.05,
                        color: Colors.white,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
