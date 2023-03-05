import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tiuexamportal/screens/admin/courses/screen/mainscreenforcourse.dart';
import 'package:tiuexamportal/utility/utility.dart';

class CoursesMainpageMobile extends StatefulWidget {
  const CoursesMainpageMobile({super.key});

  @override
  State<CoursesMainpageMobile> createState() => _CoursesMainpageMobileState();
}

class _CoursesMainpageMobileState extends State<CoursesMainpageMobile> {
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
                    height: 400,
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
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MainScreenForCourse(
                                                    coursename:
                                                        courseName['courseName']
                                                            [i],
                                                    courseDtl: courseName[
                                                        'coursedetails'][i],
                                                    currentPage: "home",
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
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    child: Text(
                      "Up Coming Events",
                      style: TextStyle(
                        fontSize: 32,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
