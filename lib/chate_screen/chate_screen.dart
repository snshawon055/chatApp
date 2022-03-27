import 'package:chet_app/colors/colors.dart';
import 'package:chet_app/widgets/text_input_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

var loginUser = FirebaseAuth.instance.currentUser;

class ChateScreen extends StatefulWidget {
  const ChateScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ChateScreen> createState() => _ChateScreenState();
}

class _ChateScreenState extends State<ChateScreen> {
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
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(width: 15),
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                    'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png',
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  "username",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 80,
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.call,
                        color: Colors.blue,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.video_call,
                        color: Colors.blue,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Column(
                                children: [
                                  ListTile(
                                    leading: Icon(
                                      Icons.person,
                                    ),
                                    title: Text("View's profile"),
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
                                    title: Text(
                                      "Log out",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                      },
                      icon: Icon(
                        Icons.menu_open,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 40,
                      child: TextFormField(
                        controller: message,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            left: 15,
                          ),
                          hintText: "Write Message",
                          suffixIcon: InkWell(
                            onTap: () {
                              if (message != null) {
                                storeMessage
                                    .collection('messageBox')
                                    .doc()
                                    .set({
                                  'messageBox': message.text.trim(),
                                  'user': loginUser!.email.toString(),
                                  'time': DateTime.now(),
                                });
                              }
                              message.clear();
                            },
                            child: Icon(Icons.send),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.grey,
                              )),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.grey,
                          )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
