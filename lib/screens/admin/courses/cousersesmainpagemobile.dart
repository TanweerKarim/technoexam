import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tiuexamportal/screens/admin/courses/addcourse.dart';
import 'package:tiuexamportal/screens/admin/courses/coursebutton.dart';
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
                            nextPage(context: context, widget: AddCourse());
                          },
                          icon: Icon(
                            Icons.add_box_outlined,
                            size: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
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
          );
  }
}
