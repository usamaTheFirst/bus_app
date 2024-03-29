import 'package:bus_ticket_app/models/driver_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../exports.dart';

class AssignDriverScreen extends StatelessWidget {
  const AssignDriverScreen({Key? key}) : super(key: key);

  static const String routeName = '/assign-driver-screen';
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select A Driver'),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
      ),
      body: FutureBuilder(
          future:
              Provider.of<DriverList>(context, listen: false).fetchDrivers(),
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
              return Consumer<DriverList>(
                builder: (context, ddata, child) {
                  return ListView.builder(
                    itemCount: ddata.drivers.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(ddata.drivers[index].name.toString()),
                        onTap: () async {
                          await ddata.assignDriver(index, id);
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  );
                },
              );
            }
          }),
    );
  }
}
