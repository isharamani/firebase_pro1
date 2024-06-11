import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_pro1/loginsignin/otp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {

  final _formKey = GlobalKey<FormState>();

  var phonecontroller = TextEditingController();

  GetPhoneNo({number}) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91" +number,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) {
           Get.to(OtpScreen(verificationid: verificationId));
          Get.snackbar("Otp Sent", "",snackPosition: SnackPosition.TOP,);


        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    }
    catch (e) {
      Get.snackbar("Error", "$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.purpleAccent.shade100,
          title: Text("Phone Auth"),),
        body:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: TextFormField(
                controller: phonecontroller,
                decoration: InputDecoration(
                  labelText: "Phone No"
                ),
                validator: (value) {
                  if(value!.isEmpty){
                    return "Please enter your email";
                  }
                  else{
                     return null;
                  }
                },
              ),
            ),
            SizedBox(height:
              20,),
            ElevatedButton(onPressed: () {
              if (_formKey.currentState!.validate()) {
          GetPhoneNo(number: phonecontroller.value.text);    }
            } , child: Text("Send Number"))
          ],
        )
    );
  }
}
