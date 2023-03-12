import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tiuexamportal/screens/admin/courses/addcourse.dart';
import 'package:tiuexamportal/screens/admin/courses/coursebutton.dart';
import 'package:tiuexamportal/screens/admin/courses/screen/mainscreenforcourse.dart';
import 'package:tiuexamportal/utility/utility.dart';

class CoursesMainpageWeb extends StatefulWidget {
  const CoursesMainpageWeb({super.key});

  @override
  State<CoursesMainpageWeb> createState() => _CoursesMainpageWebState();
}

class _CoursesMainpageWebState extends State<CoursesMainpageWeb> {
  var courseName = {};
  bool isLoading = false;

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var currentUserSnap = await FirebaseFirestore.instance
          .collection('courses')
          .doc('courseName')
          .get();
      courseName = currentUserSnap.data()!;
      // for (int i = 0; i < courseName.length; i++) {
      //   debugPrint(courseName['coursebannarimage'][i]);
      // }
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
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: Container(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.95,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 28.0),
                                  child: const Text(
                                    "Courses of TIU",
                                    style: TextStyle(
                                      fontSize: 32,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: IconButton(
                                    onPressed: () {
                                      nextPage(
                                          context: context,
                                          widget: AddCourse());
                                    },
                                    icon: Icon(
                                      Icons.add_box_outlined,
                                      size: 40,
                                    ),
                                  ),
                                ),
                              ],
                            ), //MediaQuery.of(context).size.height * 0.8
                            SizedBox(
                              height: 800,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: CourseButton(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
