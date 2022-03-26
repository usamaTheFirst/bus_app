import 'package:bus_ticket_app/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);
  static const String routeName = '/admin/home';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: const Scaffold(
      body: Center(child: Text('Admin Home Screen')),
      drawer: DrawerWidget(),
    ));
  }
}
