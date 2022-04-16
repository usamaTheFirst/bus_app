import 'package:bus_ticket_app/constants/constants.dart';
import 'package:bus_ticket_app/exports.dart';
import 'package:bus_ticket_app/screens/admin/admin_home_screen.dart';
import 'package:bus_ticket_app/widgets/rounded_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String? _email, _password;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool loader = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 100),
            // alignment: Alignment.center,
            child: const Text(
              'Login to Bus Ticket App',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Roboto',
                color: kTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Form(
              key: _formKey,
              child: Flexible(
                child: ListView(
                  padding: const EdgeInsets.all(8),
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: "Email",
                          prefixIcon:
                              const Icon(Icons.email, color: Colors.black54),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          } else if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        onSaved: (value) =>
                            _email = value.toString().toString(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        obscureText: true,
                        decoration: kTextFieldDecoration.copyWith(
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.black54,
                          ),
                          hintText: 'Password',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                        onSaved: (value) => _password = value.toString().trim(),
                      ),
                    ),
                    SpinnerButton(
                      child: loader
                          ? const CircularProgressIndicator()
                          : const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Roboto',
                                color: Colors.white,
                              ),
                            ),
                      color: kPrimaryColor,
                      function: () async {
                        bool val = _formKey.currentState!.validate();

                        if (val) {
                          _formKey.currentState?.save();
                          setState(() {
                            loader = true;
                          });
                          try {
                            User? _user =
                                (await _auth.signInWithEmailAndPassword(
                                        email: _email.toString(),
                                        password: _password.toString()))
                                    .user;
                            final id = _user?.uid;
                            String role = await FirebaseFirestore.instance
                                .collection('users')
                                .doc(id)
                                .get()
                                .then((value) => value.data()!['role']);

                            Provider.of<UserData>(context, listen: false)
                                .setUserData(_user?.displayName, _user?.email,
                                    _user!.uid, role);

                            if (role == "customer") {
                              Navigator.pushReplacementNamed(
                                  context, MainUserScreen.routeName);
                            } else if (role == 'driver') {
                              Navigator.pushReplacementNamed(
                                  context, MainDriverScreen.routeName);
                            } else if (role == 'admin') {
                              Navigator.pushReplacementNamed(
                                  context, AdminHomeScreen.routeName);
                            }
                          } on FirebaseAuthException catch (e) {
                            print(e.message.toString());
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(e.message.toString()),
                              ),
                            );
                          }
                          setState(() {
                            loader = false;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
