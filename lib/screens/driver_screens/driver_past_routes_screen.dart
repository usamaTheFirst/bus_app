import 'package:flutter/material.dart';

import '/exports.dart';

class DriverPastRoutes extends StatelessWidget {
  const DriverPastRoutes({Key? key}) : super(key: key);

  static const routeName = "/driver-past-routes";

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
            BookingTile(
                source: 'source city',
                destination: 'destination city',
                dateTime: DateTime.now()),
          ],
        ));
  }
}
