import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CourseHomePageMobile extends StatefulWidget {
  String coursename;
  String courseDtl;
  var size;
  CourseHomePageMobile({
    super.key,
    required this.coursename,
    required this.courseDtl,
    required this.size,
  });

  @override
  State<CourseHomePageMobile> createState() => _CourseHomePageMobileState();
}

class _CourseHomePageMobileState extends State<CourseHomePageMobile> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.coursename,
                  style: const TextStyle(fontSize: 30),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                height: 400,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    textAlign: TextAlign.center,
                    widget.courseDtl,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 800,
                child: Column(
                  children: [
                    SizedBox(
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
                    SizedBox(
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
