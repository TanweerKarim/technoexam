import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tiuexamportal/events/eventscard.dart';
import 'package:tiuexamportal/events/eventsmainscreen.dart';
import 'package:tiuexamportal/notes/notescard.dart';
import 'package:tiuexamportal/screens/admin/courses/coursetile.dart';

class MobileDashboardAdmin extends StatefulWidget {
  String userType;
  MobileDashboardAdmin({super.key, required this.userType});

  @override
  State<MobileDashboardAdmin> createState() => _MobileDashboardAdminState();
}

class _MobileDashboardAdminState extends State<MobileDashboardAdmin> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(left: 15.0),
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
                padding: const EdgeInsets.only(left: 15.0),
                child: CourseTile(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 250,
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.only(left: 15.0),
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
                          height: 150.0,
                          width: double.infinity,
                          child: EventsCard(userType: widget.userType),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 250,
              child: Column(
                children: [
                  const SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(left: 15.0),
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
                    height: 20,
                  ),
                  SizedBox(
                    height: 200.0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: NotesCard(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
