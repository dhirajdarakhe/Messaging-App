import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class Authmethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  appUse? _userFromFirebaseUser(User user) {
    return user != null ? appUse(userId: user.uid) : null;}
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      // final result = await _auth.signInWithEmailAndPassword(
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? firebaseUse = result.user;
      return _userFromFirebaseUser(firebaseUse!);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signUnWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser!);
    } catch (e) {
      print(e.toString());
    }
  }

  Future resetpass(String email, String password) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }
  Future SignOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}

class appUse {
  String userId;
  appUse({
    required this.userId,

  });
}


//this file is used  for
// 1 ) to store the username , email, password of the  user when user will sign up
// 2 ) for sign in
// 3 ) for sign out
