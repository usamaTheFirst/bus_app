import 'package:bus_ticket_app/models/driver_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
        body: FutureBuilder(
            future:
                Provider.of<DriverData>(context, listen: false).getPastRoutes(),
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
                return Consumer<DriverData>(
                  builder: (context, ddata, child) {
                    return ListView.builder(
                      itemCount: ddata.pastRoutes.length,
                      itemBuilder: (context, index) {
                        return BookingTile(
                            source: ddata.pastRoutes[index].source,
                            destination: ddata.pastRoutes[index].destination,
                            time: ddata.pastRoutes[index].time,
                            price: ddata.pastRoutes[index].price);
                      },
                    );
                  },
                );
              }
            }));
  }
}
