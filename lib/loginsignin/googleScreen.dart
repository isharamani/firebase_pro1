import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_pro1/loginsignin/database.dart';
import 'package:firebase_pro1/loginsignin/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMethod {
  final FirebaseAuth auth = FirebaseAuth.instance;

  getCurrentUser() async {
    return await auth.currentUser;
  }

  signInWithGoogle(BuildContext context) async {

    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    final GoogleSignIn googleSignin = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount = await googleSignin.signIn();

    final GoogleSignInAuthentication? googleSignInAuthentication= await googleSignInAccount?.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication?.idToken,
      accessToken: googleSignInAuthentication?.accessToken
    );

    UserCredential result = await firebaseAuth.signInWithCredential(credential);

    User? userDetails= result.user;

    if(result!=null){
      Map<String,dynamic> userInfoMap ={
        "email":userDetails!.email,
        "name":userDetails.displayName,
        "imgUrl":userDetails.photoURL,
        "id":userDetails.uid,
      };

      await DatabaseMethod().addUser(userDetails.uid,userInfoMap).then((value){
        Get.to(Home_page());
      });
    }
  }
}
