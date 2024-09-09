import 'package:flutter/material.dart';
import 'package:flutter_firebase_project/Login%20Signup%20Screen/Widget/colors.dart';

/// Function to show a SnackBar with a given text message.
///
/// This function utilizes the `ScaffoldMessenger` to display a `SnackBar`
/// in the current `Scaffold` context.
///
/// - [context]: The `BuildContext` in which the `SnackBar` should be shown.
/// - [text]: The message to be displayed inside the `SnackBar`.
showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
      .hideCurrentSnackBar(); // Hide any currently visible SnackBar
  // Use the ScaffoldMessenger to show the SnackBar
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: custom_green,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(15),
      )),
      content: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ), // Display the passed text in the SnackBar content
    ),
  );
}
