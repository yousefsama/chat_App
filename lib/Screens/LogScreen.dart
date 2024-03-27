import 'package:chat/Screens/ChatScreen.dart';

import 'package:chat/Widgets/ElevatedBottun.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat/Widgets/CustomTextField.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static String id = "LoginScreen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    String? email;
    String? password;
    bool isLoading = false;
    GlobalKey<FormState> formKey = GlobalKey();
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      progressIndicator: CircularProgressIndicator(),
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: Image.asset(
                    'assets/images/scholar.png',
                    width: 100,
                    height: 100,
                  ),
                ),
                Center(
                  child: Text(
                    "Scollar Chat",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontFamily: "Pacifico",
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Sign in",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 27,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hint: "Enter your username",
                  isPassowrd: false,
                  onChanged: (value) {
                    email = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hint: 'Enter your password',
                  isPassowrd: true,
                  onChanged: (value) {
                    password = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                Elevatedbottun(
                    textBottun: 'Sign in',
                    ontap: () async {
                      try {
                        await userSignin(email, password);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (conext) {
                            return ChatScreen();
                          }),
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          Snakbar(context, "user-not-found");
                        } else if (e.code == 'wrong-password') {
                          Snakbar(context, "wrong password");
                        }
                      } catch (e) {
                        Snakbar(context, "please try again");
                      } catch (e) {
                        print(e.toString());
                      }

                      // setState(() {});
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("don\'t have an accont"),
                    TextButton(
                        style: ButtonStyle(),
                        onPressed: () {
                          Navigator.pushNamed(context, "RegisterScreen");
                        },
                        child: Text(
                          'create account',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> userSignin(String? email, String? password) async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }

  void Snakbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 5),
        content: Text(message),
      ),
    );
  }

  Future<void> loginUser(String? email, String? password) async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
