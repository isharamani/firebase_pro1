import 'package:firebase_pro1/loginsignin/Signup.dart';
import 'package:firebase_pro1/loginsignin/forgotpassword.dart';
import 'package:firebase_pro1/loginsignin/phone_auth.dart';
import 'package:firebase_pro1/loginsignin/signinwithgoogle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class Home_page extends StatefulWidget {
  const Home_page({super.key});

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent.shade100,
        title: Text("Flutter Firebase"),),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           InkWell(
             onTap: () {
               Get.to(Sign_up());
             },
             child: Container(
               height: 70,
               width: Get.width/1.1,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(20),
                 color: Colors.purpleAccent.shade100,
               ),
               child: Center(child: Row(
                 children: [
                   Text("  Email with Password Auth",style: TextStyle(color: Colors.purple,fontSize: 18),),
                   SizedBox(width: Get.width/4.1,),
                   Icon(Icons.email,color: Colors.purple,)
                 ],
               )),
             ),

           ),
            SizedBox(height: 20,),
            InkWell(
              onTap: () {
                Get.to(ForgotPassword());
              },
              child: Container(
                height: 70,
                width: Get.width/1.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.purpleAccent.shade100,
                ),
                child: Center(child: Row(
                  children: [
                    Text("  Forgot Password",style: TextStyle(color: Colors.purple,fontSize: 18),),
                    SizedBox(width: Get.width/2.4),
                    Icon(Iconsax.password_check,color: Colors.purple,)
                  ],
                )),
              ),
            ),
            SizedBox(height: 20,),
            InkWell(
              onTap: () {
                Get.to(PhoneAuth());
              },
              child: Container(
                height: 70,
                width: Get.width/1.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.purpleAccent.shade100,
                ),
                child: Center(child: Row(
                  children: [
                    Text("  Phone_auth",style: TextStyle(color: Colors.purple,fontSize: 18),),
                    SizedBox(width: Get.width/1.9,),
                    Icon(Iconsax.call,color: Colors.purple,)
                  ],
                )),
              ),
            ),
            SizedBox(height: 20,),
            InkWell(
              onTap: () {
                Get.to(SigninwithGoogle());
              },
              child: Container(
                height: 70,
                width: Get.width/1.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.purpleAccent.shade100,
                ),
                child: Center(child: Row(
                  children: [
                    Text("  Sign in with Google",style: TextStyle(color: Colors.purple,fontSize: 18),),
                    SizedBox(width: Get.width/2.6,),
                    Icon(Iconsax.chrome,color: Colors.purple,)
                  ],
                )),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
