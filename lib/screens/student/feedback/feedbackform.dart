import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tiuexamportal/screens/mainscreen.dart';
import 'package:tiuexamportal/utility/utility.dart';
import 'package:uuid/uuid.dart';

class FeedbackScreen extends StatefulWidget {
  String userName;
  String email;
  String screentype;
  FeedbackScreen({
    super.key,
    required this.userName,
    required this.email,
    required this.screentype,
  });

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  double examExp = 1;
  double ux = 1;
  String comments = "Nothing";
  var uuid = Uuid();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.screentype == "Exam"
          ? AppBar(
              title: const Text("Feedback"),
            )
          : null,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String uid = uuid.v4();
          await FirebaseFirestore.instance.collection('feedback').doc(uid).set({
            'examExp': examExp,
            'ux': ux,
            'comment': comments,
            'username': widget.userName,
            'email': widget.email
          }).then((value) {
            Navigator.pop(context);
            showSnackBar(
                context: context, content: "Thank you for your feedback");
          });
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => MainScreen(),
            ),
            (route) => false,
          );
        },
        child: const Icon(Icons.done),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                if (widget.screentype == "Exam") ...[
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "How was your exam",
                      style: TextStyle(fontSize: 26),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RatingBar.builder(
                      initialRating: ux,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            return const Icon(
                              Icons.sentiment_very_dissatisfied,
                              color: Colors.red,
                            );
                          case 1:
                            return const Icon(
                              Icons.sentiment_dissatisfied,
                              color: Colors.redAccent,
                            );
                          case 2:
                            return const Icon(
                              Icons.sentiment_neutral,
                              color: Colors.amber,
                            );
                          case 3:
                            return const Icon(
                              Icons.sentiment_satisfied,
                              color: Colors.lightGreen,
                            );
                          case 4:
                            return const Icon(
                              Icons.sentiment_very_satisfied,
                              color: Colors.green,
                            );
                          default:
                            return Container();
                        }
                      },
                      onRatingUpdate: (rating) {
                        setState(() {
                          examExp = rating;
                        });
                        print(rating);
                      },
                    ),
                  ),
                ],
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "How was your experience",
                    style: TextStyle(fontSize: 26),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RatingBar.builder(
                    initialRating: ux,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      switch (index) {
                        case 0:
                          return const Icon(
                            Icons.sentiment_very_dissatisfied,
                            color: Colors.red,
                          );
                        case 1:
                          return const Icon(
                            Icons.sentiment_dissatisfied,
                            color: Colors.redAccent,
                          );
                        case 2:
                          return const Icon(
                            Icons.sentiment_neutral,
                            color: Colors.amber,
                          );
                        case 3:
                          return const Icon(
                            Icons.sentiment_satisfied,
                            color: Colors.lightGreen,
                          );
                        case 4:
                          return const Icon(
                            Icons.sentiment_very_satisfied,
                            color: Colors.green,
                          );
                        default:
                          return Container();
                      }
                    },
                    onRatingUpdate: (rating) {
                      setState(() {
                        ux = rating;
                      });
                      print(rating);
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Comments",
                    style: TextStyle(fontSize: 26),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    height: 200,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        maxLines: null, //or null
                        decoration: InputDecoration.collapsed(
                            hintText: "Enter your text here"),
                        onChanged: (value) {
                          setState(() {
                            comments = value;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
