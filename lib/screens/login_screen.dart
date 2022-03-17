import 'package:bus_ticket_app/constants/constants.dart';
import 'package:bus_ticket_app/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 100),
            // alignment: Alignment.center,
            child: Text(
              'Login to Bus Ticket App',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Roboto',
                color: kTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
          Form(
              key: _formKey,
              child: Flexible(
                child: ListView(
                  physics: AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: "Email",
                          prefixIcon: Icon(Icons.email, color: Colors.black54),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: kTextFieldDecoration.copyWith(
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.black54,
                          ),
                          hintText: 'Password',
                        ),
                      ),
                    ),
                    RoundedButton(
                      title: 'Login',
                      color: kPrimaryColor,
                      function: () {},
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
