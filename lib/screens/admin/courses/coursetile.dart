import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tiuexamportal/screens/admin/courses/screen/menuscreens/subjects/allsubectsmobile.dart';

class CourseTile extends StatefulWidget {
  const CourseTile({super.key});

  @override
  State<CourseTile> createState() => _CourseTileState();
}

class _CourseTileState extends State<CourseTile> {
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
                scrollDirection: Axis.horizontal,
                children: [
                  for (int i = 0;
                      i < snapshot.data!['courseName'].length;
                      i++) ...[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.blueAccent),
                        height: 310,
                        width: 410,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ListView(
                            children: [
                              Text(
                                snapshot.data!['courseName'][i],
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                              AllSubectsMobile(
                                  branch: snapshot.data!['courseName'][i],
                                  courseDtl: snapshot.data!['coursedetails'][i])
                            ],
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
