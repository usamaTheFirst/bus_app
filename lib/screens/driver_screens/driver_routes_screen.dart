import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/driver_list.dart';
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
        body: FutureBuilder(
            future:
                Provider.of<DriverData>(context, listen: false).getNewRoutes(),
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
                      itemCount: ddata.newRoutes.length,
                      itemBuilder: (context, index) {
                        return BookingTile(
                            source: ddata.newRoutes[index].source,
                            destination: ddata.newRoutes[index].destination,
                            time: ddata.newRoutes[index].time,
                            price: ddata.newRoutes[index].price);
                      },
                    );
                  },
                );
              }
            }));
  }
}
