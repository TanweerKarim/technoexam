import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tiuexamportal/screens/student/dashboard/exam/examscard.dart';

class MobileDashboard extends StatefulWidget {
  var userdata;
  MobileDashboard({super.key, required this.userdata});

  @override
  State<MobileDashboard> createState() => _MobileDashboardState();
}

class _MobileDashboardState extends State<MobileDashboard> {
  String imageUrl1 =
      'https://firebasestorage.googleapis.com/v0/b/technoexamportal.appspot.com/o/assets%2Fimages%2Fbackground.jpg?alt=media&token=7b1962be-4ffa-469a-a86f-fad8b1f27eb7';

  @override
  Widget build(BuildContext context) {
    debugPrint(widget.userdata['semester']);
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
                child: ExamsCard(
                  branch: widget.userdata['branch'],
                  sem: widget.userdata['semester'],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 300,
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
                              "Subjects",
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
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: const [
                                Text("Coming Soon"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 300,
              child: Column(
                children: [
                  const SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text(
                        "Calendar",
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
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: const [
                          Text("Coming Soon"),
                        ],
                      ),
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