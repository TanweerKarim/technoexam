import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SubjectMarks extends StatefulWidget {
  String uid;
  String semester;
  SubjectMarks({
    super.key,
    required this.semester,
    required this.uid,
  });

  @override
  State<SubjectMarks> createState() => _SubjectMarksState();
}

class _SubjectMarksState extends State<SubjectMarks> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .collection(widget.semester)
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
                child: Text('Subject',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              )),
              DataColumn(
                  label: Expanded(
                child: Text('Marks',
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
                  DataCell(Text(' - ')),
                  DataCell(Text('-')),
                ]),
              ] else ...[
                for (var i = 0; i < storedocs.length; i++) ...[
                  DataRow(
                    cells: [
                      DataCell(Text(storedocs[i]['subject'])),
                      DataCell(Text(storedocs[i]['marksobtained'].toString())),
                      DataCell(
                        SizedBox(
                          width: 120,
                          child: Row(
                            children: [
                              Expanded(
                                child: IconButton(
                                  onPressed: () async {},
                                  icon: Icon(
                                    Icons.open_in_browser_outlined,
                                  ),
                                  tooltip: "View",
                                ),
                              ),
                              Expanded(
                                child: IconButton(
                                  onPressed: () {},
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
                                            'Do you really want to delete this student?'),
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
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
