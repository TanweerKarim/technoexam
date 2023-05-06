import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tiuexamportal/globals.dart';
import 'package:tiuexamportal/screens/mainscreen.dart';
import 'package:tiuexamportal/utility/utility.dart';

class ForgetpasswordMobile extends StatefulWidget {
  ForgetpasswordMobile({
    super.key,
  });

  @override
  State<ForgetpasswordMobile> createState() => _ForgetpasswordMobileState();
}

class _ForgetpasswordMobileState extends State<ForgetpasswordMobile> {
  var con1 = TextEditingController();
  String email = "";
  @override
  Widget build(BuildContext context) {
    var heightsize = MediaQuery.of(context).size.height;
    var widthsize = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Techno Exam Portal"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
              child: Column(
            children: [
              SizedBox(
                height: heightsize * 0.25,
              ),
              Text(
                "Forget Password",
                style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.blue,
                    fontFamily: 'Aboreto',
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: widthsize * 0.85,
                child: TextField(
                  onChanged: (value) => setState(() {
                    email = value;
                  }),
                  controller: con1,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Enter email',
                  ),
                  onSubmitted: (value) async {
                    setState(() {
                      email = value;
                    });
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: email)
                        .then((value) {
                      showSnackBar(
                          context: context,
                          content:
                              'An email has been sent to your registered email to rest your password!');
                    });
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: widthsize * 0.85,
                height: 40,
                child: ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: email)
                        .then((value) {
                      con1.clear;
                      showSnackBar(
                          context: context,
                          content:
                              'An email has been sent to your email to rest your password!');
                    }).onError((error, stackTrace) {
                      showSnackBar(
                          context: context, content: "Email don't exists");
                    });
                  },
                  child: Text("Reset"),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: widthsize * 0.85,
                child: Text(
                    "Note - If you do not receive the email in your Inbox then check your spam folder"),
              )
            ],
          )),
        ),
      ),
    );
  }
}
