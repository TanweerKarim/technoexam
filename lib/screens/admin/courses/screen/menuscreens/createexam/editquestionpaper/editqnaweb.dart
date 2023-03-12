import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiuexamportal/utility/utility.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tiuexamportal/screens/admin/courses/screen/mainscreenforcourse.dart';

class EditQnAWeb extends StatefulWidget {
  String branch;
  String courseDtl;
  String uid;
  String semester;
  String subject;
  String q1;
  String op1;
  String op2;
  String op3;
  String op4;
  String cop;
  String marks;
  EditQnAWeb({
    super.key,
    required this.branch,
    required this.courseDtl,
    required this.uid,
    required this.semester,
    required this.subject,
    required this.cop,
    required this.marks,
    required this.op1,
    required this.op2,
    required this.op3,
    required this.op4,
    required this.q1,
  });

  @override
  State<EditQnAWeb> createState() => _EditQnAWebState();
}

class _EditQnAWebState extends State<EditQnAWeb> {
  String q11 = '';
  String op11 = '';
  String op21 = '';
  String op31 = '';
  String op41 = '';
  String cop1 = '';
  String marks1 = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      q11 = widget.q1;
      op11 = widget.op1;
      op21 = widget.op2;
      op31 = widget.op3;
      op41 = widget.op4;
      cop1 = widget.cop;
      marks1 = widget.marks;
    });
  }

  @override
  Widget build(BuildContext context) {
    var widthsize = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Questions"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
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
                      onChanged: (value) {
                        setState(() {
                          q11 = value;
                        });
                      },
                      minLines: 2,
                      maxLines: 20,
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: q11,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: widthsize * 0.3,
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          op11 = value;
                        });
                      },
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: op11,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: widthsize * 0.3,
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          op21 = value;
                        });
                      },
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: op21,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: widthsize * 0.3,
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          op31 = value;
                        });
                      },
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: op31,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: widthsize * 0.3,
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          op41 = value;
                        });
                      },
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: op41,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: widthsize * 0.3,
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          cop1 = value;
                        });
                      },
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: cop1,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: widthsize * 0.3,
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          marks1 = value;
                        });
                      },
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: marks1,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    width: widthsize * 0.3,
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection('courses')
                              .doc('courseName')
                              .collection(widget.branch)
                              .doc(widget.semester)
                              .collection('subjects')
                              .doc(widget.subject)
                              .collection('qna')
                              .doc(widget.uid)
                              .update({
                            'question': q11,
                            'option1': op11,
                            'option2': op21,
                            'option3': op31,
                            'option4': op41,
                            'correctoption': cop1,
                            'marks': marks1,
                          }).then((value) {
                            Navigator.pop(context);
                            showSnackBar(
                                context: context, content: 'Question Edited');
                          });
                        },
                        child: const Text("Edit Question"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
