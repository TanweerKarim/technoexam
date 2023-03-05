import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tiuexamportal/auth/mobile/mobilelogin.dart';
import 'package:tiuexamportal/auth/web/weblogin.dart';
import 'package:tiuexamportal/firebase_options.dart';
import 'package:tiuexamportal/screens/mainscreen.dart';
import 'package:tiuexamportal/utility/responsive_layout.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    late Widget firstWidget;
    if (firebaseUser == null) {
      firstWidget = ResponsiveLayout(
        mobileScreenLayout: LoginMobileView(),
        webScreenLayout: LoginWebView(),
      );
    } else {
      firstWidget = MainScreen();
    }
    return MaterialApp(
      title: 'Techno Exam Portal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: firstWidget,
      debugShowCheckedModeBanner: false,
    );
  }
}
