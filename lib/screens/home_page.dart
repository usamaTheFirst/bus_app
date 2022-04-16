import '../exports.dart';
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
              margin: const EdgeInsets.only(top: 100),
              alignment: Alignment.topCenter,
              child: SvgPicture.asset(
                'assets/illustration.svg',
                height: 200,
                width: 400,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Welcome to Bus Ticket App',
                style: TextStyle(
                  fontSize: 30,
                  color: kTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            Container(
                margin: const EdgeInsets.only(bottom: 50),
                // alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    RoundedButton(
                        color: kPrimaryColor,
                        title: "Login",
                        function: () {
                          Navigator.pushNamed(context, LoginScreen.routeName);
                        }),
                    RoundedButton(
                        color: kPrimaryColor,
                        title: "Register",
                        function: () {
                          Navigator.pushNamed(context, SignupScreen.routeName);
                        })
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
