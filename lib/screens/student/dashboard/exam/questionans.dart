import 'package:flutter/material.dart';
import 'package:tiuexamportal/screens/student/dashboard/exam/questionansmobile.dart';
import 'package:tiuexamportal/screens/student/dashboard/exam/questionansweb.dart';
import 'package:tiuexamportal/utility/responsive_layout.dart';

class QuestionAns extends StatefulWidget {
  String semester;
  String subject;
  String branch;
  String totaltime;
  QuestionAns({
    super.key,
    required this.subject,
    required this.semester,
    required this.branch,
    required this.totaltime,
  });

  @override
  State<QuestionAns> createState() => _QuestionAnsState();
}

class _QuestionAnsState extends State<QuestionAns> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ResponsiveLayout(
          mobileScreenLayout: QuestionAnsMobile(
            subject: widget.subject,
            semester: widget.semester,
            branch: widget.branch,
            totaltime: widget.totaltime,
          ),
          webScreenLayout: QuestionAnsWeb(
              subject: widget.subject,
              semester: widget.semester,
              branch: widget.branch,
              totaltime: widget.totaltime)),
    );
  }
}
