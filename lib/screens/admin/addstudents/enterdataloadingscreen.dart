import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tiuexamportal/utility/utility.dart';
import '../../../../globals.dart' as globals;

class EnterDataLoadingSreen extends StatefulWidget {
  List<List<dynamic>> employeeData;
  EnterDataLoadingSreen({super.key, required this.employeeData});

  @override
  State<EnterDataLoadingSreen> createState() => _EnterDataLoadingSreenState();
}

class _EnterDataLoadingSreenState extends State<EnterDataLoadingSreen> {
  List<List<dynamic>> employeeData1 = [[]];
  List<bool> added = [];
  bool checkUpdated = false;
  storeDataToAuthAndDB() async {
    for (int i = 0; i < widget.employeeData.length; i++) {
      setState(() {
        added.add(false);
      });
    }
    final _auth = FirebaseAuth.instance;

    try {
      for (int i = 0; i < widget.employeeData.length; i++) {
        await _auth
            .createUserWithEmailAndPassword(
                email: widget.employeeData[i][1],
                password: widget.employeeData[i][2])
            .then((value) async {
          await FirebaseFirestore.instance
              .collection("users")
              .doc(value.user!.uid)
              .set({
            "name": widget.employeeData[i][0],
            "email": widget.employeeData[i][1],
            "password": widget.employeeData[i][2],
            "branch": widget.employeeData[i][3],
            "photoUrl":
                "https://firebasestorage.googleapis.com/v0/b/technoexamportal.appspot.com/o/users%2Fprofilepic%2Fsodapdf-converted.png?alt=media&token=7a22e373-d48d-4d36-89be-424584e376f6",
            "semester": widget.employeeData[i][4],
            "type": widget.employeeData[i][5],
            "uid": value.user!.uid,
          }).then((value) {
            setState(() {
              added[i] = true;
            });
          });
        });
      }
      checkUpdated = true;
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
    if (checkUpdated) {
      _auth
          .signInWithEmailAndPassword(
              email: globals.email, password: globals.password)
          .then((value) => showSnackBar(
              context: context,
              content:
                  "Records of ${widget.employeeData.length} Studnets added"));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    storeDataToAuthAndDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        height: 600,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: widget.employeeData.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "Name - ${widget.employeeData[index][0]}"),
                                      Text(
                                          "Email - ${widget.employeeData[index][1]}"),
                                      Text(
                                          "Password - ${widget.employeeData[index][2]}"),
                                      Text(
                                          "Department - ${widget.employeeData[index][3]}"),
                                      Text(
                                          "Semester - ${widget.employeeData[index][4]}"),
                                      Text(
                                          "Type - ${widget.employeeData[index][5]}"),
                                      added[index]
                                          ? Text("Status - Added")
                                          : Text("Status - Waiting"),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                      if (!checkUpdated) ...[
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Records being created..."),
                              Center(
                                child: LinearProgressIndicator(),
                              ),
                            ],
                          ),
                        ),
                      ]
                    ],
                  ),
                  Spacer(),
                  SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Done"))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
