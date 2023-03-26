import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_switch/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:tiuexamportal/utility/utility.dart';

class EditSubjectMarksMobile extends StatefulWidget {
  bool hasStarted;
  bool isSubmitted;
  String marksobtained;
  String subject;
  String uid;
  String semester;
  EditSubjectMarksMobile({
    super.key,
    required this.hasStarted,
    required this.isSubmitted,
    required this.marksobtained,
    required this.subject,
    required this.uid,
    required this.semester,
  });

  @override
  State<EditSubjectMarksMobile> createState() => _EditSubjectMarksMobileState();
}

class _EditSubjectMarksMobileState extends State<EditSubjectMarksMobile> {
  bool hasStarted = false;
  bool isSubmitted = false;
  String marksobtained = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      hasStarted = widget.hasStarted;
      isSubmitted = widget.isSubmitted;
      marksobtained = widget.marksobtained;
    });
  }

  @override
  Widget build(BuildContext context) {
    var widthsize = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Marks Details"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                const Text(
                  "Edit Marks Details",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: widthsize,
                  child: TextField(
                    enableSuggestions: false,
                    autocorrect: false,
                    enabled: false,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: widget.subject,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: widthsize,
                  child: Row(
                    children: [
                      Text("Has Started - "),
                      CustomSwitch(
                        value: widget.hasStarted,
                        activeColor: Colors.green,
                        onChanged: (value) {
                          setState(() {
                            hasStarted = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: widthsize,
                  child: Row(
                    children: [
                      Text("Is Submitted - "),
                      CustomSwitch(
                        value: widget.isSubmitted,
                        activeColor: Colors.green,
                        onChanged: (value) {
                          setState(() {
                            isSubmitted = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: widthsize,
                  child: TextField(
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: widget.marksobtained,
                    ),
                    onChanged: (value) {
                      marksobtained = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  width: widthsize,
                  child: ElevatedButton(
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(widget.uid)
                          .collection(widget.semester)
                          .doc(widget.subject)
                          .update({
                        'isSubmitted': isSubmitted,
                        'hasStarted': hasStarted,
                        'marksobtained': marksobtained,
                      }).then((value) {
                        Navigator.pop(context);
                        showSnackBar(
                            context: context,
                            content: "Marks details updated successfully");
                      });
                    },
                    child: const Text("Edit Details"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
