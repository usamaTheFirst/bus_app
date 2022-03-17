import 'package:bus_ticket_app/screens/home_page.dart';
import 'package:bus_ticket_app/screens/login_screen.dart';
import 'package:flutter/material.dart';

import 'constants/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginSCreen.routeName: (context) => LoginSCreen(),
        HomePage.routeName: (context) => HomePage(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
