import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_project/Login%20Signup%20Screen/Screen/Login.dart';
import 'package:flutter_firebase_project/Login%20Signup%20Screen/Screen/home_screen.dart';
import 'package:flutter_firebase_project/Login%20Signup%20Screen/Services/authentication.dart';
import 'package:flutter_firebase_project/Login%20Signup%20Screen/Widget/colors.dart';
import 'package:flutter_firebase_project/Login%20Signup%20Screen/Widget/snack_bar.dart';

import '../Widget/button.dart';
import '../Widget/text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Controllers for text fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    // Dispose controllers to free up resources
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  // Sign up the user
  void signUpUser() async {
    // Call the sign-up function from AuthServices
    String res = await AuthServices().signUpUser(
      email: emailController.text,
      password: passwordController.text,
      name: nameController.text,
    );

    // Display the result using a snackbar
    showSnackBar(context, res);

    // If sign-up is successful, navigate to HomeScreen
    if (res == "Success") {
      // Update the user's display name in Firebase
      User? user = FirebaseAuth.instance.currentUser;
      await user?.updateDisplayName(nameController.text);

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
      // If sign-up fails, stop the loading indicator
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: custom_white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.009,
            vertical: height * 0.01,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Display the sign-up image
                SizedBox(
                  width: double.infinity,
                  height: height * 0.38,
                  child: Image.asset("images/7.png"),
                ),

                // Name TextField
                TextFieldInput(
                  customBottomPadding: 0,
                  maxLines: 1,
                  isPass: false,
                  textEditingController: nameController,
                  hintText: "Name",
                  icon: Icons.person,
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

                // Sign Up Button
                MyButton(onTab: signUpUser, text: "SignUp"),

                SizedBox(height: height * 0.06),

                // Already have an account? Log in
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(fontSize: width * 0.038),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to LoginScreen
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const LoginScreen(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              var begin = const Offset(-1.0, 0.0);
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
                        " Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.04,
                          color: custom_green,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
