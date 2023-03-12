import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tiuexamportal/utility/utility.dart';
import 'package:uuid/uuid.dart';

class AddNotesMobile extends StatefulWidget {
  const AddNotesMobile({super.key});

  @override
  State<AddNotesMobile> createState() => _AddNotesMobileState();
}

class _AddNotesMobileState extends State<AddNotesMobile> {
  String title = "";
  String note = "";
  final maxLines = 5;
  var uuid = Uuid();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Note")),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: 55,
              ),
              SizedBox(
                width: double.infinity,
                child: TextField(
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    hintText: 'Title',
                  ),
                  onChanged: (value) {
                    setState(() {
                      title = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                width: double.infinity,
                height: maxLines * 24.0,
                child: TextField(
                  minLines: 2,
                  maxLines: maxLines,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: 'Notes...',
                  ),
                  onChanged: (value) {
                    setState(() {
                      note = value;
                    });
                  },
                ),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () async {
                  String uid = uuid.v4();
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection("notes")
                      .doc(uid)
                      .set({'title': title, 'note': note, 'uid': uid}).then(
                          (value) {
                    Navigator.pop(context);
                    showSnackBar(context: context, content: "Notes created");
                  });
                },
                child: Text(
                  "Add Notes",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
