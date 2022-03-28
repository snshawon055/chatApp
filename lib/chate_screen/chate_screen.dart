import 'package:chet_app/show_message/show_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

var loginUser = FirebaseAuth.instance.currentUser;

class ChateScreen extends StatefulWidget {
  const ChateScreen({Key? key}) : super(key: key);

  @override
  State<ChateScreen> createState() => _ChateScreenState();
}

class _ChateScreenState extends State<ChateScreen> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var message = TextEditingController();
  var storeMessage = FirebaseFirestore.instance;

  getCurrentUser() {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      loginUser = user;
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CircleAvatar(
          backgroundImage: NetworkImage(
            "https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png",
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.call,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.video_call,
            ),
          ),
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                      title: Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.person,
                        ),
                        title: Text("View Profile"),
                      ),
                      ListTile(
                        onTap: () async {
                          SharedPreferences preferences =
                              await SharedPreferences.getInstance();
                          Navigator.pop(context);
                          preferences.clear();
                        },
                        leading: Icon(
                          Icons.logout,
                        ),
                        title: Text("Log out"),
                      ),
                    ],
                  )),
                );
              },
              icon: Icon(
                Icons.menu_open,
              ))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 10),
          Expanded(child: ShowMessage()),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 25,
                    right: 25,
                    bottom: 10,
                  ),
                  child: TextField(
                    controller: message,
                    decoration: InputDecoration(
                      hintText: 'Write a Message',
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  if (message != null) {
                    await storeMessage.collection('MessageBox').doc().set({
                      'message': message.text.trim(),
                      'user': loginUser!.email.toString(),
                      'time': DateTime.now(),
                    });
                  }
                  message.clear();
                },
                child: Icon(
                  Icons.send,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
