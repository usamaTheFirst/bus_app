import 'dart:ui';

import 'package:flutter/material.dart';

const kBackgroundColor = Color(0xFFF9F7F7);
const kPrimaryColor = Color(0xFF3F72AF);
const kTextColor = Color(0xFF112D4E);
const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter your password',
  prefixIcon: Icon(Icons.lock, color: Colors.black54),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

// const kButtonStyle = ElevatedButton.styleFrom(back);
