import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiuexamportal/globals.dart';
import 'package:tiuexamportal/utility/utility.dart';
import '../../../../globals.dart' as globals;

class CsvToList extends StatefulWidget {
  const CsvToList({super.key});

  @override
  State<StatefulWidget> createState() {
    return CsvToListState();
  }
}

List<String> uid = [];

class CsvToListState extends State<CsvToList> {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.green,
                height: 30,
                child: TextButton(
                  child: Text(
                    "CSV To List",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: _openFileExplorer,
                ),
              ),
            ),
            ListView.builder(
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
          ],
        ),
      ),
    );
  }

  openFile(filepath) async {
    File f = new File(filepath);
    print("CSV to List");
    final input = f.openRead();
    final fields = await input
        .transform(utf8.decoder)
        .transform(new CsvToListConverter())
        .toList();
    print(fields);
    setState(() {
      employeeData = fields;
    });
  }

  void _openFileExplorer() async {
    try {
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: false,
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      openFile(_paths![0].path);
      print(_paths);
      print("File path ${_paths![0]}");
      print(_paths!.first.extension);
    });
    final _auth = FirebaseAuth.instance;
    bool checkUpdated = false;
    for (int i = 0; i < employeeData.length; i++) {
      debugPrint("1");
      await _auth
          .createUserWithEmailAndPassword(
              email: employeeData[i][1], password: employeeData[i][2])
          .then((value) async {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(value.user!.uid)
            .set({
          "name": employeeData[i][0],
          "email": employeeData[i][1],
          "branch": employeeData[i][3],
          "photoUrl":
              "https://firebasestorage.googleapis.com/v0/b/technoexamportal.appspot.com/o/users%2Fprofilepic%2Fsodapdf-converted.png?alt=media&token=7a22e373-d48d-4d36-89be-424584e376f6",
          "semester": employeeData[i][4],
          "type": employeeData[i][5],
          "uid": value.user!.uid,
        }).then((value) => checkUpdated = true);
      });
    }
    if (checkUpdated) {
      _auth
          .signInWithEmailAndPassword(
              email: globals.email, password: globals.password)
          .then((value) => showSnackBar(
              context: context,
              content: "Records of ${employeeData.length} Studnets added"));
    }
  }
}
