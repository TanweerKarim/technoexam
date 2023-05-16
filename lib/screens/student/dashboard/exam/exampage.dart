import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tiuexamportal/screens/student/dashboard/exam/questionans.dart';
import 'package:tiuexamportal/utility/utility.dart';

class ExamPage extends StatefulWidget {
  String uid;
  String semester;
  String subject;
  String branch;
  String totaltime;
  String userName;
  String email;
  ExamPage({
    super.key,
    required this.uid,
    required this.semester,
    required this.subject,
    required this.branch,
    required this.totaltime,
    required this.userName,
    required this.email,
  });

  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  var userData = {};
  bool isLoading = false;
  String imgs = "";
  bool hasstarted = false;
  bool hasSubmitted = false;
  getData() async {
    debugPrint(widget.totaltime);
    setState(() {
      isLoading = true;
    });
    try {
      var currentUserSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .collection(widget.semester)
          .doc(widget.subject)
          .get();
      userData = currentUserSnap.data()!;
      hasstarted = userData['hasStarted'];
      hasSubmitted = userData['isSubmitted'];
      debugPrint(hasSubmitted.toString());
      setState(() {});
    } catch (e) {
      hasstarted = false;
      hasSubmitted = false;
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exam Paper"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Exam Instructions',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MyBullet(),
                      ),
                      title: const Text(
                        'The proctoring settings are not enabled for this test.',
                      ),
                    ),
                    ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MyBullet(),
                      ),
                      title: const Text(
                          'You cannot pause while attempting the test.'),
                    ),
                    ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MyBullet(),
                      ),
                      title: const Text(
                          'Do not close the browser window or tab of the test interface before you submit your final answers.'),
                    ),
                    ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MyBullet(),
                      ),
                      title: const Text(
                          'Close all other windows and tabs before attempting the test.'),
                    ),
                    ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MyBullet(),
                      ),
                      title: const Text('Do not refresh the page'),
                    )
                  ],
                ),
              ),
              Spacer(),
              if (!isLoading) ...[
                if (hasSubmitted) ...[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () async {},
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.grey)),
                          child: const Padding(
                            padding: EdgeInsets.all(4),
                            child: Text(
                              'Already Submitted',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        )),
                  ),
                ] else ...[
                  if (hasstarted) ...[
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () => Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QuestionAns(
                                  subject: widget.subject,
                                  semester: widget.semester,
                                  branch: widget.branch,
                                  totaltime: widget.totaltime,
                                  email: widget.email,
                                  userName: widget.userName,
                                ),
                              ),
                              (route) => false,
                            ),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.blue)),
                            child: const Padding(
                              padding: EdgeInsets.all(4),
                              child: Text(
                                'Continue',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )),
                    ),
                  ] else ...[
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () async {
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(widget.uid)
                                  .collection(widget.semester)
                                  .doc(widget.subject)
                                  .set({
                                'hasStarted': true,
                                'isSubmitted': false,
                                'marksobtained': 0,
                                'subject': widget.subject,
                                'totalmarks': 0,
                              }).then((value) => Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => QuestionAns(
                                            subject: widget.subject,
                                            semester: widget.semester,
                                            branch: widget.branch,
                                            totaltime: widget.totaltime,
                                            email: widget.email,
                                            userName: widget.userName,
                                          ),
                                        ),
                                        (route) => false,
                                      ));
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.blue)),
                            child: const Padding(
                              padding: EdgeInsets.all(4),
                              child: Text(
                                'Start',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )),
                    ),
                  ],
                ],
              ] else ...[
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class MyBullet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10.0,
      width: 10.0,
      decoration: const BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
    );
  }
}
