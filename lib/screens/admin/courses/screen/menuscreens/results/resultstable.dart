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
  bool isLoading = false;
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .orderBy("name")
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData) {
          final List storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
          }).toList();

          return FutureBuilder<List<DocumentSnapshot>>(
            future: getAllDocuments(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else {
                List<DocumentSnapshot<Object?>>? documents = snapshot.data;
                // Use the list of documents to build your UI
                return SingleChildScrollView(
                  child: SizedBox(
                      child: DataTable(
                    columns: [
                      DataColumn(
                          label: Expanded(
                        child: Text('Subject\nName',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      )),
                      for (int i = 0; i < documents!.length; i++) ...[
                        DataColumn(
                            label: Text(documents[i]['subjectName'],
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold))),
                      ]
                    ],
                    rows: [
                      if (storedocs.length == 0) ...[
                        DataRow(cells: [
                          DataCell(Text(' - ')),
                          for (int i = 0; i < documents.length; i++) ...[
                            DataCell(Text('-')),
                          ]
                        ]),
                      ] else ...[
                        for (var i = 0; i < storedocs.length; i++) ...[
                          if (widget.branch == storedocs[i]['branch'] &&
                              storedocs[i]['semester'] == widget.semester) ...[
                            DataRow(
                              cells: [
                                DataCell(Text(storedocs[i]['name'])),
                                for (int i = 0; i < documents.length; i++) ...[
                                  DataCell(Text('-')),
                                ]
                              ],
                            ),
                          ]
                        ],
                      ],
                    ],
                  )),
                );
              }
            },
          );
        } else {
          if (snapshot.data!.docs.isEmpty) {
            return Container(
              child: const Center(
                child: Text("No Subjects added yet"),
              ),
            );
          } else {
            return Container();
          }
        }
      },
    );
  }
}
