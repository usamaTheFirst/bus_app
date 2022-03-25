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
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(
                left: 20,
                top: 20,
                bottom: 10,
              ),
              child: const Text(
                'Today:',
                style: TextStyle(
                  fontSize: 20,
                  color: kTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            BookingTile(
                source: 'source city',
                destination: 'destination city',
                dateTime: DateTime.now()),
          ],
        ));
  }
}
