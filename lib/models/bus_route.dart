import 'package:flutter/material.dart';

class BusRoute {
  late String routeId;
  late String source;
  late String destination;
  late String busNumber;
  late String price;
  late TimeOfDay time;

  //write constructor
  BusRoute(
      {required this.routeId,
      required this.source,
      required this.destination,
      required this.busNumber,
      required this.price,
      required this.time});

  toJson() {
    return {
      'routeId': routeId,
      'source': source,
      'destination': destination,
      'busNumber': busNumber,
      'price': price,
      'time': time.toString(),
    };
  }

  factory BusRoute.fromJson(Map<String, dynamic> json) {
    return BusRoute(
      routeId: json['routeId'],
      source: json['source'],
      destination: json['destination'],
      busNumber: json['busNumber'],
      price: json['price'],
      time: TimeOfDay.fromDateTime(DateTime.parse(json['time'])),
    );
  }
}
