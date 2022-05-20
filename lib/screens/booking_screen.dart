import 'package:bus_ticket_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../exports.dart';

class ViewBooking extends StatelessWidget {
  const ViewBooking({Key? key}) : super(key: key);

  static const routeName = "/view-schedule";

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
        body: FutureBuilder(
          future: Provider.of<UserData>(context, listen: false).getBooking(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              return Consumer<UserData>(
                builder: (context, udata, child) {
                  return ListView.builder(
                    itemCount: udata.schedule.length,
                    itemBuilder: (context, index) {
                      return BookingTile(
                        source: udata.schedule[index].source,
                        destination: udata.schedule[index].destination,
                        time: udata.schedule[index].date,
                        price: int.parse(udata.schedule[index].price),
                        seatNumber: udata.schedule[index].seatNumber,
                      );
                    },
                  );
                },
              );
            }
          },
        ));
  }
}
