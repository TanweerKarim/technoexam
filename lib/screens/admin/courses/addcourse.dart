import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tiuexamportal/utility/utility.dart';

class AddCourse extends StatefulWidget {
  const AddCourse({super.key});

  @override
  State<AddCourse> createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  String courseName = "";
  String courseDtl = "";
  String photoUrl =
      "https://firebasestorage.googleapis.com/v0/b/technoexamportal.appspot.com/o/assets%2Fimages%2Fbanner.png?alt=media&token=245d73b4-d81b-4fa4-9496-730e1b34cbac";
  @override
  Widget build(BuildContext context) {
    var widthsize = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Course"),
      ),
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                const Text(
                  "Add Course",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: widthsize,
                  child: TextField(
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      hintText: 'Course Name',
                    ),
                    onChanged: (value) {
                      setState(() {
                        courseName = value;
                      });
                      debugPrint(courseDtl);
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: widthsize,
                  child: TextField(
                    minLines: 2,
                    maxLines: 20,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      hintText: 'Course Details',
                    ),
                    onChanged: (value) {
                      setState(() {
                        courseDtl = value;
                      });
                    },
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection("courses")
                        .doc("courseName")
                        .update({
                      'courseName': FieldValue.arrayUnion([courseName]),
                      'coursedetails': FieldValue.arrayUnion([courseDtl]),
                    }).then((value) {
                      Navigator.pop(context);
                      showSnackBar(context: context, content: "Course Created");
                      setState(() {});
                    });
                  },
                  child: Text(
                    "Create subject",
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
