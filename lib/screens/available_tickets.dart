import 'package:bus_ticket_app/exports.dart';
import 'package:bus_ticket_app/models/bus_route_bag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/booking_tile_customer.dart';

class AvailableTicketsScreen extends StatelessWidget {
  const AvailableTicketsScreen({Key? key}) : super(key: key);
  static const String routeName = '/available-tickets';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: const Text('Available Routes'),
        ),
        body: FutureBuilder(
          future:
              Provider.of<BusRouteBag>(context, listen: false).fetchBusRoutes(),
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
              return Consumer<BusRouteBag>(
                builder: (context, busRouteBag, child) {
                  return ListView.builder(
                    itemCount: busRouteBag.busRoutes.length,
                    itemBuilder: (context, index) {
                      return BookingTileCustomer(
                          source: busRouteBag.busRoutes[index].source,
                          destination: busRouteBag.busRoutes[index].destination,
                          time: busRouteBag.busRoutes[index].time,
                          index: index);
                    },
                  );
                },
              );
            }
          },
        ));
  }
}
