import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ketub_platform/screens/authentication/user_screen.dart';
import '../../models/user_model.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  Future<void> _createUserInFirestore(User user) async {
    final userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);
    final docSnapshot = await userDoc.get();
    if (!docSnapshot.exists) {
      final userModel = UserModel(
        userId: user.uid,
        email: user.email ?? '',
        passwordHash: '',
        profilePictureUrl: user.photoURL ?? '',
        createdAt: Timestamp.now(),
      );
      await userDoc.set(userModel.toJson());
    }
  }

  Future<User?> _signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return null;
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    return userCredential.user;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            return Scaffold(
              appBar: AppBar(title: const Text('Sign In')),
              body: Center(
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      final user = await _signInWithGoogle();
                      if (user != null) {
                        _createUserInFirestore(user);
                      }
                    } catch (e) {
                      print("Error signing in with Google: $e");
                    }
                  },
                  child: const Text('Sign in with Google'),
                ),
              ),
            );
          } else {
            _createUserInFirestore(user);
            return UserScreen(user: user);
          }
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
