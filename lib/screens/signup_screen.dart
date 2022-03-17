import 'package:bus_ticket_app/constants/constants.dart';
import 'package:bus_ticket_app/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);
  static const String routeName = '/signup';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(top: 100),
              // alignment: Alignment.center,
              child: Text(
                'Register to Bus Ticket App',
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Roboto',
                  color: kTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            if (MediaQuery.of(context).viewInsets.bottom <= 0)
              SizedBox(
                height: 100,
              ),
            Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: "Name",
                          prefixIcon:
                              Icon(Icons.account_circle, color: Colors.black54),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Email',
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.black54,
                          ),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Please enter your email';
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Password',
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Confirm Password',
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InternationalPhoneNumberInput(
                        initialValue: PhoneNumber(isoCode: 'PK'),
                        onInputChanged: (val) {},
                        inputDecoration: kTextFieldDecoration,
                      ),
                    ),
                    RoundedButton(
                      title: 'Register',
                      color: kPrimaryColor,
                      function: () {
                        _formKey.currentState!.validate();
                      },
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
