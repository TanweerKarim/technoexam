import 'package:flutter/material.dart';
import 'package:tiuexamportal/screens/student/dashboard/exam/questionansmobile.dart';

class QuestionCard extends StatefulWidget {
  String question;
  String option1;
  String option2;
  String option3;
  String option4;
  String correctopt;
  String marks;
  int index;
  QuestionCard(
      {super.key,
      required this.question,
      required this.option1,
      required this.option2,
      required this.option3,
      required this.option4,
      required this.correctopt,
      required this.marks,
      required this.index});

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  String selectedValue = '';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              widget.question,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            RadioListTile(
              title: Text(widget.option1),
              value: widget.option1,
              groupValue: selectedAnswer[widget.index],
              onChanged: ((value) {
                setState(() {
                  selectedAnswer[widget.index] = value!;
                });
                if (widget.correctopt.toLowerCase() ==
                    widget.option1.toLowerCase()) {
                  if (!markindex.contains(widget.index)) {
                    setState(() {
                      markindex.add(widget.index);
                    });
                    debugPrint(markindex.toString());
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
              }),
            ),
            RadioListTile(
              title: Text(widget.option2),
              value: widget.option2,
              groupValue: selectedAnswer[widget.index],
              onChanged: ((value) {
                setState(() {
                  selectedAnswer[widget.index] = value!;
                });
                if (widget.correctopt.toLowerCase() ==
                    widget.option2.toLowerCase()) {
                  if (!markindex.contains(widget.index)) {
                    setState(() {
                      markindex.add(widget.index);
                    });
                    debugPrint(markindex.toString());
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
              }),
            ),
            RadioListTile(
              title: Text(widget.option3),
              value: widget.option3,
              groupValue: selectedAnswer[widget.index],
              onChanged: ((value) {
                setState(() {
                  selectedAnswer[widget.index] = value!;
                });
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
              }),
            ),
            RadioListTile(
              title: Text(widget.option4),
              value: widget.option4,
              groupValue: selectedAnswer[widget.index],
              onChanged: ((value) {
                setState(() {
                  selectedAnswer[widget.index] = value!;
                });
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
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class Questio extends StatefulWidget {
  int count;
  Questio({super.key, required this.count});

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
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
            color: questionattempt[widget.count] ? Colors.green : Colors.grey),
        child: Center(
          child: Text((widget.count + 1).toString()),
        ),
      ),
    );
  }
}
