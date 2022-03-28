import 'package:flutter/material.dart';

import '../exports.dart';

class ViewHistory extends StatelessWidget {
  const ViewHistory({Key? key}) : super(key: key);

  static const routeName = "/view-history";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const DrawerWidget(),
        appBar: AppBar(
          title: const Text(
            'Travel History',
          ),
          backgroundColor: kPrimaryColor,
          centerTitle: true,
        ),
        body: Column(
          children: [
            BookingTile(
                source: 'source city',
                destination: 'destination city',
                time: TimeOfDay.now().toString()),
            BookingTile(
                source: 'source city',
                destination: 'destination city',
                time: TimeOfDay.now().toString()),
            BookingTile(
                source: 'source city',
                destination: 'destination city',
                time: TimeOfDay.now().toString()),
          ],
        ));
  }
}
