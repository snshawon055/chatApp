import 'package:chet_app/chate_screen/chate_screen.dart';
import 'package:chet_app/colors/colors.dart';
import 'package:chet_app/create_account_page/login.dart';
import 'package:chet_app/create_account_page/sign_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  final email = preferences.getString("email");
  runApp(
    MaterialApp(
      theme:
          ThemeData.dark().copyWith(scaffoldBackgroundColor: backgroundColor),
      debugShowCheckedModeBanner: false,
      home: email != null ? ChateScreen() : LoginPage(),
    ),
  );
}
