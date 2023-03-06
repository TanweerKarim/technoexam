import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tiuexamportal/auth/web/weblogout.dart';
import 'package:tiuexamportal/globals.dart';
import 'package:tiuexamportal/screens/admin/courses/coursesmainpageweb.dart';
import 'package:tiuexamportal/screens/admin/courses/cousersesmainpagemobile.dart';
import 'package:tiuexamportal/screens/admin/dashboard/mobiledashboardadmin.dart';
import 'package:tiuexamportal/screens/admin/dashboard/webdashboardadmin.dart';
import 'package:tiuexamportal/screens/student/dashboard/mobiledashboard.dart';
import 'package:tiuexamportal/screens/student/dashboard/webdashboard.dart';
import 'package:tiuexamportal/utility/mydrawerheader.dart';
import 'package:tiuexamportal/utility/responsive_layout.dart';
import 'package:tiuexamportal/utility/utility.dart';
import '../globals.dart' as globals;

class MainScreen extends StatefulWidget {
  MainScreen({
    super.key,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var currentPage = DrawerSections.dashboard;
  var userData = {};
  bool isLoading = false;
  String imgs = "";
  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var currentUserSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      userData = currentUserSnap.data()!;
      imgs = userData['photoUrl'];
      debugPrint(imgs);
      globals.email = userData['email'];
      globals.password = userData["password"];
      debugPrint(globals.email + " " + globals.password);
      setState(() {});
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.dashboard) {
      if (!isLoading) {
        if (userData['type'] == 'admin') {
          container = ResponsiveLayout(
            mobileScreenLayout: MobileDashboardAdmin(),
            webScreenLayout: WebDashboardAdmin(),
          );
        } else {
          container = ResponsiveLayout(
              mobileScreenLayout: MobileDashboard(
                userdata: userData,
              ),
              webScreenLayout: WebDashBoard(
                branch: userData['branch'],
                sem: userData['semester'],
              ));
        }
      }
    } else if (currentPage == DrawerSections.courses) {
      if (userData['type'] == 'admin') {
        container = ResponsiveLayout(
            mobileScreenLayout: CoursesMainpageMobile(),
            webScreenLayout: CoursesMainpageWeb());
      } else {
        container = Center(
          child: Text('Courses'),
        );
      }
    } else if (currentPage == DrawerSections.events) {
      // container = EventsPage();
    } else if (currentPage == DrawerSections.notes) {
      // container = NotesPage();
    } else if (currentPage == DrawerSections.settings) {
      container = LogoutWeb();
    } else if (currentPage == DrawerSections.notifications) {
      // container = NotificationsPage();
    } else if (currentPage == DrawerSections.privacy_policy) {
      // container = PrivacyPolicyPage();
    } else if (currentPage == DrawerSections.send_feedback) {
      // container = SendFeedbackPage();
    } else if (currentPage == DrawerSections.addstudent) {
      container = Center(
        child: Text('Add Student'),
      );
    } else if (currentPage == DrawerSections.questionbank) {
      container = Center(
        child: Text('Question bank'),
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Techno Exam Portal"),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyHeaderDrawer(
                  name: userData['name'],
                  type: userData['type'],
                  email: userData['email'],
                  url: userData['photoUrl'],
                ),
                MyDrawerList(userData['type']),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList(String type) {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(
              1,
              "Dashboard",
              Icons.dashboard_outlined,
              currentPage == DrawerSections.dashboard ? true : false,
              userData['type']),
          menuItem(
              2,
              "Courses",
              Icons.people_alt_outlined,
              currentPage == DrawerSections.courses ? true : false,
              userData['type']),
          userData['type'] == "admin"
              ? menuItem(
                  3,
                  "Add Student",
                  Icons.people_alt_outlined,
                  currentPage == DrawerSections.addstudent ? true : false,
                  userData['type'])
              : menuItem(
                  3,
                  "Question Bank",
                  Icons.people_alt_outlined,
                  currentPage == DrawerSections.questionbank ? true : false,
                  userData['type']),
          menuItem(
              4,
              "Events",
              Icons.event,
              currentPage == DrawerSections.events ? true : false,
              userData['type']),
          menuItem(
              5,
              "Notes",
              Icons.notes,
              currentPage == DrawerSections.notes ? true : false,
              userData['type']),
          Divider(),
          menuItem(
              6,
              "Settings",
              Icons.settings_outlined,
              currentPage == DrawerSections.settings ? true : false,
              userData['type']),
          menuItem(
              7,
              "Notifications",
              Icons.notifications_outlined,
              currentPage == DrawerSections.notifications ? true : false,
              userData['type']),
          Divider(),
          menuItem(
              8,
              "Privacy policy",
              Icons.privacy_tip_outlined,
              currentPage == DrawerSections.privacy_policy ? true : false,
              userData['type']),
          menuItem(
              9,
              "Send feedback",
              Icons.feedback_outlined,
              currentPage == DrawerSections.send_feedback ? true : false,
              userData['type']),
        ],
      ),
    );
  }

  Widget menuItem(
      int id, String title, IconData icon, bool selected, String type) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.dashboard;
            } else if (id == 2) {
              currentPage = DrawerSections.courses;
            } else if (id == 3) {
              if (type == 'admin') {
                currentPage = DrawerSections.addstudent;
              } else {
                currentPage = DrawerSections.questionbank;
              }
            } else if (id == 4) {
              currentPage = DrawerSections.events;
            } else if (id == 5) {
              currentPage = DrawerSections.notes;
            } else if (id == 6) {
              currentPage = DrawerSections.settings;
            } else if (id == 7) {
              currentPage = DrawerSections.notifications;
            } else if (id == 8) {
              currentPage = DrawerSections.privacy_policy;
            } else if (id == 9) {
              currentPage = DrawerSections.send_feedback;
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections {
  dashboard,
  courses,
  addstudent,
  questionbank,
  events,
  notes,
  settings,
  notifications,
  privacy_policy,
  send_feedback,
}