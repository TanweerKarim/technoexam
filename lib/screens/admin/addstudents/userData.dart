import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class UserData extends StatefulWidget {
  const UserData({super.key});

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Users').snapshots(),
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Name - ${storedocs[i]['name']}"),
                        Text("Email - ${storedocs[i]['email']}"),
                        Text("Department - ${storedocs[i]['branch']}"),
                        Text("Semester - ${storedocs[i]['semester']}"),
                        Text("Type - ${storedocs[i]['type']}"),
                        Text("Status - Added"),
                      ],
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
