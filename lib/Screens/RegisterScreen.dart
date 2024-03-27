import 'package:chat/Widgets/ElevatedBottun.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat/Widgets/CustomTextField.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static String id = 'RegisterScreen';
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    String? email;
    String? password;
    bool isLoading = false;
    GlobalKey<FormState> formKey = GlobalKey();
    return ModalProgressHUD(
      inAsyncCall: isLoading,
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
                      "Sign up",
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
                  textBottun: 'Sign Up',
                  ontap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await registerUser(email, password);
                        Snakbar(context, "done");
                        Navigator.pop(context);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          Snakbar(context, "Weak Password");
                        } else if (e.code == 'email-already-in-use') {
                          Snakbar(context, "email is already exist");
                        }
                      } catch (e) {
                        print(e);
                        return Snakbar(context, "failed please try agin :( ");
                      }

                      // setState(() {});
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("you have already accont"),
                    TextButton(
                        style: ButtonStyle(),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Sign in',
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

  void Snakbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 5),
        content: Text(message),
      ),
    );
  }

  Future<void> registerUser(String? email, String? password) async {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
