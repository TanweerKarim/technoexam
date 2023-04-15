import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tiuexamportal/utility/utility.dart';

class ResultsTable extends StatefulWidget {
  String branch;
  String semester;
  ResultsTable({
    super.key,
    required this.branch,
    required this.semester,
  });

  @override
  State<ResultsTable> createState() => _ResultsTableState();
}

class _ResultsTableState extends State<ResultsTable> {
  Future<List<DocumentSnapshot>> getAllDocuments() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('courses')
        .doc('courseName')
        .collection(widget.branch)
        .doc(widget.semester)
        .collection('subjects')
        .get();
    List<DocumentSnapshot> documents = querySnapshot.docs;
    return documents;
  }

  Future<List<DocumentSnapshot>> getAllDocumentsStudent() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('courses')
        .doc('courseName')
        .collection(widget.branch)
        .doc(widget.semester)
        .collection('subjects')
        .get();
    List<DocumentSnapshot> documents = querySnapshot.docs;
    return documents;
  }

  List<dynamic> studentsData = [];
  List<dynamic> actualStudentsData = [];
  List<dynamic> subjectData = [];
  List<dynamic> marksData = [];
  List<dynamic> marksData1 = [];
  List<List<dynamic>> marks = [];
  bool isLoading = false;
  getAllDataOfStudents() async {
    setState(() {
      isLoading = true;
    });
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('users');
    QuerySnapshot querySnapshot1 = await _collectionRef.orderBy("name").get();
    QuerySnapshot querySnapshot2 = await FirebaseFirestore.instance
        .collection('courses')
        .doc('courseName')
        .collection(widget.branch)
        .doc(widget.semester)
        .collection('subjects')
        .get();
    studentsData = querySnapshot1.docs.map((doc) => doc.data()).toList();
    subjectData = querySnapshot2.docs.map((doc) => doc.data()).toList();
    int k = 1;
    for (int i = 0; i < studentsData.length; i++) {
      if (widget.branch == studentsData[i]['branch'] &&
          studentsData[i]['semester'] == widget.semester) {
        marks = List.generate(k, (_) => List.filled(subjectData.length, 0));
        // debugPrint(studentsData[i]['name']);
        actualStudentsData.add(studentsData[i]);
        k++;
      }
    }
    debugPrint(actualStudentsData.length.toString());
    for (int i = 0; i < actualStudentsData.length; i++) {
      QuerySnapshot querySnapshot3 = await FirebaseFirestore.instance
          .collection('users')
          .doc(actualStudentsData[i]["uid"])
          .collection(widget.semester)
          .get();
      marksData = querySnapshot3.docs.map((doc) => doc.data()).toList();
      for (int j = 0; j < subjectData.length; j++) {
        if (marksData.length == subjectData.length) {
          if (marksData.isNotEmpty) {
            // if (marksData[j]['marksobtained'] != null) {
            //   marks[i][j] = marksData[j]['marksobtained'];
            // } else {
            //   marks[i][j] = 0;
            // }
            marks[i][j] = marksData[j]['marksobtained'];
          } else {
            marks[i][j] = 0;
          }
        } else if (marksData.length < subjectData.length) {
          if (j < marksData.length) {
            marks[i][j] = marksData[j]['marksobtained'];
          } else {
            marks[i][j] = 0;
          }
        } else {
          marks[i][j] = 0;
        }
      }
      // debugPrint(marksData[i].toString());
    }
    setState(() {});
    debugPrint(marks.toString());
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.semester != "") {
      debugPrint("working");
      setState(() {});
    }
    setState(() {
      getAllDataOfStudents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Results"),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: SizedBox(
                  width: double.infinity,
                  child: DataTable(
                    columns: [
                      DataColumn(
                          label: Expanded(
                        child: Text('Subject\nName',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      )),
                      for (int i = 0; i < subjectData.length; i++) ...[
                        DataColumn(
                            label: Text(subjectData[i]['subjectName'],
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold))),
                      ]
                    ],
                    rows: [
                      if (actualStudentsData.length == 0) ...[
                        DataRow(cells: [
                          DataCell(Text(' - ')),
                          for (int i = 0; i < subjectData.length; i++) ...[
                            DataCell(Text('-')),
                          ]
                        ]),
                      ] else ...[
                        for (var i = 0; i < actualStudentsData.length; i++) ...[
                          DataRow(
                            cells: [
                              DataCell(Text(actualStudentsData[i]['name'])),
                              for (int j = 0; j < subjectData.length; j++) ...[
                                DataCell(Text(marks[i][j].toString())),
                              ]
                            ],
                          ),
                        ],
                      ],
                    ],
                  )),
            ),
    );
  }
}
