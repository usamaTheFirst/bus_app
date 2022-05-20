import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../exports.dart';

class BookingTile extends StatelessWidget {
  const BookingTile({
    Key? key,
    required this.source,
    required this.destination,
    required this.time,
    required this.price,
    this.seatNumber,
  }) : super(key: key);

  final String source;
  final String destination;
  final Timestamp time;
  final int price;
  final String? seatNumber;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 2,
        child: ListTile(
          minVerticalPadding: 20,
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 18,
                  color: kTextColor.withOpacity(.8),
                ),
                children: [
                  const TextSpan(
                    text: 'Source: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: ' $source\n',
                  ),
                  const TextSpan(
                    text: 'Destination: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: ' $destination\n',
                  ),
                  WidgetSpan(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                    ),
                  ),
                  const TextSpan(
                    text: 'Price: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: ' Rs. $price\n',
                  ),
                  const TextSpan(
                    text: 'Seat Number: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: seatNumber,
                  ),
                  WidgetSpan(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                    ),
                  ),
                  const TextSpan(
                    text: 'Date: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text:
                        ' ${DateFormat("dd-MM-yyyy").format(DateTime.parse(time.toDate().toString()))}\n',
                  ),
                  const TextSpan(
                    text: 'Time: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text:
                        ' ${DateFormat.jm().format(DateTime.fromMicrosecondsSinceEpoch(time.microsecondsSinceEpoch))}',
                  ),
                ],
              ),
            ),
          ),
          textColor: kTextColor,
        ),
      ),
    );
  }
}
