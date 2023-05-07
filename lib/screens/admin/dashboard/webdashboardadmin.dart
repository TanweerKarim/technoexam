import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tiuexamportal/events/eventscard.dart';
import 'package:tiuexamportal/events/eventsmainscreen.dart';
import 'package:tiuexamportal/notes/notescard.dart';
import 'package:tiuexamportal/screens/admin/courses/coursetile.dart';

class WebDashboardAdmin extends StatefulWidget {
  String userType;
  WebDashboardAdmin({super.key, required this.userType});

  @override
  State<WebDashboardAdmin> createState() => _WebDashboardAdminState();
}

class _WebDashboardAdminState extends State<WebDashboardAdmin> {
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
              Padding(
                padding: const EdgeInsets.only(
                  left: 60.0,
                  right: 60,
                ),
                child: SizedBox(
                  height: 320.0,
                  child: CourseTile(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 400,
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.only(top: 20, left: 60.0),
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
                          Padding(
                            padding: const EdgeInsets.only(left: 60, top: 12),
                            child: SizedBox(
                              height: 150,
                              width: double.infinity,
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
                          Padding(
                            padding: const EdgeInsets.only(right: 60.0),
                            child: SizedBox(
                              height: 150,
                              child: NotesCard(),
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
