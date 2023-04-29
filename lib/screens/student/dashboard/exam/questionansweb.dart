import 'dart:collection';
import 'package:tiuexamportal/screens/student/dashboard/exam/questionansmobile.dart';
import 'package:tiuexamportal/screens/student/dashboard/exam/questioncard.dart';
import 'package:tiuexamportal/screens/student/feedback/feedbackform.dart';
import 'package:universal_html/html.dart' as htmluse;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tiuexamportal/screens/mainscreen.dart';

class QuestionAnsWeb extends StatefulWidget {
  String semester;
  String subject;
  String branch;
  String totaltime;
  String userName;
  String email;
  
  QuestionAnsWeb({
    super.key,
    required this.subject,
    required this.semester,
    required this.branch,
    required this.totaltime,
    required this.userName,
    required this.email,
  });

  @override
  State<QuestionAnsWeb> createState() => _QuestionAnsWebState();
}

class _QuestionAnsWebState extends State<QuestionAnsWeb>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late final DateTime startTime;
  late final DateTime endTime;
  late AnimationController controller;
  PageController _pageController = PageController(initialPage: 0);
  String get countText {
    Duration count = controller.duration! * controller.value;
    return controller.isDismissed
        ? '${controller.duration!.inHours}:${(controller.duration!.inMinutes % 60).toString().padLeft(2, '0')}:${(controller.duration!.inSeconds % 60).toString().padLeft(2, '0')}'
        : '${count.inHours}:${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  bool isLoading = false;
  int index = 0;
  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var currentUserSnap = await FirebaseFirestore.instance
          .collection('courses')
          .doc('courseName')
          .collection(widget.branch)
          .doc(widget.semester)
          .collection('subjects')
          .doc(widget.subject)
          .collection('qna')
          .get();
      index = currentUserSnap.docs.length;
      for (int i = 0; i < index; i++) {
        setState(() {
          questionattempt.add(false);
        });
      }
      setState(() {});
    } catch (e) {
      index = 0;
    }
    setState(() {
      isLoading = false;
    });
  }

  void goFullScreen() {
    htmluse.document.documentElement?.requestFullscreen();
  }

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      htmluse.window.addEventListener('focus', onFocus);
      htmluse.window.addEventListener('blur', onBlur);
    }
    goFullScreen();
    WidgetsBinding.instance.addObserver(this);
    getData();
    int ttltime = int.parse(widget.totaltime);
    controller = AnimationController(
      vsync: this,
      duration: Duration(minutes: ttltime),
    );
    controller.reverse(from: controller.value == 0 ? 1.0 : controller.value);
    controller.addListener(() {
      if (countText == '0:00:00') {
        submitans();
      }
    });
  }

  void onFocus(htmluse.Event e) {
    didChangeAppLifecycleState(AppLifecycleState.resumed);
  }

  void onBlur(htmluse.Event e) {
    didChangeAppLifecycleState(AppLifecycleState.paused);
  }

  void cancelExam() {
    int totalmarks = 0;
    int total = 0;
    if (markindex.isEmpty) {
      debugPrint('0');
    } else {
      for (int i = 0; i < markindex.length; i++) {
        total = (total + marksofques.elementAt(markindex[i]));
      }
    }
    for (int i = 0; i < questionattempt.length; i++) {
      questionattempt[i] = false;
    }
    htmluse.document.exitFullscreen();
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(widget.semester)
        .doc(widget.subject)
        .set({
      'hasStarted': false,
      'isSubmitted': true,
      'totalmarks': totalmarks,
      'marksobtained': '0',
      'subject': widget.subject,
    }).then((value) => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => MainScreen(),
              ),
              (route) => false,
            ));
  }

  void showAlert() {
    count++;
    if (count == 4) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Exam Cancelled'),
          content: Text(
              'You are trying to use unfair means and your exam is cancelled'),
          actions: <Widget>[
            TextButton(
              onPressed: () => cancelExam(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Warning $count'),
          content: const Text('You are changing Tabs'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } //debugPrint(count.toString());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        showAlert();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  void dispose() {
    if (kIsWeb) {
      htmluse.window.removeEventListener('focus', onFocus);
      htmluse.window.removeEventListener('blur', onBlur);
    }
    WidgetsBinding.instance.removeObserver(this);

    controller.dispose();
    super.dispose();
  }

  void submitans() async {
    int totalmarks = 0;
    int total = 0;
    if (markindex.isEmpty) {
      debugPrint('0');
    } else {
      for (int i = 0; i < markindex.length; i++) {
        total = (total + marksofques.elementAt(markindex[i]));
      }
    }
    for (int i = 0; i < marksofques.length; i++) {
      totalmarks += marksofques.elementAt(i);
    }
    for (int i = 0; i < questionattempt.length; i++) {
      questionattempt[i] = false;
    }
    qnaindex.clear();
    htmluse.document.exitFullscreen();
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(widget.semester)
        .doc(widget.subject)
        .set({
      'hasStarted': false,
      'isSubmitted': true,
      'totalmarks': totalmarks,
      'marksobtained': total,
      'subject': widget.subject,
    }).then((value) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => FeedbackScreen(email: widget.email,
            userName: widget.userName,
            screentype: "Exam",
          ),
        ),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.subject),
          backgroundColor: Colors.blue,
        ),
        drawer: Drawer(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    AnimatedBuilder(
                      animation: controller,
                      builder: (context, child) => Text(
                        countText,
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Attempted Questions :",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 400,
                      child: GridView.count(
                        crossAxisCount: 5,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 5.0,
                        children: [
                          for (int i = 0; i < index; i++) ...[
                            if (!isLoading) ...[
                              Questio(
                                count: i,
                              )
                            ] else ...[
                              Container()
                            ],
                          ]
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Container(
          child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('courses')
                  .doc('courseName')
                  .collection(widget.branch)
                  .doc(widget.semester)
                  .collection('subjects')
                  .doc(widget.subject)
                  .collection('qna')
                  .orderBy('question')
                  .get(),
              builder: (_, snapshot) {
                if (snapshot.hasError) return Text('Error = ${snapshot.error}');
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading");
                }
                marksofques.clear();
                selectedAnswer.clear();
                questionattempt.clear();
                markindex.clear();
                qnaindex.clear();
                int index = -1;
                return Column(
                  children: [
                    SizedBox(
                      height: 600,
                      child: ListView(
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        marksofques.add(int.parse(data['marks']));
                        questionattempt.add(false);
                        selectedAnswer.add(" ");
                        // debugPrint(marksofques.toString());
                        index++;
                        debugPrint(selectedAnswer.toString());
                        return QuestionCard(
                          question: data['question'],
                          option1: data['option1'],
                          option2: data['option2'],
                          option3: data['option3'],
                          option4: data['option4'],
                          correctopt: data['correctoption'],
                          marks: data['correctoption'],
                          index: index,
                        );
                        // questionCard(
                        //     data['question'],
                        //     data['option1'],
                        //     data['option2'],
                        //     data['option3'],
                        //     data['option4'],
                        //     data['correctoption'],
                        //     data['correctoption'],
                        //     index);
                      }).toList()),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            submitans();
                            debugPrint(selectedAnswer.toString() +
                                " " +
                                questionattempt.toString());
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue)),
                          child: const Padding(
                            padding: EdgeInsets.all(4),
                            child: Text(
                              'Submit',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              }),
        ));
  }
}
