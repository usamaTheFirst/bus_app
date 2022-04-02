import 'package:bus_ticket_app/models/bus_route_bag.dart';
import 'package:bus_ticket_app/screens/admin/assign_driver_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../exports.dart';

class BookingTileAdmin extends StatelessWidget {
  const BookingTileAdmin(
      {Key? key,
      required this.id,
      required this.source,
      required this.destination,
      required this.time,
      required this.price,
      required this.busNumber,
      required this.numberOfSeats,
      required this.index})
      : super(key: key);

  final String id;
  final String source;
  final String destination;
  final Timestamp time;
  final int price;
  final String busNumber;
  final int numberOfSeats;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 2,
        child: ListTile(
          minVerticalPadding: 20,
          title: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 18,
                color: kTextColor.withOpacity(.8),
              ),
              children: [
                const TextSpan(
                  text: 'Source: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: ' $source\n',
                ),
                const TextSpan(
                  text: 'Destination: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: ' $destination\n',
                ),
                WidgetSpan(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                  ),
                ),
                const TextSpan(
                  text: 'Price: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: ' Rs. $price\n',
                ),
                const TextSpan(
                  text: 'Bus Number: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: ' $busNumber\n',
                ),
                const TextSpan(
                  text: 'No. of Seats: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: ' $numberOfSeats',
                ),
                WidgetSpan(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                  ),
                ),
                const TextSpan(
                  text: 'Date: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text:
                      ' ${DateFormat("dd-MM-yyyy").format(DateTime.parse(time.toDate().toString()))}\n',
                ),
                const TextSpan(
                  text: 'Time: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text:
                      ' ${DateFormat.jm().format(DateTime.fromMicrosecondsSinceEpoch(time.microsecondsSinceEpoch))}\n',
                ),
                WidgetSpan(
                  child: Container(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: const Divider(
                      thickness: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          subtitle: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      child: const Text('Delete',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: kPrimaryColor)),
                      onPressed: () {
                        Provider.of<BusRouteBag>(context, listen: false)
                            .deleteBusRoute(id);
                      }),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: kPrimaryColor,
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 34,
                        ),
                      ),
                      child: const Text('Edit',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.normal)),
                      onPressed: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return EditRoute(
                              id: id,
                              source: source,
                              destination: destination,
                              price: price,
                              busNumber: busNumber,
                              numberOfSeats: numberOfSeats,
                              time: time,
                            );
                          },
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                        );
                      }),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: kTextColor,
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 34,
                        ),
                      ),
                      child: const Text('Assign Driver',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.normal)),
                      onPressed: () {
                        Navigator.pushNamed(
                            context, AssignDriverScreen.routeName,
                            arguments: id);
                      }),
                ],
              ),
            ],
          ),
          textColor: kTextColor,
        ),
      ),
    );
  }
}
