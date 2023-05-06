import 'package:flutter/material.dart';
import 'package:tiuexamportal/notes/addnotes.dart';
import 'package:tiuexamportal/notes/notescard.dart';
import 'package:tiuexamportal/screens/student/feedback/feedbackcard.dart';

class AllFeedbacks extends StatefulWidget {
  const AllFeedbacks({super.key});

  @override
  State<AllFeedbacks> createState() => _AllFeedbacksState();
}

class _AllFeedbacksState extends State<AllFeedbacks> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Feedbacks",
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            height: 500,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FeedbackCard(),
            ),
          ),
        ],
      ),
    );
  }
}
