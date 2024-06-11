import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_pro1/loginsignin/homepage.dart';
import 'package:firebase_pro1/loginsignin/loginn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Sign_up extends StatefulWidget {
  const Sign_up({super.key});

  @override
  State<Sign_up> createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  userSignup({String? email,String? password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailcontroller.text,
          password: passwordcontroller.text);
      Get.to(Login());
      Get.snackbar("Login successfully", "congretulation");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
            onTap: () {
              Get.to(Home_page());
            },
            child: Text("Sign Up")),
      ),
        backgroundColor: Colors.teal.shade900,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Sign up",
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(controller: emailcontroller,
              decoration: InputDecoration(hintText: "Email"),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(controller: passwordcontroller,
              decoration: InputDecoration(hintText: "Password"),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: () {
              userSignup(email: emailcontroller.text, password: passwordcontroller.text);
            }, child: Text("Sign up"))
          ],
        ));
  }
}
