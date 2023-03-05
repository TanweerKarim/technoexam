import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tiuexamportal/screens/admin/courses/screen/mainscreenforcourse.dart';
import 'package:tiuexamportal/screens/admin/courses/screen/menuscreens/createexam/editquestionpaper/editSubjectDetails.dart';
import 'package:tiuexamportal/screens/admin/courses/screen/menuscreens/createexam/editquestionpaper/editsubjectdetailsmobile.dart';
import 'package:tiuexamportal/utility/responsive_layout.dart';

class EditQuestionPaperMobile extends StatefulWidget {
  String branch;
  String semester;
  String subject;
  bool active;
  String endTime;
  String examDate;
  String startTime;
  String totalTime;
  String coursedtl;
  EditQuestionPaperMobile({
    super.key,
    required this.branch,
    required this.semester,
    required this.subject,
    required this.active,
    required this.endTime,
    required this.examDate,
    required this.startTime,
    required this.totalTime,
    required this.coursedtl,
  });

  @override
  State<EditQuestionPaperMobile> createState() =>
      _EditQuestionPaperMobileState();
}

List<int> marksofques = [];
List<int> markindex = [];
HashSet<int> qnaindex = HashSet<int>();
List<bool> questionattempt = [];
int count = 0;

class _EditQuestionPaperMobileState extends State<EditQuestionPaperMobile> {
  bool isLoading = false;
  int index = 0;
  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var currentUserSnap = await FirebaseFirestore.instance
          .collection('courses')
          .doc('courseName')
          .collection(widget.branch)
          .doc(widget.semester)
          .collection('subjects')
          .doc(widget.subject)
          .collection('qna')
          .get();
      index = currentUserSnap.docs.length;
      for (int i = 0; i < index; i++) {
        setState(() {
          questionattempt.add(false);
        });
      }
      setState(() {});
    } catch (e) {
      index = 0;
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subject),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResponsiveLayout(
                      mobileScreenLayout: EditSubjectDetailsMobile(
                          branch: widget.branch,
                          semester: widget.semester,
                          courseDtl: widget.coursedtl,
                          subject: widget.subject,
                          active: widget.active,
                          endTime: widget.endTime,
                          examDate: widget.examDate,
                          startTime: widget.startTime,
                          totalTime: widget.totalTime),
                      webScreenLayout: EditSubjectDetailsWeb(
                          branch: widget.branch,
                          semester: widget.semester,
                          courseDtl: widget.coursedtl,
                          subject: widget.subject,
                          active: widget.active,
                          endTime: widget.endTime,
                          examDate: widget.examDate,
                          startTime: widget.startTime,
                          totalTime: widget.totalTime),
                    ),
                  ));
            },
            icon: Icon(
              Icons.edit,
            ),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.78,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('courses')
                    .doc('courseName')
                    .collection(widget.branch)
                    .doc(widget.semester)
                    .collection('subjects')
                    .doc(widget.subject)
                    .collection('qna')
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
                    marksofques.clear();
                    for (int i = 0; i < storedocs.length; i++) {
                      marksofques.add(int.parse(storedocs[i]['marks']));
                    }
                    return ListView(
                      children: [
                        for (var i = 0; i < storedocs.length; i++) ...[
                          QuestionCard(
                            question: storedocs[i]['question'],
                            index: i,
                            option1: storedocs[i]['option1'],
                            option2: storedocs[i]['option2'],
                            option3: storedocs[i]['option3'],
                            option4: storedocs[i]['option4'],
                            correctopt: storedocs[i]['correctoption'],
                            marks: int.parse(storedocs[i]['marks']),
                          ),
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
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    try {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MainScreenForCourse(
                                  coursename: widget.branch,
                                  courseDtl: widget.coursedtl,
                                  currentPage: "createSubject",
                                )),
                        (route) => false,
                      );
                    } catch (e) {
                      debugPrint("caught an error");
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue)),
                  child: const Padding(
                    padding: EdgeInsets.all(4),
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class QuestionCard extends StatefulWidget {
  String question;
  int index;
  String option1;
  String option2;
  String option3;
  String option4;
  String correctopt;
  int marks;

  QuestionCard({
    super.key,
    required this.question,
    required this.index,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4,
    required this.correctopt,
    required this.marks,
  });

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  String selected = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  "Q${widget.index + 1} ${widget.question}",
                  style: TextStyle(
                      fontSize: 18, color: Colors.black.withOpacity(0.8)),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.edit),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () {},
            child: OptionTile(
              option: "A",
              description: widget.option1,
              selected: selected,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {},
            child: OptionTile(
              option: "B",
              description: widget.option2,
              selected: selected,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {},
            child: OptionTile(
              option: "C",
              description: widget.option3,
              selected: selected,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {},
            child: OptionTile(
              option: "D",
              description: widget.option4,
              selected: selected,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: OptionTile(
              option: "Correct Answer",
              description: widget.correctopt,
              selected: selected,
            ),
          ),
        ],
      ),
    );
  }
}

class OptionTile extends StatefulWidget {
  String option;
  String description;
  String selected;
  OptionTile({
    super.key,
    required this.option,
    required this.description,
    required this.selected,
  });

  @override
  State<OptionTile> createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          if (widget.option == "Correct Answer") ...[
            Container(
              height: 28,
              width: 128,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: widget.selected == widget.description
                          ? Colors.green
                          : Colors.grey,
                      width: 1.5),
                  color: widget.selected == widget.description
                      ? Colors.green
                      : Colors.white,
                  borderRadius: BorderRadius.circular(24)),
              child: Text(
                widget.option,
                style: TextStyle(
                  color: widget.selected == widget.description
                      ? Colors.white
                      : Colors.grey,
                ),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              widget.description,
              style: TextStyle(fontSize: 17, color: Colors.black54),
            )
          ] else ...[
            Container(
              height: 28,
              width: 28,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: widget.selected == widget.description
                          ? Colors.green
                          : Colors.grey,
                      width: 1.5),
                  color: widget.selected == widget.description
                      ? Colors.green
                      : Colors.white,
                  borderRadius: BorderRadius.circular(24)),
              child: Text(
                widget.option,
                style: TextStyle(
                  color: widget.selected == widget.description
                      ? Colors.white
                      : Colors.grey,
                ),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              widget.description,
              style: TextStyle(fontSize: 17, color: Colors.black54),
            )
          ],
        ],
      ),
    );
  }
}
