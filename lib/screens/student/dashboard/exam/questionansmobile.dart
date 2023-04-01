import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tiuexamportal/screens/mainscreen.dart';
import 'package:tiuexamportal/utility/utility.dart';

class QuestionAnsMobile extends StatefulWidget {
  String semester;
  String subject;
  String branch;
  String totaltime;
  QuestionAnsMobile({
    super.key,
    required this.subject,
    required this.semester,
    required this.branch,
    required this.totaltime,
  });

  @override
  State<QuestionAnsMobile> createState() => _QuestionAnsMobileState();
}

List<int> marksofques = [];
List<int> markindex = [];
HashSet<int> qnaindex = HashSet<int>();
List<bool> questionattempt = [];
int count = 0;

class _QuestionAnsMobileState extends State<QuestionAnsMobile>
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

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    setState(() {
      questionattempt.clear();
    });
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
    }).then((value) => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => MainScreen(),
              ),
              (route) => false,
            ));
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(questionattempt.toString());
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
                              control: _pageController,
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
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.78,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('courses')
                    .doc('courseName')
                    .collection(widget.branch)
                    .doc(widget.semester)
                    .collection('subjects')
                    .doc(widget.subject)
                    .collection('qna')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    final List storedocs = [];
                    snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map a = document.data() as Map<String, dynamic>;
                      storedocs.add(a);
                    }).toList();
                    marksofques.clear();
                    for (int i = 0; i < storedocs.length; i++) {
                      marksofques.add(int.parse(storedocs[i]['marks']));
                    }
                    return ListView(
                      controller: _pageController,
                      children: [
                        for (var i = 0; i < storedocs.length; i++) ...[
                          QuestionCard(
                            question: storedocs[i]['question'],
                            index: i,
                            option1: storedocs[i]['option1'],
                            option2: storedocs[i]['option2'],
                            option3: storedocs[i]['option3'],
                            option4: storedocs[i]['option4'],
                            correctopt: storedocs[i]['correctoption'],
                            marks: int.parse(storedocs[i]['marks']),
                          ),
                        ]
                      ],
                    );
                  } else {
                    if (snapshot.data!.docs.isEmpty) {
                      return Container(
                        child: const Center(
                          child: Text("No Active Exam"),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }
                },
              ),
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
                    // debugPrint(
                    //     totalmarks.toString() + " " + total.toString() + " ");
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue)),
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
        ),
      ),
    );
  }
}

class UnattemptedQuestion extends StatefulWidget {
  int num;
  UnattemptedQuestion({super.key, required this.num});

  @override
  State<UnattemptedQuestion> createState() => _UnattemptedQuestionState();
}

class _UnattemptedQuestionState extends State<UnattemptedQuestion> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14),
                    bottomLeft: Radius.circular(14)),
                color: Colors.blue),
            child: Text(
              widget.num.toString(),
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(14),
                  bottomRight: Radius.circular(14),
                ),
                color: Colors.black54),
            child: Text(
              "Not Attempted",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}

class QuestionCard extends StatefulWidget {
  String question;
  int index;
  String option1;
  String option2;
  String option3;
  String option4;
  String correctopt;
  int marks;

  QuestionCard({
    super.key,
    required this.question,
    required this.index,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4,
    required this.correctopt,
    required this.marks,
  });

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  String selected = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Q${widget.index + 1} ${widget.question}",
              style:
                  TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.8)),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () {
              if (widget.correctopt.toLowerCase() ==
                  widget.option1.toLowerCase()) {
                if (!markindex.contains(widget.index)) {
                  setState(() {
                    markindex.add(widget.index);
                  });
                }
              } else {
                if (markindex.contains(widget.index)) {
                  setState(() {
                    markindex.remove(widget.index);
                  });
                }
              }
              if (!qnaindex.contains(widget.index)) {
                setState(() {
                  questionattempt[widget.index] = true;
                  qnaindex.add(widget.index);
                });
              }

              setState(() {
                selected = widget.option1;
              });
            },
            child: OptionTile(
              option: "A",
              description: widget.option1,
              selected: selected,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              if (widget.correctopt.toLowerCase() ==
                  widget.option2.toLowerCase()) {
                if (!markindex.contains(widget.index)) {
                  setState(() {
                    markindex.add(widget.index);
                  });
                }
              } else {
                if (markindex.contains(widget.index)) {
                  setState(() {
                    markindex.remove(widget.index);
                  });
                }
              }
              if (!qnaindex.contains(widget.index)) {
                setState(() {
                  questionattempt[widget.index] = true;
                  qnaindex.add(widget.index);
                });
              }
              setState(() {
                selected = widget.option2;
              });
            },
            child: OptionTile(
              option: "B",
              description: widget.option2,
              selected: selected,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              if (widget.correctopt.toLowerCase() ==
                  widget.option3.toLowerCase()) {
                if (!markindex.contains(widget.index)) {
                  setState(() {
                    markindex.add(widget.index);
                  });
                }
              } else {
                if (markindex.contains(widget.index)) {
                  setState(() {
                    markindex.remove(widget.index);
                  });
                }
              }
              if (!qnaindex.contains(widget.index)) {
                setState(() {
                  questionattempt[widget.index] = true;
                  qnaindex.add(widget.index);
                });
              }
              setState(() {
                selected = widget.option3;
              });
            },
            child: OptionTile(
              option: "C",
              description: widget.option3,
              selected: selected,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              if (widget.correctopt.toLowerCase() ==
                  widget.option4.toLowerCase()) {
                if (!markindex.contains(widget.index)) {
                  setState(() {
                    markindex.add(widget.index);
                  });
                }
              } else {
                if (markindex.contains(widget.index)) {
                  setState(() {
                    markindex.remove(widget.index);
                  });
                }
              }
              if (!qnaindex.contains(widget.index)) {
                setState(() {
                  questionattempt[widget.index] = true;
                  qnaindex.add(widget.index);
                });
              }
              setState(() {
                selected = widget.option4;
              });
            },
            child: OptionTile(
              option: "D",
              description: widget.option4,
              selected: selected,
            ),
          ),
        ],
      ),
    );
  }
}

class Questio extends StatefulWidget {
  int count;
  PageController control;
  Questio({super.key, required this.count, required this.control});

  @override
  State<Questio> createState() => _QuestioState();
}

class _QuestioState extends State<Questio> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: InkWell(
        onTap: () {
          
          Navigator.pop(context);
          widget.control.jumpTo(widget.count.toDouble() * 150);          // close the drawer
        },
        child: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
              color:
                  questionattempt[widget.count] ? Colors.green : Colors.grey),
          child: Center(
            child: Text((widget.count + 1).toString()),
          ),
        ),
      ),
    );
  }
}

class OptionTile extends StatefulWidget {
  String option;
  String description;
  String selected;
  OptionTile({
    super.key,
    required this.option,
    required this.description,
    required this.selected,
  });

  @override
  State<OptionTile> createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Container(
            height: 28,
            width: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(
                    color: widget.selected == widget.description
                        ? Colors.green
                        : Colors.grey,
                    width: 1.5),
                color: widget.selected == widget.description
                    ? Colors.green
                    : Colors.white,
                borderRadius: BorderRadius.circular(24)),
            child: Text(
              widget.option,
              style: TextStyle(
                color: widget.selected == widget.description
                    ? Colors.white
                    : Colors.grey,
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            widget.description,
            style: TextStyle(fontSize: 17, color: Colors.black54),
          )
        ],
      ),
    );
  }
}
