import 'package:firebase_auth/firebase_auth.dart';

class AuthHelper {
  static User getAuthenticatedUser() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User is not authenticated');
    }
    return user;
  }
}
