import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_project/Forgot%20Password/forgot_password.dart';
import 'package:flutter_firebase_project/Login%20Signup%20Screen/Screen/sign_up.dart';
import 'package:flutter_firebase_project/Login%20Signup%20Screen/Widget/button.dart';
import 'package:flutter_firebase_project/Login%20Signup%20Screen/Widget/colors.dart';
import 'package:flutter_firebase_project/Login%20Signup%20Screen/Widget/text_field.dart';
import 'package:flutter_firebase_project/Login%20With%20Google/google_auth.dart';
import 'package:flutter_firebase_project/Phone%20Auth/phone_login.dart';

import '../Services/authentication.dart';
import '../Widget/snack_bar.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controllers for text fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    // Dispose controllers to free resources
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Function to log in the user
  void loginUser() async {
    // Attempt to log in the user via AuthServices
    String res = await AuthServices().loginUser(
      email: emailController.text,
      password: passwordController.text,
    );

    // Show a snackbar with the login result
    showSnackBar(context, res);

    if (res == "Success") {
      // If login is successful, navigate to the HomeScreen
      setState(() {
        isLoading = true;
      });
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = const Offset(0.0, -1.0);
            var end = Offset.zero;
            var curve = Curves.ease;

            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
      );
    } else {
      setState(() {
        isLoading = false;
      });
      // Error message is already handled by the snackbar
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: custom_white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.01, vertical: height * 0.01),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Login image
                SizedBox(
                  width: double.infinity,
                  height: height * 0.38,
                  child: Image.asset("images/7.png"),
                ),

                // Email TextField
                TextFieldInput(
                  customBottomPadding: 0,
                  maxLines: 1,
                  isPass: false,
                  textEditingController: emailController,
                  hintText: "Email",
                  icon: Icons.email,
                ),

                // Password TextField
                TextFieldInput(
                  customBottomPadding: 0,
                  maxLines: 1,
                  textEditingController: passwordController,
                  hintText: "Password",
                  icon: Icons.lock,
                  isPass: true,
                ),

                // Login Button
                MyButton(onTab: loginUser, text: "Log In"),

                // Forgot Password Link
                const ForgotPassword(),
                SizedBox(height: height * 0.008),

                // Divider with 'or'
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: height * 0.001,
                        color: custom_green,
                      ),
                    ),
                    Text(
                      "  or  ",
                      style: TextStyle(
                          fontSize: width * 0.035, color: custom_green),
                    ),
                    Expanded(
                      child: Container(
                        height: height * 0.001,
                        color: custom_green,
                      ),
                    ),
                  ],
                ),

                // Google Login Button
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.06, vertical: height * 0.01),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: Colors.blueGrey,
                      padding: EdgeInsets.symmetric(
                          vertical: height * 0.001, horizontal: width * 0.06),
                    ),
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });

                      try {
                        // Sign in with Google
                        await FirebaseServices().signInWithGoogle();

                        // Check if the user is successfully signed in
                        if (FirebaseAuth.instance.currentUser != null) {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const HomeScreen(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                var begin = const Offset(0.0, -1.0);
                                var end = Offset.zero;
                                var curve = Curves.ease;

                                var tween = Tween(begin: begin, end: end).chain(
                                  CurveTween(curve: curve),
                                );
                                return SlideTransition(
                                  position: animation.drive(tween),
                                  child: child,
                                );
                              },
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context)
                              .hideCurrentSnackBar(); // Hide current SnackBar if any
                          // Show an error message if sign-in failed
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: custom_green,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                top: Radius.circular(15),
                              )),
                              content: const Text(
                                "Sign-in failed. Please try again.",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context)
                            .hideCurrentSnackBar(); // Hide current SnackBar if any
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
                          isLoading = false;
                        });
                      }
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: height * 0.03),
                        ),
                        Image.network(
                          "https://iili.io/HPtONX1.png",
                          height: height * 0.045,
                        ),
                        SizedBox(width: width * 0.04),
                        Text(
                          "Continue with Google",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: width * 0.048,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Phone Authentication
                const PhoneAuthentication(),

                // Sign Up Prompt
                Padding(
                  padding: EdgeInsets.only(top: height * 0.006),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(fontSize: width * 0.038),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigate to Sign Up Screen
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const SignUpScreen(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                var begin = const Offset(1.0, 0.0);
                                var end = Offset.zero;
                                var curve = Curves.ease;

                                var tween = Tween(begin: begin, end: end).chain(
                                  CurveTween(curve: curve),
                                );
                                return SlideTransition(
                                  position: animation.drive(tween),
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        child: Text(
                          " SignUp",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.04,
                              color: custom_green),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
