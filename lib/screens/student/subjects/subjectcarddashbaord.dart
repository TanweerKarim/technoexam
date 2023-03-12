import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SubjectCardDashboard extends StatefulWidget {
  String courseName;
  String sem;
  SubjectCardDashboard(
      {super.key, required this.courseName, required this.sem});

  @override
  State<SubjectCardDashboard> createState() => _SubjectCardDashboardState();
}

class _SubjectCardDashboardState extends State<SubjectCardDashboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('courses')
            .doc('courseName')
            .collection(widget.courseName)
            .doc(widget.sem)
            .collection('subjects')
            .orderBy("subjectName")
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
            return DataTable(
              columns: const [
                DataColumn(
                    label: Expanded(
                  child: Text('Subject Name',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                )),
                DataColumn(
                    label: Text('Action',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold))),
              ],
              rows: [
                if (storedocs.length == 0) ...[
                  const DataRow(cells: [
                    DataCell(Text(' - ')),
                    DataCell(Text('-')),
                  ]),
                ] else ...[
                  for (var i = 0; i < storedocs.length; i++) ...[
                    DataRow(
                      cells: [
                        DataCell(Text(storedocs[i]['subjectName'])),
                        DataCell(Text(storedocs[i]['subjectName'])),
                      ],
                    ),
                  ]
                ],
              ],
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
      ),
    );
  }
}
