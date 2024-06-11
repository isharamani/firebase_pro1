import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_pro1/loginsignin/Signup.dart';
import 'package:firebase_pro1/loginsignin/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  userlogin({String? email,String? password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailcontroller.text,
          password: passwordcontroller.text
      );
      Get.to(Home_page());
     Get.snackbar("Home page open", "");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: InkWell(
              onTap: () {
                Get.to(Sign_up());
              },
              child: Text("Log In")),
        ),
        backgroundColor: Colors.teal.shade900,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Log in",
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: emailcontroller,
              decoration: InputDecoration(hintText: "Email"),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: passwordcontroller,
              decoration: InputDecoration(hintText: "Password"),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: () {
             userlogin(email: emailcontroller.text, password: passwordcontroller.text);
            }, child: Text("Login"))
          ],
        )
    );
  }
}
