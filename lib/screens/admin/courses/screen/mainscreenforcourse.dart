import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tiuexamportal/auth/web/weblogout.dart';
import 'package:tiuexamportal/globals.dart';
import 'package:tiuexamportal/screens/admin/addstudents/addstudents.dart';
import 'package:tiuexamportal/screens/admin/courses/screen/menuscreens/createexam/conductexammainpage.dart';
import 'package:tiuexamportal/screens/admin/courses/screen/menuscreens/createexam/conductexammainpagemobile.dart';
import 'package:tiuexamportal/screens/admin/courses/screen/menuscreens/home/coursehomepagemobile.dart';
import 'package:tiuexamportal/screens/admin/courses/screen/menuscreens/home/coursehomeweb.dart';
import 'package:tiuexamportal/screens/admin/courses/screen/menuscreens/results/allstudentsresult.dart';
import 'package:tiuexamportal/screens/admin/courses/screen/menuscreens/students/allstudents.dart';
import 'package:tiuexamportal/screens/admin/courses/screen/menuscreens/subjects/allsubectsmobile.dart';
import 'package:tiuexamportal/screens/mainscreen.dart';
import 'package:tiuexamportal/utility/responsive_layout.dart';
import 'package:tiuexamportal/utility/utility.dart';
import '../../../../globals.dart' as globals;

class MainScreenForCourse extends StatefulWidget {
  String coursename;
  String courseDtl;
  String currentPage;
  MainScreenForCourse({
    super.key,
    required this.coursename,
    required this.courseDtl,
    required this.currentPage,
  });

  @override
  State<MainScreenForCourse> createState() => _MainScreenForCourseState();
}

class _MainScreenForCourseState extends State<MainScreenForCourse> {
  var currentPage = DrawerSections.home;
  var courseName = {};
  bool isLoading = false;
  int i = 0;

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var coursename = await FirebaseFirestore.instance
          .collection('courses')
          .doc('courseName')
          .get();
      courseName = coursename.data()!;
      for (i = 0; i < courseName['courseName'].length; i++) {
        if (courseName['courseName'][i] == widget.coursename) break;
      }

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
    switch (widget.currentPage) {
      case "createSubject":
        setState(() {
          currentPage = DrawerSections.createSubject;
        });
        break;
      default:
        currentPage = DrawerSections.home;
    }
    debugPrint(widget.courseDtl);
    debugPrint("${globals.email}");
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    var container;
    if (currentPage == DrawerSections.home) {
      container = isLoading
          ? Container(
              child: CircularProgressIndicator(),
            )
          : ResponsiveLayout(
              mobileScreenLayout: CourseHomePageMobile(
                coursename: widget.coursename,
                courseDtl: courseName['coursedetails'][i],
                size: size,
              ),
              webScreenLayout: CourserHomeWeb(
                coursename: widget.coursename,
                courseDtl: widget.courseDtl,
                size: size,
              ));
    } else if (currentPage == DrawerSections.conductExam) {
      container = ResponsiveLayout(
          mobileScreenLayout: ConductExamMainPageMobile(
            branch: widget.coursename,
            courseDtl: widget.courseDtl,
          ),
          webScreenLayout: ConductExamMainPage(
            branch: widget.coursename,
            courseDtl: widget.courseDtl,
          ));
    } else if (currentPage == DrawerSections.settings) {
      container = AllStudentsResult(branch: widget.coursename);
    } else if (currentPage == DrawerSections.addstudent) {
      container =
          AllStudents(branch: widget.coursename, courseDtl: widget.courseDtl);
    } else if (currentPage == DrawerSections.createSubject) {
      container = AllSubectsMobile(
        branch: widget.coursename,
        courseDtl: courseName['coursedetails'][i],
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Courses"),
        backgroundColor: Colors.blue,
      ),
      body: container,
      drawer: Drawer(
        child: Container(
          child: Column(
            children: [
              MyDrawerList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(
          top: 15,
        ),
        child: Column(
          // shows the list of menu drawer
          children: [
            menuItem(
              1,
              "Home",
              Icons.home_filled,
              currentPage == DrawerSections.home ? true : false,
            ),
            menuItem(
              2,
              "Subjects",
              Icons.book_sharp,
              currentPage == DrawerSections.createSubject ? true : false,
            ),
            menuItem(
              3,
              "Conduct Exam",
              Icons.bookmark_add_rounded,
              currentPage == DrawerSections.conductExam ? true : false,
            ),
            menuItem(
              4,
              "Students",
              Icons.people_outline_outlined,
              currentPage == DrawerSections.addstudent ? true : false,
            ),
            Divider(),
            menuItem(
              5,
              "Results",
              Icons.assessment_outlined,
              currentPage == DrawerSections.settings ? true : false,
            ),
            InkWell(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen()),
                  (route) => false,
                );
              },
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Icon(
                        Icons.arrow_back,
                        size: 20,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        'Back to Dashboard',
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
          ],
        ),
      ),
    );
  }

  Widget menuItem(
    int id,
    String title,
    IconData icon,
    bool selected,
  ) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.home;
            } else if (id == 2) {
              currentPage = DrawerSections.createSubject;
            } else if (id == 3) {
              currentPage = DrawerSections.conductExam;
            } else if (id == 4) {
              currentPage = DrawerSections.addstudent;
            } else if (id == 5) {
              currentPage = DrawerSections.settings;
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
  home,
  createSubject,
  conductExam,
  addstudent,
  settings,
}
