import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiuexamportal/globals.dart';
import 'package:tiuexamportal/screens/admin/addstudents/enterdataloadingscreen.dart';
import 'package:tiuexamportal/utility/utility.dart';
import '../../../../globals.dart' as globals;

class AddStudentMobile extends StatefulWidget {
  const AddStudentMobile({super.key});

  @override
  State<StatefulWidget> createState() {
    return AddStudentMobileState();
  }
}

List<String> uid = [];

class AddStudentMobileState extends State<AddStudentMobile> {
  late List<List<dynamic>> employeeData;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<PlatformFile>? _paths;
  String? _extension = "csv";
  FileType _pickingType = FileType.custom;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    employeeData = List<List<dynamic>>.empty(growable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 250,
            ),
            SizedBox(
              child: Icon(
                Icons.upload_file_outlined,
                size: 80,
              ),
            ),
            Container(
              color: Colors.green,
              height: 30,
              child: TextButton(
                child: Text(
                  "Add Student",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: _openFileExplorer,
              ),
            ),
            Container(
              height: 30,
              child: Text(
                "Upload a CSV file to create students",
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openFileExplorer() async {
    FilePickerResult? result;
    try {
      result = await FilePicker.platform.pickFiles(
          allowMultiple: false,
          withData: true,
          type: FileType.custom,
          allowedExtensions: ['csv']);
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      final bytes = utf8.decode((result?.files.first.bytes)!.toList());
      setState(() {
        //from the csv plugin
        employeeData = CsvToListConverter().convert(bytes);
      });
    });

    showAlertDialog(context);
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () {
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EnterDataLoadingSreen(
                employeeData: employeeData,
              ),
            ));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Do you want to add these students?"),
      content: SizedBox(
        width: double.maxFinite,
        height: 800,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: employeeData.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name - ${employeeData[index][0]}"),
                      Text("Email - ${employeeData[index][1]}"),
                      Text("Password - ${employeeData[index][2]}"),
                      Text("Department - ${employeeData[index][3]}"),
                      Text("Semester - ${employeeData[index][4]}"),
                      Text("Type - ${employeeData[index][5]}"),
                    ],
                  ),
                ),
              );
            }),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
