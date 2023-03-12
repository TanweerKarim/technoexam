import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tiuexamportal/notes/editnotes.dart';

class NotesCard extends StatefulWidget {
  const NotesCard({super.key});

  @override
  State<NotesCard> createState() => _NotesCardState();
}

class _NotesCardState extends State<NotesCard> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("notes")
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
            return ListView(children: [
              for (int i = 0; i < storedocs.length; i++) ...[
                Card(
                  child: ListTile(
                    title: Text(
                      "Title - ${storedocs[i]['title']}",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                      ),
                    ),
                    subtitle: Text(
                      "Note - ${storedocs[i]['note']}",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          Expanded(
                            child: IconButton(
                              onPressed: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditNotesMobile(
                                              note: storedocs[i]['note'],
                                              title: storedocs[i]['title'],
                                              uid: storedocs[i]['uid'],
                                            )));
                              },
                              icon: Icon(
                                Icons.edit,
                              ),
                            ),
                          ),
                          Expanded(
                            child: IconButton(
                              onPressed: () {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Delete?'),
                                    content: Text(
                                        'Do you really want to delete this note?'),
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
                                              .doc(FirebaseAuth
                                                  .instance.currentUser!.uid)
                                              .collection('notes')
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
                                Icons.delete,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ]
            ]);
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
        });
  }
}
