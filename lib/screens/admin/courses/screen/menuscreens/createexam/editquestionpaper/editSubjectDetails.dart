import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_switch/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:tiuexamportal/screens/admin/courses/screen/menuscreens/createexam/createquestion/createquestionpaper.dart';
import 'package:tiuexamportal/screens/admin/courses/screen/menuscreens/createexam/createquestion/createquestionpapermobile.dart';
import 'package:tiuexamportal/utility/responsive_layout.dart';
import 'package:tiuexamportal/utility/utility.dart';

class EditSubjectDetailsWeb extends StatefulWidget {
  String branch;
  String semester;
  String courseDtl;
  String subject;
  bool active;
  String endTime;
  String examDate;
  String startTime;
  String totalTime;
  EditSubjectDetailsWeb({
    super.key,
    required this.branch,
    required this.semester,
    required this.courseDtl,
    required this.subject,
    required this.active,
    required this.endTime,
    required this.examDate,
    required this.startTime,
    required this.totalTime,
  });

  @override
  State<EditSubjectDetailsWeb> createState() => _EditSubjectDetailsWebState();
}

class _EditSubjectDetailsWebState extends State<EditSubjectDetailsWeb> {
  String subjectname = '';
  String examdate = 'Select exam date';
  String starttime = 'Select start time of the exam';
  String endtime = 'Select end time of the exam';
  String totaltime = '0';
  bool active = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      subjectname = widget.subject;
      examdate = widget.examDate;
      starttime = widget.startTime;
      endtime = widget.endTime;
      totaltime = widget.totalTime;
      active = widget.active;
    });
  }

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
                "Edit Subject Details",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
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
                      hintText: widget.totalTime //label text of field
                      ),
                  onChanged: (value) {
                    setState(() {
                      totaltime = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: widthsize * 0.3,
                child: Row(
                  children: [
                    Text("Active status - "),
                    CustomSwitch(
                      value: widget.active,
                      activeColor: Colors.green,
                      onChanged: (value) {
                        setState(() {
                          active = value;
                        });
                      },
                    ),
                  ],
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
                          .update({
                        'subjectName': subjectname,
                        'examDate': examdate,
                        'startTime': starttime,
                        'endTime': endtime,
                        'totaltime': totaltime,
                        'active': active,
                      }).then((value) {
                        Navigator.pop(context);
                        showSnackBar(
                            context: context,
                            content:
                                "$subjectname details updated successfully");
                      });
                    } else {
                      showSnackBar(
                          context: context, content: 'Fill out all the fields');
                    }
                  },
                  child: const Text("Edit Subject"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
