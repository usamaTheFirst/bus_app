import 'package:bus_ticket_app/models/bus_route_bag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      body: FutureBuilder(
        future:
            Provider.of<BusRouteBag>(context, listen: false).fetchBusRoutes(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.error != null) {
            return const Center(
              child: Text('An error occurred!'),
            );
          } else {
            return Consumer<BusRouteBag>(
              builder: (ctx, busroutes, child) => ListView.builder(
                itemCount: busroutes.busRoutes.length,
                itemBuilder: (context, index) {
                  return BookingTileAdmin(
                    source: busroutes.busRoutes[index].source,
                    destination: busroutes.busRoutes[index].destination,
                    time: busroutes.busRoutes[index].time,
                    price: busroutes.busRoutes[index].price,
                    busNumber: busroutes.busRoutes[index].busNumber,
                    numberOfSeats: busroutes.busRoutes[index].numberOfSeats,
                    index: index,
                    id: busroutes.busRoutes[index].routeId,
                  );
                },
              ),
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 20, right: 20),
        child: FloatingActionButton(
          backgroundColor: kPrimaryColor,
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return const AddRoute();
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
      ),
    );
  }
}
