import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tiuexamportal/auth/mobile/mobilelogin.dart';
import 'package:tiuexamportal/auth/web/weblogin.dart';
import 'package:tiuexamportal/utility/responsive_layout.dart';

class LogoutWeb extends StatefulWidget {
  const LogoutWeb({super.key});

  @override
  State<LogoutWeb> createState() => _LogoutWebState();
}

class _LogoutWebState extends State<LogoutWeb> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut().then((value) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ResponsiveLayout(
                      mobileScreenLayout: LoginMobileView(),
                      webScreenLayout: LoginWebView(),
                    ),
                  ),
                  (route) => false,
                );
              });
            },
            child: Text("Logout")),
      ),
    );
  }
}
