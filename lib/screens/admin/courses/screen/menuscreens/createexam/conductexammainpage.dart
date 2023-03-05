import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tiuexamportal/screens/admin/courses/screen/menuscreens/createexam/createsubject/createsubject.dart';

class ConductExamMainPage extends StatefulWidget {
  String branch;
  String courseDtl;
  ConductExamMainPage(
      {super.key, required this.branch, required this.courseDtl});

  @override
  State<ConductExamMainPage> createState() => _ConductExamMainPageState();
}

class _ConductExamMainPageState extends State<ConductExamMainPage> {
  var items = [
    'semester 1',
    'semester 2',
    'semester 3',
    'semester 4',
    'semester 5',
    'semester 6',
    'semester 7',
    'semester 8',
  ];
  @override
  Widget build(BuildContext context) {
    var widthsize = MediaQuery.of(context).size.width;
    debugPrint(items.length.toString());
    return Container(
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
          for (int i = 0; i < items.length; i++) ...[
            Center(
              child: SizedBox(
                height: 50,
                width: widthsize * 0.3,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateSubject(
                            branch: widget.branch,
                            semester: items[i],
                            courseDtl: widget.courseDtl,
                          ),
                        ));
                  },
                  child: Text(items[i]),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ],
      ),
    );
  }
}
