import 'package:flutter/material.dart';

import '../../exports.dart';

class ManageRoutes extends StatelessWidget {
  const ManageRoutes({Key? key}) : super(key: key);

  static const String routeName = '/manage-routes';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: const Text(
          'Bus Routes',
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
          BookingTile(
              source: 'source city',
              destination: 'destination city',
              dateTime: DateTime.now()),
          BookingTile(
              source: 'source city',
              destination: 'destination city',
              dateTime: DateTime.now()),
          const Spacer(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return AddRoute();
            },
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
