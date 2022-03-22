import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../exports.dart';

class ViewHistory extends StatelessWidget {
  const ViewHistory({Key? key}) : super(key: key);

  static const routeName = "/view-history";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Travel History',
          ),
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
        ),
        body: Column(
          children: [
            BookingTile(
                source: 'source city',
                destination: 'destination city',
                dateTime: DateTime.now()),
            BookingTile(
                source: 'source city',
                destination: 'destination city',
                dateTime: DateTime.now()),
            BookingTile(
                source: 'source city',
                destination: 'destination city',
                dateTime: DateTime.now()),
          ],
        ));
  }
}
