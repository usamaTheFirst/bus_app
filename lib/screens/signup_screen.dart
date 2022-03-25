import 'package:bus_ticket_app/exports.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);
  static const String routeName = '/signup';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey();
  String? name, email, password, phoneNumber;
  bool customerLoader = false;
  bool driverLoader = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 100),
              // alignment: Alignment.center,
              child: const Text(
                'Register to Bus Ticket App',
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Roboto',
                  color: kTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (MediaQuery.of(context).viewInsets.bottom <= 0)
              const SizedBox(
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
                        prefixIcon: const Icon(Icons.account_circle,
                            color: Colors.black54),
                      ),
                      onSaved: (value) => name = value?.trim(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Email',
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.black54,
                        ),
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please enter your email';
                        } else if (!val.contains('@') ||
                            !val.contains('.') ||
                            !val.contains('com')) {
                          return 'Please enter a valid email';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) => email = value?.trim(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      obscureText: true,
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Password',
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.black54,
                        ),
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please enter your password';
                        } else if (val.length < 6) {
                          return 'Password must be at least 6 characters';
                        } else {
                          password = val;
                          return null;
                        }
                      },
                      onSaved: (value) => password = value?.trim(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Confirm Password',
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.black54,
                        ),
                      ),
                      validator: (val) {
                        if (val != password) {
                          return 'Passwords do not match';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InternationalPhoneNumberInput(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please enter your phone number';
                        } else if (val.length < 10) {
                          return 'Phone number must be at least 10 digits';
                        } else {
                          phoneNumber = val;
                          return null;
                        }
                      },
                      initialValue: PhoneNumber(isoCode: 'PK'),
                      onInputChanged: (val) {},
                      onSaved: (value) => phoneNumber = value.phoneNumber,
                      inputDecoration: kTextFieldDecoration,
                    ),
                  ),
                  SpinnerButton(
                    child: !customerLoader
                        ? const Text(
                            "Register as Customer",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          )
                        : const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                    color: kPrimaryColor,
                    function: () async {
                      _formKey.currentState!.validate();
                      _formKey.currentState!.save();
                      setState(() {
                        // customerLoader = true;
                      });

                      try {
                        User? _user =
                            (await _auth.createUserWithEmailAndPassword(
                                    email: email.toString(),
                                    password: password.toString()))
                                .user;
                        final id = _user!.uid;
                        await _user.updateDisplayName(name);
                        await _user.reload();
                        _user = _auth.currentUser;
                        print(id);
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(id)
                            .set({
                          'email': email,
                          'phoneNumber': phoneNumber,
                          'name': name,
                          'role': 'customer',
                        });
                        Provider.of<UserData>(context, listen: false)
                            .setUser(_user!);
                        setState(() {
                          customerLoader = false;
                        });
                        Navigator.pushReplacementNamed(
                            context, MainUserScreen.routeName,
                            arguments: {
                              'name': name,
                            });
                      } on FirebaseAuthException catch (e) {
                        print(e.toString());
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(e.message.toString()),
                          ),
                        );
                      }
                    },
                  ),
                  SpinnerButton(
                      child: !driverLoader
                          ? const Text(
                              "Register as Driver",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            )
                          : const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                      color: kPrimaryColor,
                      function: () async {
                        _formKey.currentState!.validate();
                        _formKey.currentState!.save();
                        setState(() {
                          // customerLoader = true;
                        });

                        try {
                          setState(() {
                            driverLoader = true;
                          });
                          User? _user =
                              (await _auth.createUserWithEmailAndPassword(
                                      email: email.toString(),
                                      password: password.toString()))
                                  .user;
                          final id = _user!.uid;
                          print(id);
                          await _user.reload();
                          _user = _auth.currentUser;

                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(id)
                              .set({
                            'email': email,
                            'phoneNumber': phoneNumber,
                            'name': name,
                            'role': 'driver',
                          });
                          Provider.of<UserData>(context, listen: false)
                              .setUser(_user!);
                          Navigator.pushReplacementNamed(
                              context, MainDriverScreen.routeName);
                        } on FirebaseAuthException catch (e) {
                          print(e.toString());
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.message.toString()),
                            ),
                          );
                        }
                        setState(() {
                          customerLoader = false;
                        });
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
