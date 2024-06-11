import 'package:firebase_pro1/loginsignin/googleScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SigninwithGoogle extends StatelessWidget {
   SigninwithGoogle({super.key});

   List<String> scopes = <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ];

  GoogleSignIn _googleSignIn = GoogleSignIn(
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent.shade100,
        title: Text("Sign in with google"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(onPressed: () async {
                try {
                  await _googleSignIn.signIn();
                } catch (error) {
                  print(error);

              }
            }, child: Text("Sign in")),
          )
        ],
      ),
    );
  }
}
