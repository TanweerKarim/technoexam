import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tiuexamportal/screens/admin/courses/screen/mainscreenforcourse.dart';

class CourseButton extends StatefulWidget {
  const CourseButton({super.key});

  @override
  State<CourseButton> createState() => _CourseButtonState();
}

class _CourseButtonState extends State<CourseButton> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('courses')
          .doc('courseName')
          .get(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError)
          return Center(
            child: Text(snapshot.hasError.toString()),
          );
        return snapshot.hasData
            ? ListView(
                children: [
                  for (int i = 0;
                      i < snapshot.data!['courseName'].length;
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
                                      builder: (context) => MainScreenForCourse(
                                            coursename:
                                                snapshot.data!['courseName'][i],
                                            courseDtl: snapshot
                                                .data!['coursedetails'][i],
                                            currentPage: "home",
                                          )),
                                );
                              },
                              child: Text(
                                snapshot.data!['courseName'][i],
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ]
                ],
              )
            : Container();
      },
    );
  }
}
