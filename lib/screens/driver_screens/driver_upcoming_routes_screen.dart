import 'package:flutter/material.dart';

import '/exports.dart';

class DriverUpcomingRoutes extends StatelessWidget {
  const DriverUpcomingRoutes({Key? key}) : super(key: key);

  static const routeName = "/driver-upcoming-routes";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const DrawerWidget(),
        appBar: AppBar(
          title: const Text(
            'My Routes',
          ),
          backgroundColor: kPrimaryColor,
          centerTitle: true,
        ),
        body: Column(
          children: [
            const DayLabel(day: 'Monday'),
            BookingTile(
                source: 'source city',
                destination: 'destination city',
                dateTime: DateTime.now()),
            const DayLabel(day: 'Tuesday'),
            BookingTile(
                source: 'source city',
                destination: 'destination city',
                dateTime: DateTime.now()),
          ],
        ));
  }
}
