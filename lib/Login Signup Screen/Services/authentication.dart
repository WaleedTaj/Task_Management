import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_firebase_project/Model/notes_model.dart';
import 'package:uuid/uuid.dart';

class AuthServices {
  // Firebase Firestore instance to interact with Firestore database
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // FirebaseAuth instance to manage user authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method to sign up a user with email, password, and name
  Future<String> signUpUser({
    required String email,
    required String password,
    required String name,
  }) async {
    // Default response message indicating an error
    String res = "Error Occurred";

    try {
      // Ensure all required fields are provided
      if (email.isNotEmpty && password.isNotEmpty && name.isNotEmpty) {
        // Register the user with Firebase Authentication
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Store user's data in Firestore under the "users" collection
        await _firestore.collection("users").doc(credential.user!.uid).set({
          'name': name, // User's name
          'email': email, // User's email
          'uid': credential.user!.uid, // Unique user ID
        });

        // Return "Success" if registration and data storage are successful
        res = "Success";
      } else {
        // Return message asking to fill all fields if any are empty
        res = "Please Enter All The Fields";
      }
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase authentication errors
      if (e.code == 'email-already-in-use') {
        // Email already used for another account
        res = "The email is already in use by another account.";
      } else if (e.code == 'weak-password') {
        // Provided password is too weak
        res = "The password provided is too weak.";
      } else {
        // Any other Firebase authentication error
        res = e.message ?? "An unknown error occurred.";
      }
    } catch (e) {
      // Handle general errors
      res = e.toString();
    }

    // Return the result of the signup attempt
    return res;
  }

  // Method to log in a user with email and password
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    // Default response message indicating an error
    String res = "Error Occurred";

    try {
      // Ensure both email and password are provided
      if (email.isNotEmpty && password.isNotEmpty) {
        // Log in the user with Firebase Authentication
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        // Return "Success" if login is successful
        res = "Success";
      } else {
        // Return message asking to fill all fields if any are empty
        res = "Please Enter All The Fields";
      }
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase authentication errors
      if (e.code == 'user-not-found') {
        // No user found with the provided email
        res = "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        // Incorrect password provided
        res = "Incorrect password provided.";
      } else {
        // Any other Firebase authentication error
        res = e.message ?? "An unknown error occurred.";
      }
    } catch (e) {
      // Handle general errors
      res = e.toString();
    }

    // Return the result of the login attempt
    return res;
  }

  // Method to log out the currently authenticated user
  Future<void> signOut() async {
    // Sign out the user using Firebase Authentication
    await _auth.signOut();
  }

  // Method to add a new note to Firestore
  Future<bool> AddNote(String title, String subtitle, int image) async {
    try {
      // Generate a unique identifier for the new note
      var uuid = const Uuid().v4();
      // Get the current date and time
      DateTime dateTime = DateTime.now();

      // Add the note to Firestore under the current user's "Notes" collection
      await _firestore
          .collection('UserData') // Collection for user data
          .doc(_auth.currentUser!.uid) // Document for the current user
          .collection('Notes') // Sub-collection for notes
          .doc(uuid) // Document ID for the new note
          .set({
        'id': uuid, // Unique identifier for the note
        'title': title, // Title of the note
        'subtitle': subtitle, // Subtitle of the note
        'image': image, // Image associated with the note
        'time':
            '${dateTime.hour}:${dateTime.minute}', // Timestamp when the note was created
        'isDone': false, // Status of the note (not done by default)
      });
      return true; // Indicate that the operation was successful
    } catch (e) {
      // Handle errors and return true as a placeholder; ideally, return false or handle the error properly
      print(e);
      return false; // Indicate that the operation failed
    }
  }

  // Method to retrieve a list of notes from Firestore
  List getNotes(AsyncSnapshot snapshot) {
    try {
      // Map the snapshot data to a list of Note objects
      final notesList = snapshot.data.docs.map((doc) {
        final data = doc.data()
            as Map<String, dynamic>; // Convert document data to a Map
        return Note(
          data['id'], // Note ID
          data['title'], // Note title
          data['subtitle'], // Note subtitle
          data['time'], // Note creation time
          data['image'], // Note image
          data['isDone'], // Note status
        );
      }).toList();
      return notesList; // Return the list of notes
    } catch (e) {
      // Handle errors and return an empty list
      print(e);
      return []; // Return an empty list if an error occurs
    }
  }

  // Method to return a stream of notes filtered by their 'isDone' status
  Stream<QuerySnapshot> stream(bool isDone) {
    return _firestore
        .collection('UserData') // Collection for user data
        .doc(_auth.currentUser!.uid) // Document for the current user
        .collection('Notes') // Sub-collection for notes
        .where('isDone', isEqualTo: isDone) // Filter by 'isDone' status
        .snapshots(); // Return a stream of snapshots
  }

  // Method to update the 'isDone' status of a note
  Future<bool> isCheckboxDone(String uuid, bool isDone) async {
    try {
      await _firestore
          .collection('UserData') // Collection for user data
          .doc(_auth.currentUser!.uid) // Document for the current user
          .collection('Notes') // Sub-collection for notes
          .doc(uuid) // Document ID of the note to update
          .update({'isDone': isDone}); // Update the 'isDone' field
      return true; // Indicate that the operation was successful
    } catch (e) {
      // Handle errors and return true as a placeholder; ideally, return false or handle the error properly
      print(e);
      return false; // Indicate that the operation failed
    }
  }

  // Method to update an existing note with new details
  Future<bool> updateNote(
      String uuid, int image, String title, String subtitle) async {
    try {
      // Get the current date and time
      DateTime dateTime = DateTime.now();

      await _firestore
          .collection('UserData') // Collection for user data
          .doc(_auth.currentUser!.uid) // Document for the current user
          .collection('Notes') // Sub-collection for notes
          .doc(uuid) // Document ID of the note to update
          .update({
        'time': '${dateTime.hour}:${dateTime.minute}', // Update the timestamp
        'title': title, // Update the note title
        'subtitle': subtitle, // Update the note subtitle
        'image': image, // Update the note image
      });
      return true; // Indicate that the operation was successful
    } catch (e) {
      // Handle errors and return true as a placeholder; ideally, return false or handle the error properly
      print(e);
      return false; // Indicate that the operation failed
    }
  }

  // Method to delete a note from Firestore
  Future<bool> deleteNote(String uuid) async {
    try {
      await _firestore
          .collection('UserData') // Collection for user data
          .doc(_auth.currentUser!.uid) // Document for the current user
          .collection('Notes') // Sub-collection for notes
          .doc(uuid) // Document ID of the note to delete
          .delete(); // Delete the document
      return true; // Indicate that the operation was successful
    } catch (e) {
      // Handle errors and return true as a placeholder; ideally, return false or handle the error properly
      print(e);
      return false; // Indicate that the operation failed
    }
  }
}
