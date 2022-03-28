import 'package:flutter/material.dart';

import '/exports.dart';

class DriverRoutes extends StatelessWidget {
  const DriverRoutes({Key? key}) : super(key: key);

  static const routeName = "/driver-routes";

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
            const DayLabel(day: 'Today'),
            BookingTile(
                source: 'source city',
                destination: 'destination city',
                time: TimeOfDay.now().toString()),
          ],
        ));
  }
}
