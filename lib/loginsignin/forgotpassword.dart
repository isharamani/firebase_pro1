import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  var emailcontroller = TextEditingController();
  String email = "";

  final _formkey = GlobalKey<FormState>();


  resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: "isharamani160@gmail.com");
    }on FirebaseAuthException catch (e){
      print("Error $e");
      Get.snackbar("Error", "$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent.shade100,
        title: Text("Forgot Password"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formkey,
              child: TextFormField(
                controller: emailcontroller,
                decoration: InputDecoration(
                    hintText: "Email"
                ),
                style: TextStyle(color: Colors.black),
                validator: (value){
                  if(value!.isEmpty){
                    return "Please enter your email";
                  }
                  return null;
                },
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if(_formkey.currentState!.validate()){
                setState(() {
                  email = emailcontroller.text;
                });
                resetPassword();
              }
            },
            child: Text("Send Email"),
          )
        ],
      ),
    );
  }
}
