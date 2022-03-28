import 'package:flutter/material.dart';

class BusRoute {
  late String routeId;
  late String source;
  late String destination;
  late String busNumber;
  late String driverName;
  late String price;
  late TimeOfDay time;

  //write constructor
  BusRoute(
      {required this.routeId,
      required this.source,
      required this.destination,
      required this.busNumber,
      required this.driverName,
      required this.price,
      required this.time});
}
