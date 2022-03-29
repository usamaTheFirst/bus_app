import 'package:cloud_firestore/cloud_firestore.dart';
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
              time: Timestamp.fromDate(
                DateTime.now(),
              ),
              price: 100,
            ),
          ],
        ));
  }
}
