import 'package:bus_ticket_app/constants/constants.dart';
import 'package:bus_ticket_app/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String routeName = '/home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 100),
              alignment: Alignment.topCenter,
              child: SvgPicture.asset(
                'assets/illustration.svg',
                height: 200,
                width: 400,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Welcome to Bus Ticket App',
                style: TextStyle(
                  fontSize: 30,
                  color: kTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Spacer(),
            Container(
                margin: EdgeInsets.only(bottom: 50),
                // alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    RoundedButton(
                        color: kPrimaryColor,
                        title: "Login",
                        function: () {
                          Navigator.pushNamed(context, '/login');
                        }),
                    RoundedButton(
                        color: kPrimaryColor,
                        title: "Register",
                        function: () {})
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
