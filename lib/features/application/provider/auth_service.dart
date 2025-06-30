import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Sign up with email and password
  Future<String?> signUp(String email, String password, String username) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      await _auth.currentUser?.updateDisplayName(username);
      print('SignUp successful for: $email');
      return 'Success';
    } on FirebaseAuthException catch (e) {
      print('SignUp error: ${e.code} - ${e.message}');
      return _handleAuthError(e);
    } catch (e) {
      print('SignUp unexpected error: $e');
      return 'An unexpected error occurred';
    }
  }

  // Sign in with email and password
  Future<String?> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      print('SignIn successful for: $email');
      return 'Success';
    } on FirebaseAuthException catch (e) {
      print('SignIn error: ${e.code} - ${e.message}');
      return _handleAuthError(e);
    } catch (e) {
      print('SignIn unexpected error: $e');
      return 'An unexpected error occurred';
    }
  }

  // Sign in with Google
  Future<String?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print('Google Sign-In cancelled by user');
        return 'Google Sign-In cancelled';
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _auth.signInWithCredential(credential);
      print('Google Sign-In successful for: ${googleUser.email}');
      return 'Success';
    } on FirebaseAuthException catch (e) {
      print('Google Sign-In error: ${e.code} - ${e.message}');
      return _handleAuthError(e);
    } catch (e) {
      print('Google Sign-In unexpected error: $e');
      return 'An unexpected error occurred';
    }
  }

  // Send password reset email
  Future<String?> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      print('Password reset email sent to: $email');
      return 'Success';
    } on FirebaseAuthException catch (e) {
      print('Password reset error: ${e.code} - ${e.message}');
      return _handleAuthError(e);
    } catch (e) {
      print('Password reset unexpected error: $e');
      return 'An unexpected error occurred';
    }
  }

  // Reset password
  Future<String?> resetPassword(String newPassword) async {
    try {
      await _auth.currentUser?.updatePassword(newPassword);
      print('Password updated successfully');
      return 'Success';
    } on FirebaseAuthException catch (e) {
      print('Password update error: ${e.code} - ${e.message}');
      return _handleAuthError(e);
    } catch (e) {
      print('Password update unexpected error: $e');
      return 'An unexpected error occurred';
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      print('User signed out');
    } catch (e) {
      print('Sign out error: $e');
    }
  }

  // Get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Handle Firebase Auth errors
  String _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'The password is too weak.';
      case 'email-already-in-use':
        return 'The email is already in use.';
      case 'invalid-email':
        return 'The email address is invalid.';
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'invalid-credential':
        return 'Invalid credentials provided.';
      case 'requires-recent-login':
        return 'Please log in again to perform this action.';
      default:
        return 'Authentication failed: ${e.message}';
    }
  }
}