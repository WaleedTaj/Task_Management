import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseServices {
  // FirebaseAuth instance for authentication
  final auth = FirebaseAuth.instance;
  // GoogleSignIn instance for Google authentication
  final googleSignIn = GoogleSignIn();

  // Sign in with Google
  Future<void> signInWithGoogle() async {
    try {
      // Start the Google sign-in flow
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      // Check if the user has signed in successfully
      if (googleSignInAccount != null) {
        // Obtain the authentication details from the Google account
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        // Create an AuthCredential object using the obtained tokens
        final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        // Sign in to Firebase with the obtained credentials
        await auth.signInWithCredential(authCredential);
      }
    } on FirebaseAuthException catch (e) {
      // Print any errors that occur during the sign-in process
      print(e.toString());
    }
  }

  // Sign out from Google
  Future<void> googleSignOut() async {
    // Sign out from Google account
    await googleSignIn.signOut();
  }
}
