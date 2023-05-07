import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tiuexamportal/notes/notescard.dart';
import 'package:tiuexamportal/screens/student/dashboard/exam/examscard.dart';
import 'package:tiuexamportal/screens/student/subjects/subjectcarddashbaord.dart';

import '../../../events/eventscard.dart';

class WebDashBoard extends StatefulWidget {
  String branch;
  String sem;
  String userName;
  String email;
  String userType;
  WebDashBoard(
      {super.key,
      required this.branch,
      required this.sem,
      required this.userName,
      required this.email,
      required this.userType});

  @override
  State<WebDashBoard> createState() => _WebDashBoardState();
}

class _WebDashBoardState extends State<WebDashBoard> {
  String imageUrl1 =
      'https://firebasestorage.googleapis.com/v0/b/technoexamportal.appspot.com/o/assets%2Fimages%2Fbackground.jpg?alt=media&token=7b1962be-4ffa-469a-a86f-fad8b1f27eb7';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.only(left: 60.0),
                  child: Text(
                    "Upcoming Exams",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 320.0,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 60.0,
                    right: 60,
                  ),
                  child: ExamsCard(
                    branch: widget.branch,
                    sem: widget.sem,
                    email: widget.email,
                    userName: widget.userName,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 400,
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          const SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.only(left: 60.0),
                              child: Text(
                                "Events",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 300,
                            width: double.infinity,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 20.0, left: 60),
                              child: EventsCard(userType: widget.userType),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Text(
                                "Notes",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 300.0,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 60.0),
                                child: NotesCard(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
