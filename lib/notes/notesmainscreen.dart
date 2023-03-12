import 'package:flutter/material.dart';
import 'package:tiuexamportal/notes/addnotes.dart';
import 'package:tiuexamportal/notes/notescard.dart';

class NotesMainScreen extends StatefulWidget {
  const NotesMainScreen({super.key});

  @override
  State<NotesMainScreen> createState() => _NotesMainScreenState();
}

class _NotesMainScreenState extends State<NotesMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text(
                  "Notes",
                  style: TextStyle(fontSize: 20),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddNotesMobile()));
                    },
                    icon: Icon(
                      Icons.add_box_outlined,
                      size: 40.0,
                    ),
                    tooltip: "Add Subject",
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 500,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: NotesCard(),
            ),
          ),
        ],
      ),
    );
  }
}
