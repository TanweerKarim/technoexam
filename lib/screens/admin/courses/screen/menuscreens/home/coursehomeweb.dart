import 'package:flutter/material.dart';

class CourserHomeWeb extends StatefulWidget {
  String coursename;
  String courseDtl;
  var size;
  CourserHomeWeb({
    super.key,
    required this.coursename,
    required this.size,
    required this.courseDtl,
  });

  @override
  State<CourserHomeWeb> createState() => _CourserHomeWebState();
}

class _CourserHomeWebState extends State<CourserHomeWeb> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 70,
              ),
              Text(
                widget.coursename,
                style: const TextStyle(fontSize: 32),
              ),
              SizedBox(
                width: double.infinity,
                height: 150,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    widget.courseDtl,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 400,
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 400,
                        child: Column(
                          children: [
                            const Text(
                              "New Updates",
                              style: TextStyle(fontSize: 32),
                            ),
                            Container(
                              height: 300,
                              width: double.infinity,
                              child: const Center(
                                child: Text("Coming Soon"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 400,
                        child: Column(
                          children: [
                            const Text(
                              "Upcoming exams",
                              style: TextStyle(fontSize: 32),
                            ),
                            Container(
                              height: 300,
                              width: double.infinity,
                              child: const Center(
                                child: Text("Coming Soon"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
