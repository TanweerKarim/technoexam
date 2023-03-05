import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:tiuexamportal/screens/admin/courses/screen/menuscreens/createexam/createquestion/createquestionpaper.dart';
import 'package:tiuexamportal/screens/admin/courses/screen/menuscreens/createexam/createquestion/createquestionpapermobile.dart';
import 'package:tiuexamportal/utility/responsive_layout.dart';
import 'package:tiuexamportal/utility/utility.dart';

class CreateSubject extends StatefulWidget {
  String branch;
  String semester;
  String courseDtl;

  CreateSubject({
    super.key,
    required this.branch,
    required this.semester,
    required this.courseDtl,
  });

  @override
  State<CreateSubject> createState() => _CreateSubjectState();
}

class _CreateSubjectState extends State<CreateSubject> {
  String subjectname = '';
  String examdate = 'Select exam date';
  String starttime = 'Select start time of the exam';
  String endtime = 'Select end time of the exam';
  String totaltime = '0';
  @override
  Widget build(BuildContext context) {
    var widthsize = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Subject"),
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
                "Add Subject Details",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: widthsize * 0.3,
                child: TextField(
                  onChanged: (value) => setState(() {
                    subjectname = value;
                  }),
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    hintText: 'Enter subject name',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: widthsize * 0.3,
                child: TextField(
                  //editing controller of this TextField
                  decoration: InputDecoration(
                      icon:
                          const Icon(Icons.calendar_today), //icon of text field
                      hintText: examdate //label text of field
                      ),
                  readOnly:
                      true, //set it true, so that user will not able to edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(
                            2000), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        examdate =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: widthsize * 0.3,
                child: TextField(
                  //editing controller of this TextField
                  decoration: InputDecoration(
                      icon: const Icon(Icons.timer), //icon of text field
                      hintText: starttime //label text of field
                      ),
                  readOnly:
                      true, //set it true, so that user will not able to edit text
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      initialTime: TimeOfDay.now(),
                      context: context,
                    );

                    if (pickedTime != null) {
                      print(pickedTime.format(context)); //output 10:51 PM
                      DateTime parsedTime = DateFormat.jm()
                          .parse(pickedTime.format(context).toString());
                      //converting to DateTime so that we can further format on different pattern.
                      print(parsedTime); //output 1970-01-01 22:53:00.000
                      String formattedTime =
                          DateFormat('HH:mm:ss').format(parsedTime);
                      print(formattedTime); //output 14:59:00
                      //DateFormat() is from intl package, you can format the time on any pattern you need.

                      setState(() {
                        starttime =
                            formattedTime; //set the value of text field.
                      });
                    } else {
                      print("Time is not selected");
                    }
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: widthsize * 0.3,
                child: TextField(
                  //editing controller of this TextField
                  decoration: InputDecoration(
                      icon: const Icon(Icons.timer), //icon of text field
                      hintText: endtime //label text of field
                      ),
                  readOnly:
                      true, //set it true, so that user will not able to edit text
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      initialTime: TimeOfDay.now(),
                      context: context,
                    );

                    if (pickedTime != null) {
                      print(pickedTime.format(context)); //output 10:51 PM
                      DateTime parsedTime = DateFormat.jm()
                          .parse(pickedTime.format(context).toString());
                      //converting to DateTime so that we can further format on different pattern.
                      print(parsedTime); //output 1970-01-01 22:53:00.000
                      String formattedTime =
                          DateFormat('HH:mm:ss').format(parsedTime);
                      print(formattedTime); //output 14:59:00
                      //DateFormat() is from intl package, you can format the time on any pattern you need.

                      setState(() {
                        endtime = formattedTime; //set the value of text field.
                      });
                    } else {
                      print("Time is not selected");
                    }
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: widthsize * 0.3,
                child: TextField(
                  decoration: InputDecoration(
                      icon: const Icon(Icons.timer), //icon of text field
                      hintText:
                          "Exam Duration in Minutes " //label text of field
                      ),
                  onChanged: (value) {
                    setState(() {
                      totaltime = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: widthsize * 0.3,
                child: ElevatedButton(
                  onPressed: () async {
                    if (subjectname != '' &&
                        examdate != 'Select exam date' &&
                        starttime != 'Select start time of the exam' &&
                        endtime != 'Select end time of the exam') {
                      await FirebaseFirestore.instance
                          .collection('courses')
                          .doc('courseName')
                          .collection(widget.branch)
                          .doc(widget.semester)
                          .collection('subjects')
                          .doc(subjectname)
                          .set({
                        'subjectName': subjectname,
                        'examDate': examdate,
                        'startTime': starttime,
                        'endTime': endtime,
                        'totaltime': totaltime,
                        'active': true,
                      }).then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResponsiveLayout(
                                  mobileScreenLayout: CreateQuestionPaperMobile(
                                    branch: widget.branch,
                                    semester: widget.semester,
                                    subject: subjectname,
                                    courseDtl: widget.courseDtl,
                                    active: true,
                                    endTime: endtime,
                                    examDate: examdate,
                                    startTime: starttime,
                                    totalTime: totaltime,
                                  ),
                                  webScreenLayout: CreateQuestionPaper(
                                    branch: widget.branch,
                                    semester: widget.semester,
                                    subject: subjectname,
                                    courseDtl: widget.courseDtl,
                                    active: true,
                                    endTime: endtime,
                                    examDate: examdate,
                                    startTime: starttime,
                                    totalTime: totaltime,
                                  )),
                            ));
                      });
                    } else {
                      showSnackBar(
                          context: context, content: 'Fill out all the fields');
                    }
                  },
                  child: const Text("Create Subject"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
