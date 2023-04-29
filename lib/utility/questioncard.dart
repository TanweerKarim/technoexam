import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tiuexamportal/utility/optiontile.dart';

class QuestionCard extends StatefulWidget {
  String question;
  int index;
  String option1;
  String option2;
  String option3;
  String option4;

  QuestionCard({
    super.key,
    required this.question,
    required this.index,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4, required correctopt,
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
