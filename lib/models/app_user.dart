import 'package:firebase_auth/firebase_auth.dart';

class AppUser {
  final String uid;
  final String? email;
  final String? displayName;
  final bool isAdmin;

  AppUser({
    required this.uid,
    this.email,
    this.displayName,
    this.isAdmin = false,
  });

  factory AppUser.fromFirebaseUser(User user, {bool isAdmin = false}) => AppUser(
        uid: user.uid,
        email: user.email,
        displayName: user.displayName,
        isAdmin: isAdmin,
      );
}