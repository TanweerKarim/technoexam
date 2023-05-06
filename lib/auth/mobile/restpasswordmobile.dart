import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tiuexamportal/globals.dart';
import 'package:tiuexamportal/screens/mainscreen.dart';
import 'package:tiuexamportal/utility/utility.dart';

class RestPasswordMobile extends StatefulWidget {
  String email;
  RestPasswordMobile({
    super.key,
    required this.email,
  });

  @override
  State<RestPasswordMobile> createState() => _RestPasswordMobileState();
}

class _RestPasswordMobileState extends State<RestPasswordMobile> {
  var con1 = TextEditingController();
  var con2 = TextEditingController();
  var con3 = TextEditingController();
  String password = "";
  String newPassword = "";
  String confirmPassword = "";
  @override
  Widget build(BuildContext context) {
    var heightsize = MediaQuery.of(context).size.height;
    var widthsize = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Center(
              child: Column(
            children: [
              SizedBox(
                height: heightsize * 0.15,
              ),
              Text(
                "Reset Password",
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
                    password = value;
                  }),
                  controller: con1,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Enter Old Password',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: widthsize * 0.85,
                child: TextField(
                  onChanged: (value) => setState(() {
                    newPassword = value;
                  }),
                  controller: con2,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    hintText: 'Enter new password',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: widthsize * 0.85,
                child: TextField(
                  onChanged: (value) => setState(() {
                    confirmPassword = value;
                  }),
                  controller: con3,
                  onSubmitted: (value) async {
                    setState(() {
                      confirmPassword = value;
                    });
                    if (password == '' ||
                        newPassword == '' ||
                        confirmPassword == '') {
                      showSnackBar(
                          context: context, content: 'All fields are required');
                    } else if (password == newPassword) {
                      showSnackBar(
                          context: context,
                          content: 'You can\'t use your old passowrd');
                    } else {
                      if (newPassword == confirmPassword) {
                        var user = FirebaseAuth.instance.currentUser;
                        var credential = EmailAuthProvider.credential(
                            email: widget.email, password: password);
                        await user
                            ?.reauthenticateWithCredential(credential)
                            .then((value) async {
                          await user
                              .updatePassword(newPassword)
                              .then((value) async {
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(user.uid)
                                .update({
                              'password': newPassword,
                            }).then((value) => showSnackBar(
                                    context: context,
                                    content: "Password Updated successfully"));
                            setState(() {});
                          });
                          con1.clear();
                          con2.clear();
                          con3.clear();
                        }).onError((error, stackTrace) {
                          showSnackBar(
                              context: context,
                              content: 'Old password is incorrect');
                        });
                      } else {
                        showSnackBar(
                            context: context,
                            content:
                                'New password and confirm password did not match');
                      }
                    }
                  },
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    hintText: 'Confirm new password',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: widthsize * 0.85,
                child: InkWell(
                  onTap: () async {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: widget.email)
                        .then((value) {
                      showSnackBar(
                          context: context,
                          content:
                              'An email has been sent to your registered email to rest your password!');
                    });
                  },
                  child: Text(
                    "Click here to reset password through email!",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 12,
                    ),
                  ),
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
                    if (password == '' ||
                        newPassword == '' ||
                        confirmPassword == '') {
                      showSnackBar(
                          context: context, content: 'All fields are required');
                    } else if (password == newPassword) {
                      showSnackBar(
                          context: context,
                          content: 'You can\'t use your old passowrd');
                    } else {
                      if (newPassword == confirmPassword) {
                        var user = FirebaseAuth.instance.currentUser;
                        var credential = EmailAuthProvider.credential(
                            email: widget.email, password: password);
                        await user
                            ?.reauthenticateWithCredential(credential)
                            .then((value) async {
                          await user
                              .updatePassword(newPassword)
                              .then((value) async {
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(user.uid)
                                .update({
                              'password': newPassword,
                            }).then((value) => showSnackBar(
                                    context: context,
                                    content: "Password Updated successfully"));
                            setState(() {});
                          });
                          con1.clear();
                          con2.clear();
                          con3.clear();
                        }).onError((error, stackTrace) {
                          showSnackBar(
                              context: context,
                              content: 'Old password is incorrect');
                        });
                      } else {
                        showSnackBar(
                            context: context,
                            content:
                                'New password and confirm password did not match');
                      }
                    }
                  },
                  child: Text("Reset"),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
