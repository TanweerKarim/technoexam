import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:tiuexamportal/events/editevents.dart';

class EventsCard extends StatefulWidget {
  String userType;
  EventsCard({super.key, required this.userType});

  @override
  State<EventsCard> createState() => _EventsCardState();
}

class _EventsCardState extends State<EventsCard> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("events").snapshots(),
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
            return ListView(children: [
              for (int i = 0; i < storedocs.length; i++) ...[
                if (widget.userType == 'admin') ...[
                  Card(
                    child: ListTile(
                      title: Center(
                        child: Text(
                          "${storedocs[i]['title']}",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      subtitle: Column(
                        children: [
                          Text(
                            "About Event - ${storedocs[i]['note']}",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Event Date - ${DateFormat("dd-MM-yyyy").format(DateTime.parse(storedocs[i]["dateofevent"] + " " + storedocs[i]["starttime"]))}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "Start time - ${DateFormat("hh:mma").format(DateTime.parse(storedocs[i]["dateofevent"] + " " + storedocs[i]["starttime"]))}",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "End time - ${DateFormat("hh:mma").format(DateTime.parse(storedocs[i]["dateofevent"] + " " + storedocs[i]["endtime"]))}",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            Expanded(
                              child: IconButton(
                                onPressed: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditEvents(
                                                note: storedocs[i]['note'],
                                                title: storedocs[i]['title'],
                                                uid: storedocs[i]['uid'],
                                                endtime: storedocs[i]
                                                    ['endtime'],
                                                eventdate: storedocs[i]
                                                    ['dateofevent'],
                                                starttime: storedocs[i]
                                                    ['starttime'],
                                              )));
                                },
                                icon: Icon(
                                  Icons.edit,
                                ),
                              ),
                            ),
                            Expanded(
                              child: IconButton(
                                onPressed: () {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text('Delete?'),
                                      content: Text(
                                          'Do you really want to delete this event?'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Cancle'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            await FirebaseFirestore.instance
                                                .collection('events')
                                                .doc(storedocs[i]['uid'])
                                                .delete()
                                                .then((value) =>
                                                    Navigator.pop(context));
                                          },
                                          child: const Text('Delete'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.delete,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ] else ...[
                  Card(
                    child: ListTile(
                      title: Center(
                        child: Text(
                          "${storedocs[i]['title']}",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      subtitle: Column(
                        children: [
                          Text(
                            "About Event - ${storedocs[i]['note']}",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Event Date - ${DateFormat("dd-MM-yyyy").format(DateTime.parse(storedocs[i]["dateofevent"] + " " + storedocs[i]["starttime"]))}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "Start time - ${DateFormat("hh:mma").format(DateTime.parse(storedocs[i]["dateofevent"] + " " + storedocs[i]["starttime"]))}",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "End time - ${DateFormat("hh:mma").format(DateTime.parse(storedocs[i]["dateofevent"] + " " + storedocs[i]["endtime"]))}",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ]
              ]
            ]);
          } else {
            if (snapshot.data!.docs.isEmpty) {
              return Container(
                child: const Center(
                  child: Text("No Subjects added yet"),
                ),
              );
            } else {
              return Container();
            }
          }
        });
  }
}
