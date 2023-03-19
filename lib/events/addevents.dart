import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:tiuexamportal/utility/utility.dart';
import 'package:uuid/uuid.dart';

class AddEvents extends StatefulWidget {
  const AddEvents({super.key});

  @override
  State<AddEvents> createState() => _AddEventsState();
}

class _AddEventsState extends State<AddEvents> {
  String title = "";
  String note = "";
  final maxLines = 5;
  var uuid = Uuid();
  String eventdate = 'Select event date';
  String starttime = 'Select start time of the event';
  String endtime = 'Select end time of the event';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Event")),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: 55,
              ),
              SizedBox(
                width: double.infinity,
                child: TextField(
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    hintText: 'Title',
                  ),
                  onChanged: (value) {
                    setState(() {
                      title = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                width: double.infinity,
                height: maxLines * 15.0,
                child: TextField(
                  minLines: 2,
                  maxLines: maxLines,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: 'About Event...',
                  ),
                  onChanged: (value) {
                    setState(() {
                      note = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                width: double.infinity,
                child: TextField(
                  //editing controller of this TextField
                  decoration: InputDecoration(
                      icon:
                          const Icon(Icons.calendar_today), //icon of text field
                      hintText: eventdate //label text of field
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
                        eventdate =
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
                width: double.infinity,
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
                width: double.infinity,
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
              Spacer(),
              ElevatedButton(
                onPressed: () async {
                  String uid = uuid.v4();
                  await FirebaseFirestore.instance
                      .collection('events')
                      .doc(uid)
                      .set({
                    'title': title,
                    'note': note,
                    'uid': uid,
                    'dateofevent': eventdate,
                    'starttime': starttime,
                    'endtime': endtime,
                  }).then((value) {
                    Navigator.pop(context);
                    showSnackBar(context: context, content: "Event created");
                  });
                },
                child: Text(
                  "Add Event",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
