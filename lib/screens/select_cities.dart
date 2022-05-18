import 'package:bus_ticket_app/exports.dart';
import 'package:bus_ticket_app/models/bus_route_bag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectCityScreen extends StatelessWidget {
  const SelectCityScreen({Key? key}) : super(key: key);
  static const String routeName = '/select-city';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: const Text('Select Destination'),
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
                      return Card(
                        child: ListTile(
                          title: Text(busRouteBag.busRoutes[index].destination),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              AvailableTicketsScreen.routeName,
                              arguments:
                                  busRouteBag.busRoutes[index].destination,
                            );
                          },
                        ),
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
