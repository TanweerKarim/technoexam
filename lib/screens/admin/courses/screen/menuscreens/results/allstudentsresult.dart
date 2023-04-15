import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tiuexamportal/screens/admin/courses/screen/menuscreens/results/resultstable.dart';

class AllStudentsResult extends StatefulWidget {
  String branch;
  AllStudentsResult({
    super.key,
    required this.branch,
  });

  @override
  State<AllStudentsResult> createState() => _AllStudentsResultState();
}

class _AllStudentsResultState extends State<AllStudentsResult> {
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
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0),
              child: Center(
                child: SizedBox(
                  height: 50,
                  width: widthsize,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultsTable(
                              branch: widget.branch,
                              semester: items[i],
                            ),
                          ));
                    },
                    child: Text(items[i]),
                  ),
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
