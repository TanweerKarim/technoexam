import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
        : Container(
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              "Courses of TIU",
                              style: TextStyle(
                                fontSize: 32,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.8,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: ListView(
                                  children: [
                                    for (int i = 0;
                                        i < courseName['courseName'].length;
                                        i++) ...[
                                      Container(
                                        child: Center(
                                          child: SizedBox(
                                            height: 50,
                                            width: double.infinity,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            MainScreenForCourse(
                                                              coursename:
                                                                  courseName[
                                                                      'courseName'][i],
                                                              courseDtl: courseName[
                                                                  'coursedetails'][i],
                                                              currentPage:
                                                                  "home",
                                                            )),
                                                  );
                                                },
                                                child: Text(
                                                  courseName['courseName'][i],
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          const Text(
                            "Up Coming Events",
                            style: TextStyle(
                              fontSize: 32,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
