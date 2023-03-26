import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_switch/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:tiuexamportal/globals.dart';
import 'package:tiuexamportal/utility/utility.dart';

class EditStudentsDetailsWeb extends StatefulWidget {
  String uid;
  String name;
  String email;
  bool isActive;
  EditStudentsDetailsWeb({
    super.key,
    required this.uid,
    required this.email,
    required this.isActive,
    required this.name,
  });

  @override
  State<EditStudentsDetailsWeb> createState() => _EditStudentsDetailsWebState();
}

class _EditStudentsDetailsWebState extends State<EditStudentsDetailsWeb> {
  String sname = "";
  String semail = "";
  bool sIsActive = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      sname = widget.name;
      semail = widget.email;
      sIsActive = widget.isActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    var widthsize = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Students Details"),
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
                  "Edit Students Details",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: widthsize * 0.3,
                  child: TextField(
                    onChanged: (value) => setState(() {
                      sname = value;
                    }),
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: widget.name,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: widthsize * 0.3,
                  child: TextField(
                    onChanged: (value) => setState(() {
                      semail = value;
                    }),
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: widget.email,
                    ),
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
                        value: widget.isActive,
                        activeColor: Colors.green,
                        onChanged: (value) {
                          setState(() {
                            sIsActive = value;
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
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(widget.uid)
                          .update({
                        'name': sname,
                        'email': semail,
                        'active': sIsActive,
                      }).then((value) {
                        Navigator.pop(context);
                        showSnackBar(
                            context: context,
                            content: "Student details updated successfully");
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
