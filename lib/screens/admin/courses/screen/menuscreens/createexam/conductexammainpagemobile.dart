import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tiuexamportal/screens/admin/courses/screen/menuscreens/createexam/createsubject/createsubject.dart';
import 'package:tiuexamportal/screens/admin/courses/screen/menuscreens/createexam/createsubject/createsubjectmobile.dart';
import 'package:tiuexamportal/utility/responsive_layout.dart';

class ConductExamMainPageMobile extends StatefulWidget {
  String branch;
  String courseDtl;

  ConductExamMainPageMobile(
      {super.key, required this.branch, required this.courseDtl});

  @override
  State<ConductExamMainPageMobile> createState() =>
      _ConductExamMainPageMobileState();
}

class _ConductExamMainPageMobileState extends State<ConductExamMainPageMobile> {
  @override
  Widget build(BuildContext context) {
    var widthsize = MediaQuery.of(context).size.width;
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(
              height: 70,
            ),
            Center(
              child: Text(
                "Select semester to create question paper",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: SizedBox(
                height: 50,
                width: widthsize,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResponsiveLayout(
                              mobileScreenLayout: CreateSubjectMobile(
                                branch: widget.branch,
                                semester: 'semester 1',
                                courseDtl: widget.courseDtl,
                              ),
                              webScreenLayout: CreateSubject(
                                branch: widget.branch,
                                semester: 'semester 1',
                                courseDtl: widget.courseDtl,
                              )),
                        ));
                  },
                  child: Text("Semester 1"),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: SizedBox(
                height: 50,
                width: widthsize,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Semester 2"),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: SizedBox(
                height: 50,
                width: widthsize,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Semester 3"),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: SizedBox(
                height: 50,
                width: widthsize,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Semester 4"),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: SizedBox(
                height: 50,
                width: widthsize,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Semester 5"),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: SizedBox(
                height: 50,
                width: widthsize,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Semester 6"),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: SizedBox(
                height: 50,
                width: widthsize,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Semester 7"),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: SizedBox(
                height: 50,
                width: widthsize,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Semester 8"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
