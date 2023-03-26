import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tiuexamportal/screens/admin/courses/screen/menuscreens/students/subjectswithmarks/subjectmarks.dart';

class StudentsSubjectMarks extends StatefulWidget {
  String name;
  String uid;
  StudentsSubjectMarks({super.key, required this.name, required this.uid});

  @override
  State<StudentsSubjectMarks> createState() => _StudentsSubjectMarksState();
}

class _StudentsSubjectMarksState extends State<StudentsSubjectMarks> {
  String dropdownvalue = 'semester 1';

  // List of items in our dropdown menu
  var items = [
    'semester 1',
    'semester 2',
    'semester 3',
    'semester 4',
    'semester 5',
    'semester 6',
    'semester 7',
    'semester 8',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Report"),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 250,
                    child: Text(
                      "Report of ${widget.name} for ${dropdownvalue}",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Spacer(),
                  DropdownButton(
                    // Initial Value
                    value: dropdownvalue,

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 600,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: SubjectMarks(semester: dropdownvalue, uid: widget.uid),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
