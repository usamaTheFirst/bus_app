import 'package:flutter/material.dart';

import '../exports.dart';

class DayLabel extends StatelessWidget {
  const DayLabel({
    required this.day,
    Key? key,
  }) : super(key: key);

  final String day;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(
        left: 20,
        top: 20,
        bottom: 10,
      ),
      child: Text(
        '$day:',
        style: const TextStyle(
          fontSize: 20,
          color: kTextColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
