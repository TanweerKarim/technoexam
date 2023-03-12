import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_switch/custom_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tiuexamportal/screens/admin/courses/screen/menuscreens/createexam/editquestionpaper/editquestionpapermobile.dart';
import 'package:tiuexamportal/utility/responsive_layout.dart';

class StudentDetails extends StatefulWidget {
  String branch;
  String sem;
  String courseDtl;
  StudentDetails({
    super.key,
    required this.branch,
    required this.sem,
    required this.courseDtl,
  });

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
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
                  if (widget.branch == storedocs[i]['branch'] &&
                      storedocs[i]['semester'] == widget.sem) ...[
                    DataRow(
                      cells: [
                        DataCell(Text(storedocs[i]['name'])),
                        DataCell(
                          SizedBox(
                            width: 120,
                            child: Row(
                              children: [
                                Expanded(
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ResponsiveLayout(
                                              mobileScreenLayout:
                                                  EditQuestionPaperMobile(
                                                branch: widget.branch,
                                                semester: widget.sem,
                                                subject: storedocs[i]
                                                    ['subjectName'],
                                                active: storedocs[i]['active'],
                                                endTime: storedocs[i]
                                                    ['endTime'],
                                                examDate: storedocs[i]
                                                    ['examDate'],
                                                startTime: storedocs[i]
                                                    ['startTime'],
                                                totalTime: storedocs[i]
                                                    ['totaltime'],
                                                coursedtl: widget.courseDtl,
                                              ),
                                              webScreenLayout:
                                                  EditQuestionPaperMobile(
                                                branch: widget.branch,
                                                semester: widget.sem,
                                                subject: storedocs[i]
                                                    ['subjectName'],
                                                active: storedocs[i]['active'],
                                                endTime: storedocs[i]
                                                    ['endTime'],
                                                examDate: storedocs[i]
                                                    ['examDate'],
                                                startTime: storedocs[i]
                                                    ['startTime'],
                                                totalTime: storedocs[i]
                                                    ['totaltime'],
                                                coursedtl: widget.courseDtl,
                                              ),
                                            ),
                                          ));
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                    ),
                                    tooltip: "Edit",
                                    iconSize: 20,
                                  ),
                                ),
                                Expanded(
                                  child: IconButton(
                                    onPressed: () async {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: const Text('Delete?'),
                                          content: Text(
                                              'Do you really want to delete this subject?'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Cancle'),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                await FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(storedocs[i]['uid'])
                                                    .delete()
                                                    .then((value) =>
                                                        Navigator.pop(context));
                                              },
                                              child: const Text('Delete'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.delete_outline,
                                    ),
                                    tooltip: "Delete",
                                  ),
                                ),
                                Expanded(
                                    child: Transform.scale(
                                  scale: 0.5,
                                  child: CupertinoSwitch(
                                    value: storedocs[i]["active"],
                                    onChanged: (value) async {
                                      debugPrint(value.toString());
                                      FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(storedocs[i]['uid'])
                                          .update({"active": value});
                                    },
                                  ),
                                ))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]
                ],
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
    );
  }
}
