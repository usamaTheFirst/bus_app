import 'package:bus_ticket_app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../exports.dart';

class ViewHistory extends StatelessWidget {
  const ViewHistory({Key? key}) : super(key: key);

  static const routeName = "/view-history";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const DrawerWidget(),
        appBar: AppBar(
          title: const Text(
            'Travel History',
          ),
          backgroundColor: kPrimaryColor,
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: Provider.of<UserData>(context, listen: false).getHistory(),
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
                    itemCount: udata.history.length,
                    itemBuilder: (context, index) {
                      return BookingTile(
                        source: udata.history[index].source,
                        destination: udata.history[index].destination,
                        time: Timestamp.fromDate(
                          DateTime.now(),
                        ),
                        price: int.parse(udata.history[index].price),
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
