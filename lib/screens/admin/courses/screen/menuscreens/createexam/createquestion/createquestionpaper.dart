import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tiuexamportal/screens/admin/courses/screen/mainscreenforcourse.dart';
import 'package:tiuexamportal/screens/admin/courses/screen/menuscreens/createexam/editquestionpaper/editquestionpapermobile.dart';
import 'package:tiuexamportal/utility/responsive_layout.dart';
import 'package:tiuexamportal/utility/utility.dart';
import 'package:uuid/uuid.dart';

class CreateQuestionPaper extends StatefulWidget {
  String branch;
  String semester;
  String courseDtl;
  String subject;
  bool active;
  String endTime;
  String examDate;
  String startTime;
  String totalTime;

  CreateQuestionPaper({
    super.key,
    required this.branch,
    required this.semester,
    required this.subject,
    required this.courseDtl,
    required this.active,
    required this.endTime,
    required this.examDate,
    required this.startTime,
    required this.totalTime,
  });

  @override
  State<CreateQuestionPaper> createState() => _CreateQuestionPaperState();
}

class _CreateQuestionPaperState extends State<CreateQuestionPaper> {
  TextEditingController q1 = TextEditingController();
  TextEditingController op1 = TextEditingController();
  TextEditingController op2 = TextEditingController();
  TextEditingController op3 = TextEditingController();
  TextEditingController op4 = TextEditingController();
  TextEditingController cop = TextEditingController();
  TextEditingController marks = TextEditingController();
  var uuid = Uuid();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    q1.dispose();
    op1.dispose();
    op2.dispose();
    op3.dispose();
    op4.dispose();
    cop.dispose();
    marks.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var widthsize = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Questions"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              const Text(
                "Add question",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: widthsize * 0.3,
                child: TextField(
                  controller: q1,
                  minLines: 2,
                  maxLines: 20,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    hintText: 'Enter question',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: widthsize * 0.3,
                child: TextField(
                  controller: op1,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    hintText: 'Option 1',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: widthsize * 0.3,
                child: TextField(
                  controller: op2,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    hintText: 'Option 2',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: widthsize * 0.3,
                child: TextField(
                  controller: op3,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    hintText: 'Option 3',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: widthsize * 0.3,
                child: TextField(
                  controller: op4,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    hintText: 'Option 4',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: widthsize * 0.3,
                child: TextField(
                  controller: cop,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    hintText: 'Correct option',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: widthsize * 0.3,
                child: TextField(
                  controller: marks,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    hintText: 'Marks',
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              SizedBox(
                width: widthsize * 0.3,
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResponsiveLayout(
                                  mobileScreenLayout: EditQuestionPaperMobile(
                                    branch: widget.branch,
                                    semester: widget.semester,
                                    subject: widget.subject,
                                    active: widget.active,
                                    endTime: widget.endTime,
                                    examDate: widget.examDate,
                                    startTime: widget.startTime,
                                    totalTime: widget.totalTime,
                                    coursedtl: widget.courseDtl,
                                  ),
                                  webScreenLayout: EditQuestionPaperMobile(
                                    branch: widget.branch,
                                    semester: widget.semester,
                                    subject: widget.subject,
                                    active: widget.active,
                                    endTime: widget.endTime,
                                    examDate: widget.examDate,
                                    startTime: widget.startTime,
                                    totalTime: widget.totalTime,
                                    coursedtl: widget.courseDtl,
                                  ),
                                ),
                              ),
                            );
                          },
                          child: const Text("View"),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (q1.text != '' &&
                                op1.text != '' &&
                                op2.text != '' &&
                                op3.text != '' &&
                                op4.text != '' &&
                                cop.text != '' &&
                                marks.text != '') {
                              String uid = uuid.v4();
                              await FirebaseFirestore.instance
                                  .collection('courses')
                                  .doc('courseName')
                                  .collection(widget.branch)
                                  .doc(widget.semester)
                                  .collection('subjects')
                                  .doc(widget.subject)
                                  .collection('qna')
                                  .doc(uid)
                                  .set({
                                'question': q1.text,
                                'option1': op1.text,
                                'option2': op2.text,
                                'option3': op3.text,
                                'option4': op4.text,
                                'correctoption': cop.text,
                                'marks': marks.text,
                              }).then((value) {
                                showSnackBar(
                                    context: context,
                                    content: 'Question added');
                                setState(() {
                                  q1.clear();
                                  op1.clear();
                                  op2.clear();
                                  op3.clear();
                                  op4.clear();
                                  cop.clear();
                                  marks.clear();
                                });
                              });
                            } else {
                              showSnackBar(
                                  context: context,
                                  content: 'Fill out all the fields');
                            }
                          },
                          child: const Text("Add Question"),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
