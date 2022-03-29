import 'package:flutter/material.dart';

import '../exports.dart';

class BookingTileCustomer extends StatelessWidget {
  const BookingTileCustomer(
      {Key? key,
      required this.source,
      required this.destination,
      required this.time,
      required this.index})
      : super(key: key);

  final String source;
  final String destination;
  final DateTime time;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, SeatScreen.routeName,
            arguments: {'index': index});
      },
      child: Padding(
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
                      text: ' $destination',
                    ),
                  ],
                ),
              ),
            ),
            subtitle: Text(
              'Time: ${time.toString()}',
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
      ),
    );
  }
}
