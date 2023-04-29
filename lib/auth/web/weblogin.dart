import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tiuexamportal/screens/mainscreen.dart';
import 'package:tiuexamportal/utility/utility.dart';

class LoginWebView extends StatefulWidget {
  const LoginWebView({super.key});

  @override
  State<LoginWebView> createState() => _LoginWebViewState();
}

class _LoginWebViewState extends State<LoginWebView> {
  String email = "";
  String password = "";

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

      body: Container(
        child: Center(
            child: Column(
          children: [
            SizedBox(
              height: heightsize * 0.15,
            ),
            Text(
              "Sign In",
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
              width: widthsize * 0.3,
              child: TextField(
                onChanged: (value) => setState(() {
                  email = value;
                }),
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: widthsize * 0.3,
              child: TextField(
                onChanged: (value) => setState(() {
                  password = value;
                }),
                onSubmitted: (value) async {
                  setState(() {
                    password = value;
                  });
                  if (email == '' || password == '') {
                    showSnackBar(
                        context: context, content: 'All fields are required');
                  } else {
                    await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: email, password: password)
                        .then((value) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainScreen(),
                        ),
                        (route) => false,
                      );
                    }).onError((error, stackTrace) {
                      showSnackBar(
                          context: context,
                          content: "Invalid email or password");
                    });
                  }
                },
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(
                  hintText: 'Enter your password',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: widthsize * 0.3,
              child: Text(
                "Forget password?",
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.blue),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: widthsize * 0.3,
              height: 40,
              child: ElevatedButton(
                onPressed: () async {
                  if (email == '' || password == '') {
                    showSnackBar(
                        context: context, content: 'All fields are required');
                  } else {
                    await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: email, password: password)
                        .then((value) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainScreen(),
                        ),
                        (route) => false,
                      );
                    }).onError((error, stackTrace) {
                      showSnackBar(
                          context: context,
                          content: "Invalid email or password");
                    });
                  }
                },
                child: Text("Sign In"),
              ),
            ),
          ],
        )),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
