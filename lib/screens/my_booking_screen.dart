import 'package:flutter/material.dart';

import '../exports.dart';

class MyBooking extends StatelessWidget {
  const MyBooking({Key? key}) : super(key: key);

  static const routeName = "/my-booking";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const DrawerWidget(),
        appBar: AppBar(
          title: const Text(
            'My Booking',
          ),
          backgroundColor: kPrimaryColor,
          centerTitle: true,
        ),
        body: Column(
          children: [
            BookingTile(
                source: 'source city',
                destination: 'destination city',
                dateTime: DateTime.now()),
          ],
        ));
  }
}
