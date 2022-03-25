import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color color;
  final String title;
  final VoidCallback function;

  // ignore: use_key_in_widget_constructors
  const RoundedButton(
      {required this.color, required this.title, required this.function});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: function,
          minWidth: MediaQuery.of(context).size.width * 0.9,
          height: 50.0,
          child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
      ),
    );
  }
}

class SpinnerButton extends StatelessWidget {
  final Color color;
  final Widget child;
  final VoidCallback function;

  const SpinnerButton(
      {required this.color, required this.child, required this.function});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: function,
          minWidth: MediaQuery.of(context).size.width * 0.9,
          height: 50.0,
          child: child,
        ),
      ),
    );
  }
}
