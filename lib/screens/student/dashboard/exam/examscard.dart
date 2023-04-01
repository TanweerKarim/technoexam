import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:tiuexamportal/screens/student/dashboard/exam/exampage.dart';

class ExamsCard extends StatefulWidget {
  String branch;
  String sem;
  ExamsCard({
    super.key,
    required this.branch,
    required this.sem,
  });

  @override
  State<ExamsCard> createState() => _ExamsCardState();
}

class _ExamsCardState extends State<ExamsCard> {
  @override
  Widget build(BuildContext context) {
    String imageUrl1 =
        'https://firebasestorage.googleapis.com/v0/b/technoexamportal.appspot.com/o/assets%2Fimages%2Fbackground.jpg?alt=media&token=7b1962be-4ffa-469a-a86f-fad8b1f27eb7';
    String todaysDate = DateFormat("dd-MM-yyyy").format(DateTime.now());
    String currentTime = DateFormat("hh:mma").format(DateTime.now());
    String currentTm = currentTime.substring(0, currentTime.length - 2);
    String currentampm =
        currentTime.substring(currentTime.length - 2, currentTime.length);
    debugPrint(todaysDate);
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('courses')
          .doc('courseName')
          .collection(widget.branch)
          .doc(widget.sem)
          .collection('subjects')
          .snapshots(),
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
          String currentTimestamp =
              DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
          DateTime dt1 = DateTime.parse(currentTimestamp);
          return ListView(
            scrollDirection: Axis.horizontal,
            children: [
              for (var i = 0; i < storedocs.length; i++) ...[
                if (storedocs[i]['active']) ...[
                  Card(
                    elevation: 10,
                    shadowColor: Colors.black,
                    color: Colors.blue,
                    child: SizedBox(
                      width: 300,
                      height: 300,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(imageUrl1),
                                      fit: BoxFit.cover)),
                              width: double.infinity,
                              height: 150,
                              child: Center(
                                child: Text(
                                  storedocs[i]['subjectName'],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const Text("Date - "),
                                Text(DateFormat("dd-MM-yyyy").format(
                                    DateTime.parse(storedocs[i]['examDate'] +
                                        " " +
                                        storedocs[i]['startTime']))), 
                              ],
                            ),
                            Row(
                              children: [
                                const Text("Start Time - "),
                                Text(DateFormat("hh:mma").format(DateTime.parse(
                                    storedocs[i]['examDate'] +
                                        " " +
                                        storedocs[i]['startTime']))),
                              ],
                            ),
                            Row(
                              children: [
                                const Text("End Time - "),
                                Text(DateFormat("hh:mma").format(DateTime.parse(
                                    storedocs[i]['examDate'] +
                                        " " +
                                        storedocs[i]['endTime']))),
                              ],
                            ), //Text
                            const SizedBox(
                              height: 10,
                            ),
                            if (dt1.isAfter(DateTime.parse(
                                DateFormat("yyyy-MM-dd HH:mm:ss").format(
                                    DateTime.parse(storedocs[i]['examDate'] +
                                        " " +
                                        storedocs[i]['startTime']))))) ...[
                              if (dt1.isAfter(DateTime.parse(
                                  DateFormat("yyyy-MM-dd HH:mm:ss").format(
                                      DateTime.parse(storedocs[i]['examDate'] +
                                          " " +
                                          storedocs[i]['endTime']))))) ...[
                                SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () => 'Null',
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.grey)),
                                      child: const Padding(
                                        padding: EdgeInsets.all(4),
                                        child: Text(
                                          'Exam ended',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ))
                              ] else ...[
                                SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ExamPage(
                                              uid: FirebaseAuth
                                                  .instance.currentUser!.uid,
                                              semester: widget.sem,
                                              subject: storedocs[i]
                                                  ['subjectName'],
                                              branch: widget.branch,
                                              totaltime: storedocs[i]
                                                  ['totaltime'],
                                            ),
                                          ),
                                          (route) => true,
                                        );
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.green)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Icon(
                                              Icons.touch_app,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              'Go to Exam Page',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                      ),
                                    )),
                              ]
                            ] else ...[
                              SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () => 'Null',
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.grey)),
                                    child: const Padding(
                                      padding: EdgeInsets.all(4),
                                      child: Text(
                                        'Exam not yet started',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ))
                            ]
                          ],
                        ), //Column
                      ), //Padding
                    ), //SizedBox
                  ),
                ] else ...[
                  Container(),
                ],
              ]
            ],
          );
        } else {
          if (snapshot.data!.docs.isEmpty) {
            return Container(
              child: const Center(
                child: Text("No Active Exam"),
              ),
            );
          } else {
            return Container();
          }
        }
      },
    );
  }
}
