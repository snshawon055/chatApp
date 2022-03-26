import 'package:chet_app/chate_screen/chate_screen.dart';
import 'package:chet_app/create_account_page/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void signInWithGoogle(context) async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuthentication =
        await googleSignInAccount!.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuthentication.idToken,
        accessToken: googleAuthentication.accessToken);
    UserCredential cred = await firebaseAuth.signInWithCredential(credential);
    User? user = cred.user;
    if (user != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ChateScreen()));
    }
  }

  void register(context, email, password) async {
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then(
            (value) => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
            ),
          );
    } catch (e) {
      showError(context, e);
    }
  }

  void loginUser(context, email, password) async {
    try {
      await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
            (value) => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChateScreen(),
              ),
            ),
          );
    } catch (e) {
      showError(context, e);
    }
  }

  void signOut(context) async {
    try {
      await firebaseAuth.signOut().then(
            (value) => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
            ),
          );
    } catch (e) {
      showError(context, e);
    }
  }

  void showError(context, e) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Data not found"),
        content: Text(
          e.toString(),
        ),
      ),
    );
  }
}
