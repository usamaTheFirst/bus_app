import 'package:flutter/material.dart';

const kBackgroundColor = Color(0xFFF9F7F7);
const kPrimaryColor = Color(0xFF3F72AF);
const kTextColor = Color(0xFF112D4E);
const kTextFieldDecoration = InputDecoration(
  // hintText: 'Enter your password',
  // prefixIcon: Icon(Icons.lock, color: Colors.black54),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kPrimaryColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
);

Map<int, Color> color = {
  50: const Color.fromRGBO(63, 114, 175, .1),
  100: const Color.fromRGBO(63, 114, 175, .2),
  200: const Color.fromRGBO(63, 114, 175, .3),
  300: const Color.fromRGBO(63, 114, 175, .4),
  400: const Color.fromRGBO(63, 114, 175, .5),
  500: const Color.fromRGBO(63, 114, 175, .6),
  600: const Color.fromRGBO(63, 114, 175, .7),
  700: const Color.fromRGBO(63, 114, 175, .8),
  800: const Color.fromRGBO(63, 114, 175, .9),
  900: const Color.fromRGBO(63, 114, 175, 1),
};

MaterialColor colorCustom = MaterialColor(0xFF3F72AF, color);
