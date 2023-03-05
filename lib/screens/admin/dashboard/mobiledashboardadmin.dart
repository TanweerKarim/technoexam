import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MobileDashboardAdmin extends StatefulWidget {
  const MobileDashboardAdmin({super.key});

  @override
  State<MobileDashboardAdmin> createState() => _MobileDashboardAdminState();
}

class _MobileDashboardAdminState extends State<MobileDashboardAdmin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Admin"),
      ),
    );
  }
}
