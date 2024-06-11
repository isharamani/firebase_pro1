import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_pro1/loginsignin/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpScreen extends StatefulWidget {
  final String verificationid;
  const OtpScreen({super.key, required this.verificationid});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  var otpController = TextEditingController();
  final _formkey = GlobalKey<FormState>();



  otpFunction({addVid, addCode}) async {
    PhoneAuthCredential credential =
    PhoneAuthProvider.credential(verificationId: addVid, smsCode: addCode);
    try {
      await FirebaseAuth.instance.signInWithCredential(credential).then((
          value) => Get.offAll(() =>Home_page()));
    }
    on FirebaseAuthException catch (e){
      Get.snackbar("Error", "");
    }catch(e){
      Get.snackbar("error", "");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent.shade100,
        title: Text("Otp Screen"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Form(
            key: _formkey,
            child: TextFormField(
              controller: otpController,
              maxLength: 6,
              decoration: InputDecoration(labelText: "Otp"),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter your email";
                } else {
                  return null;
                }
              },
            ),
          ),
          SizedBox(
            height: 40,
          ),
          ElevatedButton(
              onPressed: () {
                if (_formkey.currentState!.validate()) {
                  otpFunction(
                    addCode: otpController.value.text,
                    addVid: widget.verificationid,
                  );
                }
              },
              child: Text("Otp Sent"))
        ],
      ),
    );
  }
}
