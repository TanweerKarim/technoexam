import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tiuexamportal/utility/utility.dart';
import 'package:uuid/uuid.dart';

class EditNotesMobile extends StatefulWidget {
  String uid;
  String title;
  String note;
  EditNotesMobile(
      {super.key, required this.note, required this.title, required this.uid});

  @override
  State<EditNotesMobile> createState() => _EditNotesMobileState();
}

class _EditNotesMobileState extends State<EditNotesMobile> {
  String title = "";
  String note = "";
  final maxLines = 5;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      title = widget.title;
      note = widget.note;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Note")),
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
                  decoration: InputDecoration(
                    hintText: widget.title,
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
                    hintText: widget.note,
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
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection("notes")
                      .doc(widget.uid)
                      .update({
                    'title': title,
                    'note': note,
                    'uid': widget.uid
                  }).then((value) {
                    Navigator.pop(context);
                    showSnackBar(context: context, content: "Notes updated");
                  });
                },
                child: Text(
                  "Edit Notes",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
