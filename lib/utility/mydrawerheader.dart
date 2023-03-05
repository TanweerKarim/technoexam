import 'package:flutter/material.dart';

class MyHeaderDrawer extends StatefulWidget {
  String name;
  String type;
  String email;
  String url;
  MyHeaderDrawer({
    super.key,
    required this.email,
    required this.name,
    required this.type,
    required this.url,
  });
  @override
  _MyHeaderDrawerState createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(widget.url),
          ),
          Text(
            widget.name,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Text(
            widget.type,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Text(
            widget.email,
            style: TextStyle(
              color: Colors.grey[200],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
