import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../exports.dart';

class BookingTile extends StatelessWidget {
  const BookingTile(
      {Key? key,
      required this.source,
      required this.destination,
      required this.dateTime})
      : super(key: key);

  final String source;
  final String destination;
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
      child: Card(
        elevation: 2,
        child: ListTile(
          minVerticalPadding: 20,
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 20,
                  color: kTextColor.withOpacity(.9),
                ),
                children: [
                  TextSpan(
                    text: 'Source: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: ' $source\n',
                  ),
                  TextSpan(
                    text: 'Destination: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: ' $destination',
                  ),
                ],
              ),
            ),
          ),
          subtitle: Text(
            'Date: ${DateFormat.yMd().format(dateTime)}\nTime: ${DateFormat.jm().format(dateTime)}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              letterSpacing: 1,
              color: kTextColor.withOpacity(.9),
            ),
          ),
          textColor: kTextColor,
        ),
      ),
    );
  }
}