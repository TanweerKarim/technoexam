import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class WebDashboardAdmin extends StatefulWidget {
  const WebDashboardAdmin({super.key});

  @override
  State<WebDashboardAdmin> createState() => _WebDashboardAdminState();
}

class _WebDashboardAdminState extends State<WebDashboardAdmin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Admin"),
      ),
    );
  }
}
