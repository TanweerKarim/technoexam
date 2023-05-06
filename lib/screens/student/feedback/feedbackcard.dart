import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FeedbackCard extends StatefulWidget {
  const FeedbackCard({super.key});

  @override
  State<FeedbackCard> createState() => _FeedbackCardState();
}

class _FeedbackCardState extends State<FeedbackCard> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('feedback').snapshots(),
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
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Name - ${storedocs[i]['username']}"),
                          Text("Email - ${storedocs[i]['email']}"),
                          Text("Exam Rating - ${storedocs[i]['examExp']}/5"),
                          Text(
                              "User experience Rating - ${storedocs[i]['ux']}/5"),
                          Text("Comments - \"${storedocs[i]['comment']}\""),
                          if (storedocs[i]['examcs']) ...[
                            Text(
                                "Note - This feedback is on the basis of exam"),
                          ] else ...[
                            Text(
                                "Note - This feedback is not on the basis of exam"),
                          ]
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
