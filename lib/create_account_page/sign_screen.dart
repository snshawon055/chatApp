import 'package:chet_app/controller/auth_controller.dart';
import 'package:chet_app/create_account_page/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/text_input_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  AuthController authController = AuthController();
  clearText() {
    emailController.clear();
    passwordController.clear();
    usernameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Flexible(child: Container(), flex: 2),
              Container(
                width: MediaQuery.of(context).size.width - 40,
                child: TextInputField(
                  controller: usernameController,
                  icon: Icons.person,
                  labelText: 'username',
                  textInputType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: MediaQuery.of(context).size.width - 40,
                child: TextInputField(
                  controller: emailController,
                  icon: Icons.email,
                  labelText: 'email address',
                  textInputType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: MediaQuery.of(context).size.width - 40,
                child: TextInputField(
                  controller: passwordController,
                  icon: Icons.remove_red_eye,
                  labelText: 'password',
                  textInputType: TextInputType.emailAddress,
                  isPass: true,
                ),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () async {
                  clearText() {
                    emailController.clear();
                    passwordController.clear();
                    usernameController.clear();
                  }

                  SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  sharedPreferences.setString('email', emailController.text);
                  if (emailController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty) {
                    authController.register(
                      context,
                      emailController.text,
                      passwordController.text,
                    );
                  } else {
                    authController.showError(context, "Data not found");
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.blue,
                  ),
                  child: Center(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(child: Container(), flex: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Already have an account? ",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      )),
                  const SizedBox(width: 6),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text(
                      "Log In",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
