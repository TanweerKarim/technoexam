import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tiuexamportal/events/addevents.dart';
import 'package:tiuexamportal/events/eventscard.dart';
import 'package:tiuexamportal/notes/notescard.dart';

class EventsMainScreen extends StatefulWidget {
  String userType;
  EventsMainScreen({
    super.key,
    required this.userType,
  });

  @override
  State<EventsMainScreen> createState() => _EventsMainScreenState();
}

class _EventsMainScreenState extends State<EventsMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text(
                  "Events",
                  style: TextStyle(fontSize: 20),
                ),
                Spacer(),
                if (widget.userType == 'admin') ...[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddEvents()));
                      },
                      icon: Icon(
                        Icons.add_box_outlined,
                        size: 40.0,
                      ),
                      tooltip: "Add Event",
                    ),
                  )
                ]
              ],
            ),
          ),
          SizedBox(
            height: 500,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: EventsCard(
                userType: widget.userType,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
