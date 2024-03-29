import 'package:bus_ticket_app/exports.dart';
import 'package:bus_ticket_app/models/bus_route_bag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AvailableTicketsScreen extends StatelessWidget {
  const AvailableTicketsScreen({Key? key}) : super(key: key);
  static const String routeName = '/available-tickets';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as String;
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
                  List temp = busRouteBag.busRoutes
                      .where((element) => element.destination == args)
                      .toList();
                  return ListView.builder(
                    itemCount: temp.length,
                    itemBuilder: (context, index) {
                      return BookingTileCustomer(
                          source: temp[index].source,
                          destination: temp[index].destination,
                          time: temp[index].time,
                          index: busRouteBag.busRoutes.indexOf(temp[index]),
                          id: temp[index].routeId);
                    },
                  );
                },
              );
            }
          },
        ));
  }
}
