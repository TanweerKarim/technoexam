import 'dart:convert';
import 'dart:io';
import 'package:tiuexamportal/utility/responsive_layout.dart';
import 'package:universal_html/html.dart' as html;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
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
  List<List<dynamic>> alldata = [];

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
        .orderBy('subjectName')
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
    // debugPrint(actualStudentsData.length.toString());
    for (int i = 0; i < actualStudentsData.length; i++) {
      QuerySnapshot querySnapshot3 = await FirebaseFirestore.instance
          .collection('users')
          .doc(actualStudentsData[i]["uid"])
          .collection(widget.semester)
          .orderBy('subject')
          .get();
      marksData = querySnapshot3.docs.map((doc) => doc.data()).toList();
      int chk = 0;
      //logic 2
      if (marksData.length == subjectData.length) {
        for (int j = 0; j < subjectData.length; j++) {
          marks[i][j] = marksData[j]['marksobtained'];
        }
      } else if (marksData.length < subjectData.length) {
        for (int k = 0; k < subjectData.length; k++) {
          for (chk = 0; chk < marksData.length; chk++) {
            debugPrint(marksData[chk]['subject'] +
                "," +
                subjectData[k]['subjectName']);
            if (marksData[chk]['subject'] == subjectData[k]['subjectName']) {
              marks[i][k] = marksData[chk]['marksobtained'];
              break;
            }
          }
          if (chk == marksData.length) {
            marks[i][k] = 0;
          }
        }
      }
      
    } 
    final fixedLengthList = List<List<dynamic>>.generate(
        actualStudentsData.length, (_) => [],
        growable: false);

    if (actualStudentsData.length != 0) {
      for (var i = 0; i < actualStudentsData.length; i++) {
        fixedLengthList[i].add(actualStudentsData[i]['name']);
        for (int j = 0; j < subjectData.length; j++) {
          fixedLengthList[i].add(marks[i][j]);
        }
      }
    }
    alldata = fixedLengthList;
    // debugPrint(alldata.toString());
    setState(() {});
    setState(() {
      isLoading = false;
    });
  }

  exportCsv(String type) async {
    String csv = const ListToCsvConverter().convert(alldata);
    final bytes = utf8.encode(csv);
    // debugPrint(type);
    if (type == "Web") {
      final blob = html.Blob([bytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.document.createElement('a') as html.AnchorElement
        ..href = url
        ..style.display = 'none'
        ..download =
            'resultsof${widget.semester.replaceFirst(RegExp(r' '), '_')}.csv';
      html.document.body!.children.add(anchor);
      anchor.click();
      html.Url.revokeObjectUrl(url);
    } else {
      String dir = (await getExternalStorageDirectory())!.path;
      String filePath = "$dir/list.csv";
      File file = File(filePath);
      await file.writeAsString(csv);
      // debugPrint(file.path);
      showSnackBar(
        context: context,
        content: "File downloaded at ${file.path}",
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.semester != "") {
      // debugPrint("working");
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
        actions: [
          if (MediaQuery.of(context).size.width > 600) ...[
            IconButton(
              onPressed: () {
                exportCsv("Web");
              },
              icon: Icon(Icons.download),
            ),
          ] else ...[
            IconButton(
              onPressed: () {
                exportCsv("Android");
              },
              icon: Icon(Icons.download),
            ),
          ]
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: SizedBox(
                  width: double.infinity,
                  height: 750,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Center(
                        child: DataTable(
                          columns: [
                            DataColumn(
                                label: Expanded(
                              child: Text('Subject\nName',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
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
                                for (int i = 0;
                                    i < subjectData.length;
                                    i++) ...[
                                  DataCell(Text('-')),
                                ]
                              ]),
                            ] else ...[
                              for (var i = 0;
                                  i < actualStudentsData.length;
                                  i++) ...[
                                DataRow(
                                  cells: [
                                    DataCell(
                                        Text(actualStudentsData[i]['name'])),
                                    for (int j = 0;
                                        j < subjectData.length;
                                        j++) ...[
                                      DataCell(Text(marks[i][j].toString())),
                                    ]
                                  ],
                                ),
                              ],
                            ],
                          ],
                        ),
                      ),
                    ),
                  )),
            ),
    );
  }
}
